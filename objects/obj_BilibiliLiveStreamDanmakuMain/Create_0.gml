var roomidFile = file_text_open_read("roomid.txt");
apiUrl = "https://api.live.bilibili.com/xlive/web-room/v1/dM/gethistory?roomid=" + file_text_read_string(roomidFile);
file_text_close(roomidFile);

//apiUrl = "https://api.live.bilibili.com/xlive/web-room/v1/dM/gethistory?roomid=27050582"; // 思思的直播间
//apiUrl = "https://api.live.bilibili.com/xlive/web-room/v1/dM/gethistory?roomid=21622811"; // CSGO比赛的直播间
//apiUrl = "https://api.live.bilibili.com/xlive/web-room/v1/dM/gethistory?roomid=960890"; // 银桐树叶的直播间

httpId = http_get(apiUrl);

danmakuGetCdMax = 3 * GAMEFPS; // 3秒获取一次，因为实测发现所使用的API在服务端那里是3秒更新一次的
danmakuGetCd = 0;

newestDanmaku = undefined; // 用于每次接收数据的时候确定比起前次数据来说的新数据的位置
// 注意该变量不能用于其它用途

firstRecved = false;

/// @desc 我的业务逻辑
MyBusiness = function(_danmaku) {
	if(firstRecved) {
		obj_Manager.MySleeperSay(_danmaku.uid, _danmaku.nickname, _danmaku.text);
		
		show_debug_message("{0} {1} : {2}", _danmaku.timeline, _danmaku.nickname, _danmaku.text);
	}
}
