function enter(pi) {
    var em = pi.getEventManager("HorntailBattle");
    if (em != null) {
        var map = pi.getMapId();
		var d1 = pi.getMap(240060000);
		var d2 = pi.getMap(240060100);
        if (map == 240060000) {
            if (em.getProperty("state").equals("2") && d1.getAllMonstersThreadsafe().size() <= 0) {
                em.warpAllPlayer(240060000, 240060100);
            } else {
                pi.playerMessage("這個門還沒開起。");
            }
        } else if (map == 240060100) {
            if (em.getProperty("state").equals("3") && d2.getAllMonstersThreadsafe().size() <= 0) {
                em.warpAllPlayer(240060100, 240060200);
				pi.playerMessage("state="+state);
            } else {
                pi.playerMessage("這個門還沒開起。");
            }
        }
    }
}