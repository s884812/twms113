
/*
	Name:  潮流轉蛋機
	Place: 轉蛋屋
*/

importPackage(Packages.handling.world);
importPackage(Packages.tools);
importPackage(Packages.server);
var status = -1;

var requireItem = 5220000; /* 轉蛋券 */

function action(mode, _type, selection) {
    if (mode == 1) {
        status++;
    } else {
        cm.dispose();
        return;
    }

if(!cm.getPlayer().isGM() && false)
{
    cm.sendOk("GM測試中");
    cm.dispose();
    return;
}
    if(cm.getPlayer().getLevel() < 30) {
        cm.sendOk("請30等後再來");
        cm.dispose();
        return;
    }


    switch (status) {
        case 0:
            cm.sendYesNo("你好，我是潮流轉蛋機，請問你要轉蛋嗎？");
            break;
        case 1: {
            if (cm.haveItem(requireItem)) {
                var gashapon = cm.getGashapon();
                if(gashapon != null) {
                    if (cm.canHold()) {
                        cm.gainItem(requireItem, -1);
                        var gashaponItem = gashapon.generateReward();
                        var item = MapleInventoryManipulator.addbyId_Gachapon(cm.getPlayer().getClient(), gashaponItem.getItemId(), 1);

                        if(item != null && gashaponItem != null) { 
                            FilePrinter.print("潮流轉蛋機.txt", cm.getPlayer().getName() + "轉到" + item.getItemId(), true);
                            if(gashaponItem.canShowMsg())
                                World.Broadcast.broadcastMessage(MaplePacketCreator.getGachaponMega("[潮流轉蛋機] " + cm.getPlayer().getName() +  " : 被他從轉蛋屋的潮流轉蛋機轉到了，大家恭喜他吧！", item, cm.getChannelNumber()));
                            cm.sendOk("恭喜你轉到了#b#i" + gashaponItem.getItemId() + ":##k。");
                        } else {
                            cm.gainItem(requireItem, 1);
                            cm.sendOk("轉蛋機維護中。");
                        }
                    } else {
                        cm.sendOk("請確認你的物品欄位還有空間。");
                    }
                } else {
                    cm.sendOk("轉蛋機尚未開放。");
                }
            } else {
                cm.sendOk("很抱歉由於你沒有#b#i" + requireItem + "##k，所以不能轉蛋哦。");
            }
        }
        case 2:
            cm.dispose();
    }
}
