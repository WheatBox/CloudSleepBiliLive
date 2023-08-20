var _text = "可以通过发送以下弹幕来进行交互：\n加入、睡觉、起床、离开\n睡觉可以指定床位，如：睡觉12\n发送 切换+编号(0~3) 可以切换人物形象，如：切换0\n发送 切换抱枕+编号(0~5) 可以切换抱枕";

draw_set_color(#26267C);

if(gDrawCommands) {
	draw_set_alpha(0.3);
	draw_rectangle(0, 0, string_width(_text) + 4, 104, false);
	draw_rectangle(784, 0, room_width, 92, false);
}

draw_set_color(c_white);
draw_set_alpha(1);
if(gDrawCommands) {
	draw_text_ext(2, 2, _text, 20, 1000);
}

if(gDrawEmotes) {
	draw_text(808, 0, "可发送下列表情：");
	draw_sprite_ext(spr_AvailableEmotes, 0, room_width - 16, 20, 0.5, 0.5, 0, c_white, 1);
}

if(gDrawFps) {
	draw_text(480, 0, "fps : " + string(fps));
}

if(gDrawMaker) {
	draw_text(0, room_height - 20, "作者：Github@WheatBox");
}
