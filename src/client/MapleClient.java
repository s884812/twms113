/*
 This file is part of the OdinMS Maple Story Server
 Copyright (C) 2008 ~ 2010 Patrick Huy <patrick.huy@frz.cc> 
 Matthias Butz <matze@odinms.de>
 Jan Christian Meyer <vimes@odinms.de>

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License version 3
 as published by the Free Software Foundation. You may not use, modify
 or distribute this program under any other version of the
 GNU Affero General Public License.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ScheduledFuture;

import javax.script.ScriptEngine;

import database.DatabaseConnection;
import database.DatabaseException;
import handling.MaplePacket;
import handling.cashshop.CashShopServer;
import handling.channel.ChannelServer;
import handling.login.handler.LoginResponse;
import handling.world.MapleMessengerCharacter;
import handling.world.MapleParty;
import handling.world.MaplePartyCharacter;
import handling.world.PartyOperation;
import handling.world.World;
import handling.world.family.MapleFamilyCharacter;
import handling.world.guild.MapleGuildCharacter;
import java.io.UnsupportedEncodingException;
import static java.lang.Math.log;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import server.maps.MapleMap;
import server.shops.IMaplePlayerShop;
import tools.MapleAESOFB;
import tools.packet.LoginPacket;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import org.apache.mina.core.session.IoSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import server.Timer.PingTimer;
import server.quest.MapleQuest;
import tools.FilePrinter;
import tools.HexTool;
import tools.MaplePacketCreator;

public class MapleClient {

    private static final Logger log = LoggerFactory.getLogger(MapleClient.class);
    public static final transient byte LOGIN_NOTLOGGEDIN = 0;
    public static final transient byte LOGIN_SERVER_TRANSITION = 1;
    public static final transient byte LOGIN_LOGGEDIN = 2;
    public static final transient byte LOGIN_WAITING = 3;
    public static final transient byte CASH_SHOP_TRANSITION = 4;
    public static final transient byte LOGIN_CS_LOGGEDIN = 5;
    public static final transient byte CHANGE_CHANNEL = 6;
    public static final int DEFAULT_CHARSLOT = 3;
    public static final String CLIENT_KEY = "CLIENT";
    private final MapleAESOFB send, receive;
    private final IoSession session;
    private MapleCharacter player;
    private int accountId = 1;
    private String accountName;
    private int world = 0;
    private int channel = 1;
    private int birthday;
    private int charslots = DEFAULT_CHARSLOT;
    private boolean loggedIn = false, serverTransition = false;
    private transient Calendar tempban = null;
    private transient long lastPong = 0, lastPing = 0;
    private boolean monitored = false, receiving = true;
    private boolean gm;

    private byte bannedReason = 1, gender = -1;
    public transient short loginAttempt = 0;
    private final transient List<Integer> allowedChar = new LinkedList<>();
    private final transient Set<String> macs = new HashSet<>();
    private String LoginMacs = "";
    private final transient Map<String, ScriptEngine> engines = new HashMap<>();
    private transient ScheduledFuture<?> idleTask = null;
    private transient String secondPassword; // To be used only on login
    private final transient Lock mutex = new ReentrantLock(true);
    private final transient Lock npcMutex = new ReentrantLock();
    private long lastNpcClick = 0;
    private final static Lock loginMutex = new ReentrantLock(true);

    public MapleClient(MapleAESOFB send, MapleAESOFB receive, IoSession session) {
        this.send = send;
        this.receive = receive;
        this.session = session;
    }

    public final MapleAESOFB getReceiveCrypto() {
        return receive;
    }

    public final MapleAESOFB getSendCrypto() {
        return send;
    }

    public final IoSession getSession() {
        return session;
    }

    public final Lock getLock() {
        return mutex;
    }

    public final Lock getNPCLock() {
        return npcMutex;
    }

    public MapleCharacter getPlayer() {
        return player;
    }

    public void setPlayer(MapleCharacter player) {
        this.player = player;
    }

    public void createdChar(final int id) {
        allowedChar.add(id);
    }

    public final boolean login_Auth(final int id) {
        return allowedChar.contains(id);
    }

    public final List<MapleCharacter> loadCharacters(final int serverId) { // TODO make this less costly zZz
        final List<MapleCharacter> chars = new LinkedList<>();

        for (final CharNameAndId cni : loadCharactersInternal(serverId)) {
            final MapleCharacter chr = MapleCharacter.loadCharFromDB(cni.id, this, false);
            chars.add(chr);
            allowedChar.add(chr.getId());
        }
        return chars;
    }

    public List<String> loadCharacterNames(int serverId) {
        List<String> chars = new LinkedList<>();
        for (CharNameAndId cni : loadCharactersInternal(serverId)) {
            chars.add(cni.name);
        }
        return chars;
    }

    private List<CharNameAndId> loadCharactersInternal(int serverId) {
        List<CharNameAndId> chars = new LinkedList<>();

        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement("SELECT id, name FROM characters WHERE accountid = ? AND world = ?")) {
            ps.setInt(1, accountId);
            ps.setInt(2, serverId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    chars.add(new CharNameAndId(rs.getString("name"), rs.getInt("id")));
                }
            }

        } catch (SQLException e) {
            System.err.println("error loading characters internal" + e);
        }
        return chars;
    }

    public boolean isLoggedIn() {
        return loggedIn;
    }

    private Calendar getTempBanCalendar(ResultSet rs) throws SQLException {
        Calendar lTempban = Calendar.getInstance();
        if (rs.getLong("tempban") == 0) { // basically if timestamp in db is 0000-00-00
            lTempban.setTimeInMillis(0);
            return lTempban;
        }
        Calendar today = Calendar.getInstance();
        lTempban.setTimeInMillis(rs.getTimestamp("tempban").getTime());
        if (today.getTimeInMillis() < lTempban.getTimeInMillis()) {
            return lTempban;
        }

        lTempban.setTimeInMillis(0);
        return lTempban;
    }

    public Calendar getTempBanCalendar() {
        return tempban;
    }

    public byte getBanReason() {
        return bannedReason;
    }

    public boolean isBannedIP(String ip) {
        boolean ret = false;
        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM ipbans WHERE ? LIKE CONCAT(ip, '%')")) {
            ps.setString(1, ip);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                if (rs.getInt(1) > 0) {
                    ret = true;
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error checking ip bans" + ex);
        }
        return ret;
    }

    public boolean hasBannedIP() {
        boolean ret = false;

        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM ipbans WHERE ? LIKE CONCAT(ip, '%')")) {
            ps.setString(1, session.getRemoteAddress().toString());
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                if (rs.getInt(1) > 0) {
                    ret = true;
                }
            }

        } catch (SQLException ex) {
            System.err.println("Error checking ip bans" + ex);
        }
        return ret;
    }

    public void banIP() {
        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement("INSERT INTO ipbans VALUES (DEFAULT, ?)")) {
            ps.setString(1, getSession().getRemoteAddress().toString().split(":")[0]);
            ps.execute();
        } catch (SQLException e) {
            System.err.println("Error ban ip " + e);
        }
    }

    public static boolean banMacs(String macData) {
        if (macData.equalsIgnoreCase("00-00-00-00-00-00") || macData.length() != 17) {
            return false;
        }
        try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement("INSERT INTO macbans (mac) VALUES (?)")) {
            ps.setString(1, macData);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error banning MACs" + e);
            return false;
        }
        return true;
    }

    public final String getLoginMacs() {
        return LoginMacs;
    }

    public void setLoginMacs(String macData) {
        LoginMacs = macData;
    }

    public final Set<String> getMacs() {
        return Collections.unmodifiableSet(macs);
    }

    public void setMacs(String macData) {
        if (macs != null) {
            try {
                if (!"00-00-00-00-00-00".equals(macData) && !macData.isEmpty()) {
                    macs.addAll(Arrays.asList(macData.split(", ")));
                }
            } catch (Exception ex) {
            }
        }
    }

    public void updateMacs(String macData) {
        try {
            macs.addAll(Arrays.asList(macData.split(", ")));
        } catch (Exception ex) {
        }
        StringBuilder newMacData = new StringBuilder();
        Iterator<String> iter = macs.iterator();
        while (iter.hasNext()) {
            String ip = iter.next();
            if (!"00-00-00-00-00-00".equals(ip)) {
                newMacData.append(ip);
            }
            if (iter.hasNext()) {
                if (!"00-00-00-00-00-00".equals(ip)) {
                    newMacData.append(", ");
                }
            }
        }
        try {
            Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("UPDATE accounts SET macs = ? WHERE id = ?")) {
                ps.setString(1, newMacData.toString());
                ps.setInt(2, accountId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            System.err.println("Error saving MACs" + e);
        }
    }

    public boolean isBannedMac(String mac) {
        if (mac.equalsIgnoreCase("00-00-00-00-00-00") || mac.length() != 17) {
            return false;
        }
        boolean ret = false;
        try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement("SELECT COUNT(*) FROM macbans WHERE mac = ?")) {
            ps.setString(1, mac);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                if (rs.getInt(1) > 0) {
                    ret = true;
                }
            }
            ps.close();
        } catch (SQLException ex) {
            System.err.println("Error checking mac bans" + ex);
        }
        return ret;
    }

    public boolean hasBannedMac() {
        if (macs.isEmpty()) {
            return false;
        }
        boolean ret = false;
        int i;
        try {
            Connection con = DatabaseConnection.getConnection();
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM macbans WHERE mac IN (");
            for (i = 0; i < macs.size(); i++) {
                sql.append("?");
                if (i != macs.size() - 1) {
                    sql.append(", ");
                }
            }
            sql.append(")");
            try (PreparedStatement ps = con.prepareStatement(sql.toString())) {
                i = 0;
                for (String mac : macs) {
                    i++;
                    ps.setString(i, mac);
                }
                try (ResultSet rs = ps.executeQuery()) {
                    rs.next();
                    if (rs.getInt(1) > 0) {
                        ret = true;
                    }
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error checking mac bans" + ex);
        }
        return ret;
    }

    private void loadMacsIfNescessary() throws SQLException {
        if (macs.isEmpty()) {
            Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("SELECT macs FROM accounts WHERE id = ?")) {
                ps.setInt(1, accountId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        if (rs.getString("macs") != null) {
                            String[] macData;
                            macData = rs.getString("macs").split(", ");
                            for (String mac : macData) {
                                if (!mac.equals("")) {
                                    macs.add(mac);
                                }
                            }
                        }
                    } else {
                        rs.close();
                        ps.close();
                        throw new RuntimeException("No valid account associated with this client.");
                    }
                }
            }
        }
    }

    public void banMacs() {
        try {
            loadMacsIfNescessary();
            if (this.macs.size() > 0) {
                String[] macBans = new String[this.macs.size()];
                int z = 0;
                for (String mac : this.macs) {
                    macBans[z] = mac;
                    z++;
                }
                banMacs(macBans);
            }
        } catch (SQLException e) {
        }
    }

    public static void banMacs(String[] macs) {
        Connection con = DatabaseConnection.getConnection();
        try {
            List<String> filtered = new LinkedList<>();
            PreparedStatement ps = con.prepareStatement("SELECT filter FROM macfilters");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                filtered.add(rs.getString("filter"));
            }
            rs.close();
            ps.close();

            ps = con.prepareStatement("INSERT INTO macbans (mac) VALUES (?)");
            for (String mac : macs) {
                boolean matched = false;
                for (String filter : filtered) {
                    if (mac.matches(filter)) {
                        matched = true;
                        break;
                    }
                }
                if (!matched) {
                    ps.setString(1, mac);
                    try {
                        ps.executeUpdate();
                    } catch (SQLException e) {
                        // can fail because of UNIQUE key, we dont care
                    }
                }
            }
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error banning MACs" + e);
        }
    }

    public int finishLogin() {
        loginMutex.lock();
        try {
            final byte state = getLoginState();
            if (state > MapleClient.LOGIN_NOTLOGGEDIN && state != MapleClient.LOGIN_WAITING) { // already loggedin
                loggedIn = false;
                return 7;
            }
            updateLoginState(MapleClient.LOGIN_LOGGEDIN, getSessionIPAddress());
        } finally {
            loginMutex.unlock();
        }
        return 0;
    }

    public int fblogin(String login, String pwd, boolean ipMacBanned) {
        int loginok = 5;
        try {
            Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("SELECT * FROM accounts WHERE facebook_id = ?")) {
                ps.setString(1, login);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        final int banned = rs.getInt("banned");
                        final String passhash = rs.getString("password");
                        final String salt = rs.getString("salt");
                        final String password_otp = rs.getString("password_otp");

                        accountId = rs.getInt("id");
                        secondPassword = rs.getString("2ndpassword");
                        gm = rs.getInt("gm") > 0;
                        bannedReason = rs.getByte("greason");
                        tempban = getTempBanCalendar(rs);
                        gender = rs.getByte("gender");

                        ps.close();

                        if (banned > 0 && !gm) {
                            loginok = 3;
                        } else {
                            if (banned == -1) {
                                unban();
                            }
                            byte loginstate = 0;//getLoginState();
                            if (loginstate > MapleClient.LOGIN_NOTLOGGEDIN) { // already loggedin
                                loggedIn = false;
                                loginok = 7;
                                if (pwd.equalsIgnoreCase("fixedlog")) {
                                    try {
                                        try (PreparedStatement pss = con.prepareStatement("UPDATE accounts SET loggedin = 0 WHERE name = ?")) {
                                            pss.setString(1, login);
                                            pss.executeUpdate();
                                        }
                                        sendPacket(MaplePacketCreator.getPopupMsg("帳號解卡成功,請重新登入!"));
                                    } catch (SQLException se) {
                                    }
                                }
                            } else {
                                boolean updatePasswordHash = false;
                                boolean updatePasswordHashtosha1 = false;
                                // Check if the passwords are correct here. :B
                                if (password_otp.equals(pwd)) {
                                    // Check if a password upgrade is needed.
                                    loginok = 0;

                                } else if (LoginCrypto.checkSaltedSha512Hash(passhash, pwd, salt)) {
                                    loginok = 0;
                                    updatePasswordHashtosha1 = true;
                                } else {
                                    loggedIn = false;
                                    loginok = 4;
                                }
                                if (secondPassword != null) {
                                    try (PreparedStatement pss = con.prepareStatement("UPDATE `accounts` SET `password_otp` = ?")) {

                                        pss.setString(1, "");
                                        pss.executeUpdate();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("ERROR" + e);
        }
        return loginok;
    }

    private boolean updateSaltedPasswordHash(String password) {
        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement pss = con.prepareStatement("UPDATE `accounts` SET `password` = ?, `salt` = ? WHERE id = ?")) {
            final String newSalt = LoginCrypto.makeSalt();
            pss.setString(1, LoginCrypto.makeSaltedSha512Hash(password, newSalt));
            pss.setString(2, newSalt);
            pss.setInt(3, accountId);
            pss.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    private boolean updatePasswordHash(String password) {
        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement pss = con.prepareStatement("UPDATE `accounts` SET `password` = ? WHERE id = ?")) {
            pss.setString(1, LoginCrypto.hexSha1(password));
            pss.setInt(2, accountId);
            pss.executeUpdate();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    private boolean checkLoginPassword(String password, String hash, String salt) {
        if (LoginCryptoLegacy.isLegacyPassword(hash)
                && LoginCryptoLegacy.checkPassword(password, hash)) {
            return true;
        }
        if (salt == null
                && LoginCrypto.checkSha1Hash(hash, password)) {
            return true;
        }
        return LoginCrypto.checkSaltedSha512Hash(hash, password, salt);
    }

    public LoginResponse login(String account, String password) {
        if (hasBannedIP()) {
            return LoginResponse.IP_NOT_ALLOWED;
        } else if (hasBannedMac()) {
            return LoginResponse.ACCOUNT_BLOCKED;
        }

        int db_banned = 0;
        String db_passwordHash = "";
        String db_passwordSalt = "";
        String db_SessionIP = "";
        String db_macs = "";
        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement("SELECT id, banned, password, salt, macs, 2ndpassword, gm, greason, tempban, gender, SessionIP FROM accounts WHERE name = ?")) {
            ps.setString(1, account);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    db_banned = rs.getInt("banned");
                    db_passwordHash = rs.getString("password");
                    db_passwordSalt = rs.getString("salt");
                    db_SessionIP = rs.getString("SessionIP");
                    db_macs = rs.getString("macs");
                    accountId = rs.getInt("id");
                    secondPassword = rs.getString("2ndpassword");
                    gm = rs.getInt("gm") > 0;
                    bannedReason = rs.getByte("greason");
                    tempban = getTempBanCalendar(rs);
                    gender = rs.getByte("gender");
                    ps.close();
                } else {
                    return LoginResponse.NOT_REGISTERED;
                }
            }
        } catch (SQLException e) {
            FilePrinter.print(FilePrinter.LoginError, "Account : " + account + " login raise some exception !" + e.getMessage());
            return LoginResponse.SYSTEM_ERROR;

        }

        boolean updatePasswordHash = false;
        if (!checkLoginPassword(password, db_passwordHash, db_passwordSalt)) {
            if (password.equals(db_passwordHash)) {
                updatePasswordHash = true;
            } else {
                loggedIn = false;
                return LoginResponse.WRONG_PASSWORD;
            }
        }

        if (db_banned > 0 && !isGm()) {
            return LoginResponse.ACCOUNT_BLOCKED;
        }

        int loginState = getLoginState();
        if (loginState > 0) {
            return LoginResponse.ALREADY_LOGGED_IN;
        }

        if (isGm()) {
            updateSaltedPasswordHash(password);
        } else if (updatePasswordHash) {
            updatePasswordHash(password);
        }

        ChannelServer.forceRemovePlayerByAccId(this, accountId);
        this.updateLoginState(MapleClient.LOGIN_NOTLOGGEDIN, this.getSessionIPAddress());

        return LoginResponse.LOGIN_SUCCESS;
    }

    public final void unLockDisconnect(boolean removeFromChannel, boolean fromCS) {
        sendPacket(MaplePacketCreator.getPopupMsg("當前賬號在別處登入\r\n若不是你本人操作請及時更改密碼。"));
        this.disconnect(removeFromChannel, fromCS);
    }

    public void logout() {
        try {
            Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = null;
            ps = con.prepareStatement("UPDATE accounts SET loggedin = 0 WHERE name = ? and SessionIP = ?");
            ps.setString(1, this.getAccountName());
            ps.setString(2, this.getSessionIPAddress());
            ps.execute();
            ps.close();

        } catch (SQLException ex) {
            FilePrinter.printError("logouterror.txt", ex);
        }
    }

    public void loadAccountData(int accountID) {
        Connection con = DatabaseConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = con.prepareStatement("SELECT id, macs, name, 2ndpassword, gm, greason, gender, tempban FROM accounts WHERE id = ?");
            ps.setInt(1, accountID);
            rs = ps.executeQuery();
            if (rs.next()) {
                setMacs(rs.getString("macs"));
                accountId = rs.getInt("id");
                secondPassword = rs.getString("2ndpassword");
                gm = rs.getInt("gm") > 0;
                bannedReason = rs.getByte("greason");
                tempban = getTempBanCalendar(rs);
                gender = rs.getByte("gender");
                accountName = rs.getString("name");
                ps.close();
                rs.close();
            }
        } catch (SQLException e) {
            FilePrinter.printError("MapleClient.txt", e);
        } finally {
            try {
                if (ps != null && !ps.isClosed()) {
                    ps.close();
                }
                if (rs != null && !rs.isClosed()) {
                    rs.close();
                }
            } catch (SQLException e) {
            }
        }
    }

    public final void update2ndPassword() {

        try {

            MessageDigest digester = MessageDigest.getInstance("SHA-1");
            digester.update(secondPassword.getBytes("UTF-8"), 0, secondPassword.length());
            String hash = HexTool.toString(digester.digest()).replace(" ", "").toLowerCase();

            final Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("UPDATE `accounts` SET `2ndpassword` = ? WHERE id = ?")) {
                ps.setString(1, hash);
                ps.setInt(2, accountId);
                ps.executeUpdate();

            } catch (SQLException ex) {
                FilePrinter.printError("MapleClient.txt", ex);

            }
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
            log.error("", ex);

        }
    }

    private void unban() {
        try {
            Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("UPDATE accounts SET banned = 0 and banreason = '' WHERE id = ?")) {
                ps.setInt(1, accountId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            System.err.println("Error while unbanning" + e);
        }
    }

    public static final byte unban(String charname) {
        try {
            Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT accountid from characters where name = ?");
            ps.setString(1, charname);

            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                rs.close();
                ps.close();
                return -1;
            }
            final int accid = rs.getInt(1);
            rs.close();
            ps.close();

            ps = con.prepareStatement("UPDATE accounts SET banned = 0 and banreason = '' WHERE id = ?");
            ps.setInt(1, accid);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            System.err.println("Error while unbanning" + e);
            return -2;
        }
        return 0;
    }

    public void setAccID(int id) {
        this.accountId = id;
    }

    public int getAccID() {
        return this.accountId;
    }

    public final void updateLoginState(final int newstate, final String SessionID) { // TODO hide?
        Connection con = DatabaseConnection.getConnection();
        try (PreparedStatement ps = con.prepareStatement("UPDATE accounts SET loggedin = ?, SessionIP = ?, lastlogin = CURRENT_TIMESTAMP() WHERE id = ?")) {
            ps.setInt(1, newstate);
            ps.setString(2, SessionID);
            ps.setInt(3, getAccID());
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("error updating login state" + e);
        }
        if (newstate == MapleClient.LOGIN_NOTLOGGEDIN || newstate == MapleClient.LOGIN_WAITING) {
            loggedIn = false;
            serverTransition = false;
        } else {
            serverTransition = (newstate == MapleClient.LOGIN_SERVER_TRANSITION || newstate == MapleClient.CHANGE_CHANNEL);
            loggedIn = !serverTransition;
        }
    }

    public final void updateSecondPassword() {

        final Connection con = DatabaseConnection.getConnection();

        try (PreparedStatement ps = con.prepareStatement("UPDATE `accounts` SET `2ndpassword` = ? WHERE id = ?")) {
            ps.setString(1, LoginCrypto.hexSha1(this.secondPassword));
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("error updating login state" + e);
        }
    }

    public final void updateGender() {

        final Connection con = DatabaseConnection.getConnection();

        try (PreparedStatement ps = con.prepareStatement("UPDATE `accounts` SET `gender` = ? WHERE id = ?")) {
            ps.setInt(1, gender);
            ps.setInt(2, accountId);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("error updating gender" + e);
        }
    }

    public final byte getLoginState() { // TODO hide?
        Connection con = DatabaseConnection.getConnection();
        try {
            PreparedStatement ps;
            ps = con.prepareStatement("SELECT loggedin, lastlogin, `birthday` + 0 AS `bday` FROM accounts WHERE id = ?");
            ps.setInt(1, getAccID());
            byte state;
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    ps.close();
                    throw new DatabaseException("Everything sucks");
                }
                birthday = rs.getInt("bday");
                state = rs.getByte("loggedin");

                if (state == MapleClient.LOGIN_SERVER_TRANSITION || state == MapleClient.CHANGE_CHANNEL) {
                    if (rs.getTimestamp("lastlogin").getTime() + 20000 < System.currentTimeMillis()) { // connecting to chanserver timeout
                        state = MapleClient.LOGIN_NOTLOGGEDIN;
                        updateLoginState(state, getSessionIPAddress());
                    }
                }
            }
            ps.close();
            loggedIn = state == MapleClient.LOGIN_LOGGEDIN;
            return state;
        } catch (SQLException e) {
            loggedIn = false;
            throw new DatabaseException("error getting login state", e);
        }
    }

    public final boolean checkBirthDate(final int date) {
        return birthday == date;
    }

    public final void removalTask(boolean shutdown) {
        try {
            player.cancelAllBuffs_();
            player.cancelAllDebuffs();
            if (player.getMarriageId() > 0) {
                final MapleQuestStatus stat1 = player.getQuestNAdd(MapleQuest.getInstance(160001));
                final MapleQuestStatus stat2 = player.getQuestNAdd(MapleQuest.getInstance(160002));
                if (stat1.getCustomData() != null && (stat1.getCustomData().equals("2_") || stat1.getCustomData().equals("2"))) {
                    //dc in process of marriage
                    if (stat2.getCustomData() != null) {
                        stat2.setCustomData("0");
                    }
                    stat1.setCustomData("3");
                }
            }
            player.changeRemoval(true);
            if (player.getEventInstance() != null) {
                player.getEventInstance().playerDisconnected(player);
            }
            if (player.getMap() != null) {
                switch (player.getMapId()) {
                    case 541010100: //latanica
                    case 541020800: //scar/targa
                    case 551030200: //krexel
                    case 220080001: //pap
                    case 501030105: // 六手邪神
                        player.getMap().addDisconnected(player.getId());
                        break;
                }
                player.getMap().removePlayer(player);
            }
            synchronized (this) {//精靈商人東西修復
                final IMaplePlayerShop shop = player.getPlayerShop();
                if (shop != null) {
                    shop.removeVisitor(player);
                    if (shop.isOwner(player)) {
                        if (shop.getShopType() == 1 && shop.isAvailable() && !shutdown) {
                            shop.setOpen(true);
                        } else {
                            shop.closeShop(true, !shutdown);
                        }
                    }
                }
            }
            player.setMessenger(null);
        } catch (final Throwable e) {
            FilePrinter.printError(FilePrinter.AccountStuck, e);

        }
    }

    public final void disconnect(final boolean RemoveInChannelServer, final boolean fromCS) {
        disconnect(RemoveInChannelServer, fromCS, false);
    }

    public final void disconnect(final boolean RemoveInChannelServer, final boolean fromCS, final boolean shutdown) {

        if (player != null && isLoggedIn()) {
            MapleMap map = player.getMap();
            final MapleParty party = player.getParty();
            final boolean clone = player.isClone();
            final String namez = player.getName();
            final boolean hidden = player.isHidden();
            final int gmLevel = player.getGMLevel();
            final int idz = player.getId(),
                    messengerid = player.getMessenger() == null ? 0 : player.getMessenger().getId(),
                    gid = player.getGuildId(),
                    fid = player.getFamilyId();
            final BuddyList bl = player.getBuddylist();
            final MaplePartyCharacter chrp = new MaplePartyCharacter(player);
            final MapleMessengerCharacter chrm = new MapleMessengerCharacter(player);
            final MapleGuildCharacter chrg = player.getMGC();
            final MapleFamilyCharacter chrf = player.getMFC();
            player.disposeSchedules();

            removalTask(shutdown);
            player.saveToDB(true, fromCS);
            if (shutdown) {
                player = null;
                receiving = false;
                return;
            }

            if (!fromCS) {
                final ChannelServer ch = ChannelServer.getInstance(map == null ? channel : map.getChannel());
                try {
                    if (ch == null || clone || ch.isShutdown()) {
                        player = null;
                        return;//no idea
                    }
                    if (messengerid > 0) {
                        World.Messenger.leaveMessenger(messengerid, chrm);
                    }
                    if (party != null) {
                        chrp.setOnline(false);
                        World.Party.updateParty(party.getId(), PartyOperation.LOG_ONOFF, chrp);
                        if (map != null && party.getLeader().getId() == idz) {
                            MaplePartyCharacter lchr = null;
                            for (MaplePartyCharacter pchr : party.getMembers()) {
                                if (pchr != null && map.getCharacterById(pchr.getId()) != null && (lchr == null || lchr.getLevel() < pchr.getLevel())) {
                                    lchr = pchr;
                                }
                            }
                            if (lchr != null) {
                                World.Party.updateParty(party.getId(), PartyOperation.CHANGE_LEADER_DC, lchr);
                            }
                        }
                    }
                    if (bl != null) {
                        if (!serverTransition && isLoggedIn()) {
                            World.Buddy.loggedOff(namez, idz, channel, bl.getBuddiesIds(), gmLevel, hidden);
                        } else { // Change channel
                            World.Buddy.loggedOn(namez, idz, channel, bl.getBuddiesIds(), gmLevel, hidden);
                        }
                    }
                    if (gid > 0) {
                        World.Guild.setGuildMemberOnline(chrg, false, -1);
                    }
                    if (fid > 0) {
                        World.Family.setFamilyMemberOnline(chrf, false, -1);
                    }
                } catch (final Exception e) {
                    FilePrinter.printError(FilePrinter.AccountStuck, e);

                } finally {
                    if (RemoveInChannelServer && ch != null) {

                        ch.removePlayer(idz, namez);
                    }
                    player = null;
                    
                }
            } else {
                final int ch = World.Find.findChannel(idz);
                if (ch > 0) {
                    disconnect(RemoveInChannelServer, false);//u lie
                    return;
                }
                try {
                    if (party != null) {
                        chrp.setOnline(false);
                        World.Party.updateParty(party.getId(), PartyOperation.LOG_ONOFF, chrp);
                    }
                    if (!serverTransition && isLoggedIn()) {
                        World.Buddy.loggedOff(namez, idz, channel, bl.getBuddiesIds(), gmLevel, hidden);
                    } else { // Change channel
                        World.Buddy.loggedOn(namez, idz, channel, bl.getBuddiesIds(), gmLevel, hidden);
                    }
                    if (gid > 0) {
                        World.Guild.setGuildMemberOnline(chrg, false, -1);
                    }
                    if (player != null) {
                        player.setMessenger(null);
                    }
                } catch (final Exception e) {
                    FilePrinter.printError(FilePrinter.AccountStuck, e);

                } finally {
                    if (RemoveInChannelServer && ch > 0) {
                        CashShopServer.getPlayerStorage().deregisterPlayer(idz, namez);
                    }
                    player = null;
                    
                }
            }

            if (!serverTransition && isLoggedIn()) {
                updateLoginState(MapleClient.LOGIN_NOTLOGGEDIN, getSessionIPAddress());
            }
            
            if(player == null) {
                this.getSession().close(true);
            }

        }
    }

    public final String getSessionIPAddress() {
        return session.getRemoteAddress().toString().split(":")[0];
    }

    public final boolean CheckIPAddress() {
        try {
            boolean canlogin;
            try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement("SELECT SessionIP FROM accounts WHERE id = ?")) {
                ps.setInt(1, this.accountId);
                try (ResultSet rs = ps.executeQuery()) {
                    canlogin = false;
                    if (rs.next()) {
                        final String sessionIP = rs.getString("SessionIP");

                        if (sessionIP != null) { // Probably a login proced skipper?
                            canlogin = getSessionIPAddress().equals(sessionIP.split(":")[0]);
                        }
                    }
                }
            }

            return canlogin;
        } catch (final SQLException e) {
            System.out.println("Failed in checking IP address for client.");
        }
        return true;
    }

    public final void DebugMessage(final StringBuilder sb) {
        sb.append(getSession().getRemoteAddress());
        sb.append("Connected: ");
        sb.append(getSession().isConnected());
        sb.append(" Closing: ");
        sb.append(getSession().isClosing());
        sb.append(" ClientKeySet: ");
        sb.append(getSession().getAttribute(MapleClient.CLIENT_KEY) != null);
        sb.append(" loggedin: ");
        sb.append(isLoggedIn());
        sb.append(" has char: ");
        sb.append(getPlayer() != null);
    }

    public final int getChannel() {
        return channel;
    }

    public final ChannelServer getChannelServer() {
        return ChannelServer.getInstance(channel);
    }

    public final int deleteCharacter(final int cid) {
        Set<Integer> channels = ChannelServer.getAllChannels();
        for (Integer ch : channels) {
            MapleCharacter chr = ChannelServer.getInstance(ch).getPlayerStorage().getCharacterById(cid);
            if (chr != null) {
                ChannelServer.getInstance(ch).removePlayer(chr);
            }
        }
        try {
            final Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("SELECT guildid, guildrank, familyid, name FROM characters WHERE id = ? AND accountid = ?")) {
                ps.setInt(1, cid);
                ps.setInt(2, accountId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        rs.close();
                        ps.close();
                        return 1;
                    }
                    if (rs.getInt("guildid") > 0) { // is in a guild when deleted
                        if (rs.getInt("guildrank") == 1) { //cant delete when leader
                            rs.close();
                            ps.close();
                            return 1;
                        }
                        World.Guild.deleteGuildCharacter(rs.getInt("guildid"), cid);
                    }
                    if (rs.getInt("familyid") > 0) {
                        World.Family.getFamily(rs.getInt("familyid")).leaveFamily(cid);
                    }
                }
            }

            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM characters WHERE id = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM monsterbook WHERE charid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM hiredmerch WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM mts_cart WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM mts_items WHERE characterid = ?", cid);
            //MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM cheatlog WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM mountdata WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM inventoryitems WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM famelog WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM famelog WHERE characterid_to = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM dueypackages WHERE RecieverId = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM wishlist WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM buddies WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM buddies WHERE buddyid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM keymap WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM savedlocations WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM skills WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM mountdata WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM skillmacros WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM trocklocations WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM queststatus WHERE characterid = ?", cid);
            MapleCharacter.deleteWhereCharacterId(con, "DELETE FROM inventoryslot WHERE characterid = ?", cid);
            return 0;
        } catch (Exception e) {
            FilePrinter.printError("MapleCharacter.txt", e, "deleteCharacter");
        }
        return 1;
    }

    public final byte getGender() {
        return gender;
    }

    public final void setGender(final byte gender) {
        this.gender = gender;
    }

    public final String getSecondPassword() {
        return secondPassword;
    }

    public final void setSecondPassword(final String secondPassword) {
        this.secondPassword = secondPassword;
    }

    public final boolean isSetSecondPassword() {
        return !(this.gender == 10 || this.secondPassword == null || this.secondPassword.isEmpty());
    }

    public boolean check2ndPassword(String secondPassword) {
        boolean allow = false;
        // Check if the passwords are correct here. :B
        if (checkHash(this.secondPassword, "SHA-1", secondPassword)) {
            allow = true;
        }
        return allow;
    }

    public static boolean checkHash(String hash, String type, String password) {
        try {
            MessageDigest digester = MessageDigest.getInstance(type);
            digester.update(password.getBytes("UTF-8"), 0, password.length());
            return HexTool.toString(digester.digest()).replace(" ", "").toLowerCase().equals(hash);
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            throw new RuntimeException("Encoding the string failed", e);
        }
    }

    public final String getAccountName() {
        return accountName;
    }

    public final void setAccountName(final String accountName) {
        this.accountName = accountName;
    }

    public final void setChannel(final int channel) {
        this.channel = channel;
    }

    public final int getWorld() {
        return world;
    }

    public final void setWorld(final int world) {
        this.world = world;
    }

    public final int getLatency() {
        return (int) (lastPong - lastPing);
    }

    public final long getLastPong() {
        return lastPong;
    }

    public final long getLastPing() {
        return lastPing;
    }

    public final void pongReceived() {

        lastPong = System.currentTimeMillis();
    }

    public boolean canClickNPC() {
        return lastNpcClick + 500 < System.currentTimeMillis();
    }

    public void setClickedNPC() {
        lastNpcClick = System.currentTimeMillis();
    }

    public void removeClickedNPC() {
        lastNpcClick = 0;
    }

    public final void sendPing() {
        lastPing = System.currentTimeMillis();
        session.write(LoginPacket.getPing());
        PingTimer.getInstance().schedule(new Runnable() {
            @Override
            public void run() {
                try {
                    if (getLatency() < 0) {
                        MapleClient.this.setReceiving(false);
                        MapleClient.this.disconnect(true, false);
                    }
                } catch (final NullPointerException e) {
                    MapleClient.this.disconnect(true, false);
                }
            }
        }, 15000); // note: idletime gets added to this too
    }

    public static final String getLogMessage(final MapleClient cfor, final String message) {
        return getLogMessage(cfor, message, new Object[0]);
    }

    public static final String getLogMessage(final MapleCharacter cfor, final String message) {
        return getLogMessage(cfor == null ? null : cfor.getClient(), message);
    }

    public static final String getLogMessage(final MapleCharacter cfor, final String message, final Object... parms) {
        return getLogMessage(cfor == null ? null : cfor.getClient(), message, parms);
    }

    public static final String getLogMessage(final MapleClient cfor, final String message, final Object... parms) {
        final StringBuilder builder = new StringBuilder();
        if (cfor != null) {
            if (cfor.getPlayer() != null) {
                builder.append("<");
                builder.append(MapleCharacterUtil.makeMapleReadable(cfor.getPlayer().getName()));
                builder.append(" (cid: ");
                builder.append(cfor.getPlayer().getId());
                builder.append(")> ");
            }
            if (cfor.getAccountName() != null) {
                builder.append("(Account: ");
                builder.append(cfor.getAccountName());
                builder.append(") ");
            }
        }
        builder.append(message);
        int start;
        for (final Object parm : parms) {
            start = builder.indexOf("{}");
            builder.replace(start, start + 2, parm.toString());
        }
        return builder.toString();
    }

    public static final int findAccIdForCharacterName(final String charName) {
        try {
            Connection con = DatabaseConnection.getConnection();
            int ret;
            try (PreparedStatement ps = con.prepareStatement("SELECT accountid FROM characters WHERE name = ?")) {
                ps.setString(1, charName);
                try (ResultSet rs = ps.executeQuery()) {
                    ret = -1;
                    if (rs.next()) {
                        ret = rs.getInt("accountid");
                    }
                }
            }
            return ret;
        } catch (final SQLException e) {
            System.err.println("findAccIdForCharacterName SQL error");
        }
        return -1;
    }

    public final boolean isGm() {
        return gm;
    }

    public final void setScriptEngine(final String name, final ScriptEngine e) {
        engines.put(name, e);
    }

    public final ScriptEngine getScriptEngine(final String name) {
        return engines.get(name);
    }

    public final void removeScriptEngine(final String name) {
        engines.remove(name);
    }

    public final ScheduledFuture<?> getIdleTask() {
        return idleTask;
    }

    public final void setIdleTask(final ScheduledFuture<?> idleTask) {
        this.idleTask = idleTask;

    }

    public void sendPacket(byte[] data) {
        this.getSession().write(data);
    }

    protected static final class CharNameAndId {

        public final String name;
        public final int id;

        public CharNameAndId(final String name, final int id) {
            super();
            this.name = name;
            this.id = id;
        }
    }

    public int getCharacterSlots() {
        if (isGm()) {
            return 15;
        }
        if (charslots != DEFAULT_CHARSLOT) {
            return charslots; //save a sql
        }
        try {
            Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("SELECT * FROM character_slots WHERE accid = ? AND worldid = ?")) {
                ps.setInt(1, accountId);
                ps.setInt(2, world);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        charslots = rs.getInt("charslots");
                    } else {
                        try (PreparedStatement psu = con.prepareStatement("INSERT INTO character_slots (accid, worldid, charslots) VALUES (?, ?, ?)")) {
                            psu.setInt(1, accountId);
                            psu.setInt(2, world);
                            psu.setInt(3, charslots);
                            psu.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException sqlE) {
        }
        return charslots;
    }

    public boolean gainCharacterSlot() {
        if (getCharacterSlots() >= 15) {
            return false;
        }
        charslots++;

        try {
            Connection con = DatabaseConnection.getConnection();
            try (PreparedStatement ps = con.prepareStatement("UPDATE character_slots SET charslots = ? WHERE worldid = ? AND accid = ?")) {
                ps.setInt(1, charslots);
                ps.setInt(2, world);
                ps.setInt(3, accountId);
                ps.executeUpdate();
            }
        } catch (SQLException sqlE) {
            return false;
        }
        return true;
    }

    public static final byte unbanIPMacs(String charname) {
        try {
            Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT accountid from characters where name = ?");
            ps.setString(1, charname);

            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                rs.close();
                ps.close();
                return -1;
            }
            final int accid = rs.getInt(1);
            rs.close();
            ps.close();

            ps = con.prepareStatement("SELECT * FROM accounts WHERE id = ?");
            ps.setInt(1, accid);
            rs = ps.executeQuery();
            if (!rs.next()) {
                rs.close();
                ps.close();
                return -1;
            }
            final String sessionIP = rs.getString("sessionIP");
            final String macs = rs.getString("macs");
            rs.close();
            ps.close();
            byte ret = 0;
            if (sessionIP != null) {
                try (PreparedStatement psa = con.prepareStatement("DELETE FROM ipbans WHERE ip = ?")) {
                    psa.setString(1, sessionIP);
                    psa.execute();
                }
                ret++;
            }
            if (macs != null) {
                String[] macz = macs.split(", ");
                for (String mac : macz) {
                    if (!mac.equals("")) {
                        try (PreparedStatement psa = con.prepareStatement("DELETE FROM macbans WHERE mac = ?")) {
                            psa.setString(1, mac);
                            psa.execute();
                        }
                    }
                }
                ret++;
            }
            return ret;
        } catch (SQLException e) {
            System.err.println("Error while unbanning" + e);
            return -2;
        }
    }

    public static final byte unHellban(String charname) {
        try {
            Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT accountid from characters where name = ?");
            ps.setString(1, charname);

            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                rs.close();
                ps.close();
                return -1;
            }
            final int accid = rs.getInt(1);
            rs.close();
            ps.close();

            ps = con.prepareStatement("SELECT * FROM accounts WHERE id = ?");
            ps.setInt(1, accid);
            rs = ps.executeQuery();
            if (!rs.next()) {
                rs.close();
                ps.close();
                return -1;
            }
            final String sessionIP = rs.getString("sessionIP");
            final String email = rs.getString("email");
            rs.close();
            ps.close();
            ps = con.prepareStatement("UPDATE accounts SET banned = 0, banreason = '' WHERE email = ?" + (sessionIP == null ? "" : " OR sessionIP = ?"));
            ps.setString(1, email);
            if (sessionIP != null) {
                ps.setString(2, sessionIP);
            }
            ps.execute();
            ps.close();
            return 0;
        } catch (SQLException e) {
            System.err.println("Error while unbanning" + e);
            return -2;
        }
    }

    public static List<Integer> getLoggedIdsFromDB(int state) {
        List<Integer> ret = new ArrayList<>();
        try {
            Connection con = DatabaseConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT id from accounts where loggedin = ?");
            ps.setInt(1, state);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ret.add(rs.getInt("id"));
            }
        } catch (SQLException ex) {

        }
        return ret;
    }

    public boolean isMonitored() {
        return monitored;
    }

    public void setMonitored(boolean m) {
        this.monitored = m;
    }

    public boolean isReceiving() {
        return receiving;
    }

    public void setReceiving(boolean m) {
        this.receiving = m;
    }

    public void sendPacket(MaplePacket packet) {
        this.getSession().write(packet);
    }

}
