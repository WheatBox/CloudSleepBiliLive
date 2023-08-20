PillowDataFileRead();

arrBeds = [];

var i = 0;
for(var iy = 0; iy < 3; iy++) {
	var ixLen = iy % 2 == 0 ? 6 : 7;
	for(var ix = 0; ix < ixLen; ix++) {
		arrBeds[i] = instance_create_depth(ix * 144 + 120 - 72 * (iy % 2), iy * 144 + 192, depth, obj_Bed);
		arrBeds[i].bedId = i;
		
		if(gEnableDouble) {
			switch(i) {
			
				// 双人床左半部分
				case 0:
				case 4:
				case 13:
				case 17:
					arrBeds[i].bedSkinId = 1;
					arrBeds[i].x += 48;
					arrBeds[i].side = -1;
					break;
			
				// 双人床右半部分
				case 1:
				case 5:
				case 14:
				case 18:
					arrBeds[i].bedSkinId = 2;
					arrBeds[i].x -= 48;
					arrBeds[i].side = 1;
					break;
				
				default:
					arrBeds[i].bedSkinId = 0;
					arrBeds[i].side = 0;
			}
		} else {
			arrBeds[i].bedSkinId = 0;
			arrBeds[i].side = 0;
		}
		
		i++;
	}
}

sleepersMap = ds_map_create();

MyCheckAndGenerateSleeper = function(_uid, _name) {
	if(sleepersMap[? _uid] == undefined) {
		var _ins = instance_create_depth(0, 0, depth, obj_Sleeper);
		var _pos = _ins.MyRandomPos();
		
		_ins.x = _pos.m_x;
		_ins.y = _pos.m_y;
		
		_ins.uid = _uid;
		_ins.name = _name;
		
		_ins.MyGiveOrChangePillow(PillowDataRead(_uid));
		
		sleepersMap[? _uid] = _ins;
	}
}

MyCheckAndRemoveSleeper = function(_uid) {
	sleepersMap[? _uid].MyLeave();
	sleepersMap[? _uid] = undefined;
}

MySleeperSay = function(_uid, _name, _text) {
	_text = string_trim(_text);
	
	if(_text == "加入") {
		MyCheckAndGenerateSleeper(_uid, _name);
	} else
	if(_text == "离开") {
		MyCheckAndRemoveSleeper(_uid);
	}
	
	var _ins = sleepersMap[? _uid];
	
	if(_ins != undefined)
	if(instance_exists(_ins)) {
		var _textLen = string_length(_text);
		
		/* 一些指令的处理 */
		
		if(_textLen == 2)
		switch(_text) {
			case "睡觉":
				if(_ins.isSleeping) {
					break;
				}
				var _xTemp = _ins.x, _yTemp = _ins.y;
				var _arrBedsTemp = [];
				with(obj_Bed) {
					var len = array_length(_arrBedsTemp);
					var i = 0;
					for(i = 0; i < len; i++) {
						if(point_distance(_arrBedsTemp[i].x, _arrBedsTemp[i].y + 80 * SLEEPERSCALE, _xTemp, _yTemp)
							>= point_distance(x, y, _xTemp, _yTemp)) {
							array_insert(_arrBedsTemp, i, id);
						}
					}
					if(i == len) {
						array_push(_arrBedsTemp, id);
					}
				}
				var _bedsNum = array_length(_arrBedsTemp);
				for(var ibed = 0; ibed < _bedsNum; ibed++) {
					var _ibedIns = _arrBedsTemp[ibed];
					if(_ibedIns.haveSleeper == false) {
						_ins.MyGoToSleep(_ibedIns);
						break;
					}
				}
				break;
			case "起床":
				if(_ins.isSleeping == false) {
					break;
				}
				_ins.MyGetUp();
				break;
		}
		
		if(_textLen > 2 && _ins.isSleeping == false)
		if(string_copy(_text, 1, 2) == "睡觉") {
			var _textDigits = string_digits(_text);
			if(_textDigits != "") {
				var _iBedTemp = floor(real(_textDigits));
				if(_iBedTemp >= 0 && _iBedTemp < array_length(arrBeds)) {
					_ins.MyGoToSleep(arrBeds[_iBedTemp]);
				}
			}
		}
		
		if(_textLen == 3)
		if(string_copy(_text, 1, 2) == "切换") {
			var _textDigits = string_digits(_text);
			if(_textDigits != "") {
				_ins.MyChangeSkin(real(_textDigits));
			}
		}
		
		if(_textLen == 5)
		if(string_copy(_text, 1, 4) == "切换抱枕") {
			var _textDigits = string_digits(_text);
			if(_textDigits != "" && _ins.pillowIndex != -1) {
				_ins.MyGiveOrChangePillow(real(_textDigits));
			}
		}
		
		/* 表情处理 */
		
		var _emoteLpos = string_last_pos("[", _text);
		var _emoteRpos = string_last_pos("]", _text);
		if(_emoteLpos != 0 && _emoteRpos > _emoteLpos) {
			var _emoteId = gMapSkinEmoteId[? string_copy(_text, _emoteLpos, _emoteRpos - _emoteLpos + 1)];
			if(_emoteId != undefined) {
				_ins.MyEmote(_emoteId);
			}
		}
		
		/* 发言处理 */
		
		_ins.MySay(_text);
	}
}
