/* 角色本身的绘制与动画效果处理 */

var sprite = sprite_index;

var xscale = 1 + cos(degtorad(timeI)) / 20;
var yscale = 1 + sin(degtorad(timeI)) / 20;

if(emoteIndex != -1) {
	emoteTime += 2;
	if(emoteTime > emoteTimeMax) {
		emoteIndex = -1;
	} else {
		var _emoteAnimationTimeOffsetHalf = emoteAnimationTimeOffset / 2;
		if(emoteTime <= emoteAnimationTimeOffset) {
			xscale *= 1.0 - 0.1 * (1 - abs(emoteTime - _emoteAnimationTimeOffsetHalf) / _emoteAnimationTimeOffsetHalf);
			yscale *= 1.0 + 0.08 * (1 - abs(emoteTime - _emoteAnimationTimeOffsetHalf) / _emoteAnimationTimeOffsetHalf);
		} else
		if(emoteTime >= emoteTimeMax - emoteAnimationTimeOffset) {
			xscale *= 1.0 + 0.08 * (1 - abs(emoteTimeMax - emoteTime - _emoteAnimationTimeOffsetHalf) / _emoteAnimationTimeOffsetHalf);
			yscale *= 1.0 - 0.1 * (1 - abs(emoteTimeMax - emoteTime - _emoteAnimationTimeOffsetHalf) / _emoteAnimationTimeOffsetHalf);
		}
		
		if(emoteTime >= _emoteAnimationTimeOffsetHalf - 1 && emoteTime <= emoteTimeMax - _emoteAnimationTimeOffsetHalf) {
			sprite = gArrSkinEmoteSprs[skinId][emoteIndex];
		}
	}
}

var angleBase = radtodeg(((anglePositive > 0) ? cos(degtorad(timeI)) : sin(degtorad(timeI))) / 20);
var angle = angleBase;
var angleTemp = radtodeg(sin(degtorad(moveTimeI * 10))) / 6;

if(MyPathIsRunning()) {
	angle = angleTemp;
	
	moveTimeI += anglePositive;
} else {
	moveTimeI = 0;
}
angle += image_angle;

timeI += anglePositive;

if(isSleeping == false) {
	draw_set_color(c_black);
	draw_set_alpha(0.4);
	draw_ellipse(x - 10, y - 4, x + 8, y + 4, false);
	
	draw_sprite_ext(sprite, image_index, x, y, xscale * image_xscale, yscale * image_yscale, angle, image_blend, image_alpha);
}

/* 抱枕处理 */

var pillowAngle = radtodeg(((anglePositive > 0) ? cos(degtorad(timeI + 90)) : sin(degtorad(timeI + 90))) / 20);
var pillowAngleTemp = radtodeg(sin(degtorad(moveTimeI * 10 + 90))) / 6;

if(MyPathIsRunning()) {
	pillowAngle = pillowAngleTemp;
}
pillowAngle += angleBase;

if(pillowIndex != -1) {
	var _pillowScale = 0.8;
	if(isSleeping == false) {
		draw_sprite_ext(pillowSpr, 0
			, x + 6 + lengthdir_x(24, angle + 60), y + lengthdir_y(24, angle + 60)
			, xscale * _pillowScale, yscale * _pillowScale
			, pillowAngle - 15, c_white, 1);
	} else {
		switch(sleepBedIns.side) {
			case 0:
				draw_sprite_ext(pillowOnBedSpr, 0
					, x - 24, y - 35
					, _pillowScale, _pillowScale
					, 6, c_white, 1);
				break;
			case -1:
				draw_sprite_ext(pillowOnBedSpr, 0
					, x - 20, y - 35
					, _pillowScale, _pillowScale
					, 12, c_white, 1);
				break;
			case 1:
				draw_sprite_ext(pillowOnBedSpr, 0
					, x + 20, y - 35
					, _pillowScale, _pillowScale
					, -24, c_white, 1);
				break;
		}
	}
}

/* 名称与聊天气泡处理 */

var nameTextScale = 0.8;
var nameTextWHalf = string_width(name) / 2 * nameTextScale + 4;
var nameTextYOff = 66;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_black);
draw_set_alpha(0.6);
draw_roundrect_ext(x - nameTextWHalf, y - nameTextYOff - 4, x + nameTextWHalf, y - nameTextYOff - 24, 8, 8, false);

draw_set_color(c_white);
draw_set_alpha(1);
draw_text_transformed(x, y - nameTextYOff - 14, name, nameTextScale, nameTextScale, 0);
// draw_text(x, y, string(isGoingToSleep) + " " + string(isSleeping) + " " + string(sleepBedIns));

if(sayTime > 0) {
	sayTime--;
	
	draw_sprite_ext(spr_TextBg, 0, x, y - nameTextYOff - 40, (string_width(text) + 44) / 64, 1, 0, c_white, 1);
	draw_sprite_ext(spr_TextBgTail, 0, x, y - nameTextYOff - 40, 1, 1, 0, c_white, 1);
	draw_set_color(c_black);
	draw_text(x, y - nameTextYOff - 40, text);
	draw_set_color(c_white);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

depth = -y;
