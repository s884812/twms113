﻿var setupTask;

function init() {
    scheduleNew();
}

function scheduleNew() {
    var cal = java.util.Calendar.getInstance();
    cal.set(java.util.Calendar.HOUR, 0);
    cal.set(java.util.Calendar.MINUTE, 10);
    cal.set(java.util.Calendar.SECOND, 0);
    var nextTime = cal.getTimeInMillis();
    while (nextTime <= java.lang.System.currentTimeMillis()) {
        nextTime += 5 * 60 * 1000; //這裡就是設定多久存檔一次啦，單位是毫秒，可依據玩家數做調整
    }
    setupTask = em.scheduleAtTimestamp("start", nextTime);
}


function cancelSchedule() {
    setupTask.cancel(true);
}

function start() {
   
    em.getChannelServer().saveAll();
	em.broadcastYellowMsg("[系統公告] 自動存檔完畢。");
    scheduleNew();
}
