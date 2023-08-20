var mbLeftPress = mouse_check_button_pressed(mb_left);
var mbRightPress = mouse_check_button_pressed(mb_right);
var mx = window_mouse_get_x();
var my = window_mouse_get_y();

mouseOnMe = false;

if(running && instance_exists(clickIns)) {
	draw_set_alpha(1);
	draw_set_color(#111111);
	draw_rectangle(clickX, clickY, clickX + lineWidth, clickY + lineHeight * (lineNum + 1), false);
	draw_set_color(c_white);
	draw_text(clickX, clickY, clickIns.name);
	
	mouseOnMe = point_in_rectangle(mx, my, clickX, clickY, clickX + lineWidth, clickY + lineHeight * (lineNum + 1));
	
	for(var i = 0; i < lineNum; i++) {
		draw_text(clickX, clickY + lineHeight * (i + 1), arrText[i]);
		
		if(point_in_rectangle(mx, my
			, clickX, clickY + lineHeight * (i + 1)
			, clickX + lineWidth - 1, clickY + lineHeight * (i + 2) - 1)
		) {
			draw_rectangle(clickX + 1, clickY + lineHeight * (i + 1) + 1
				, clickX + lineWidth - 1, clickY + lineHeight * (i + 2) - 2, true);
			
			if(mbLeftPress) {
				arrFunctions[i](arrFuncArgs[i]);
				alarm_set(0, 2);
			}
		}
	}
}

if(running) {
	if(mbLeftPress || mbRightPress)
	if(mouseOnMe == false) {
		alarm_set(0, 1);
	}
} else if(mbRightPress) {
	
	var _clickSleeperList = ds_list_create();
	var _clickSleeperNum = collision_point_list(mouse_x, mouse_y, obj_Sleeper, false, false, _clickSleeperList, false);
	var _clickSleeperMinDepth = 99999;
	var _clickSleeperInsFinal = noone;
	
	for(var i = 0; i < _clickSleeperNum; i++) {
		var _insClickSleeper = _clickSleeperList[| i];
		if(_insClickSleeper.depth < _clickSleeperMinDepth) {
			_clickSleeperMinDepth = _insClickSleeper.depth;
			_clickSleeperInsFinal = _insClickSleeper;
		}
	}
	
	if(_clickSleeperInsFinal != noone) {
		clickIns = _clickSleeperInsFinal;
		clickX = mouse_x;
		clickY = mouse_y;
		
		arrFuncArgs = [
			clickIns,
			clickIns,
			clickIns.uid,
		];
		
		running = true;
	}
	
	ds_list_destroy(_clickSleeperList);
}
