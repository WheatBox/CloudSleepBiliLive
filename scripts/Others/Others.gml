#macro GAMEFPS game_get_speed(gamespeed_fps)
#macro SLEEPERSCALE 0.6

#macro while_ until!

randomize();

globalvar gFontCommon;
gFontCommon = font_add("./975_SC_Regular.ttf", 12, false, false, 0, 65535);

draw_set_font(gFontCommon);


globalvar grid, gridCellSize;
gridCellSize = 16;

grid = mp_grid_create(0, 0, ceil(960 / gridCellSize), ceil(640 / gridCellSize), gridCellSize, gridCellSize);


function GetNearestAvailablePosOnGrid(_x, _y, _stepDis = 1) {
	var _x0 = _x, _x1 = _x, _y0 = _y, _y1 = _y;
	var _x0Res, _x1Res, _y0Res, _y1Res;
	
	do {
		_x0 -= _stepDis;
		_y0 -= _stepDis;
		_x1 += _stepDis;
		_y1 += _stepDis;
		_x0Res = mp_grid_get_cell(grid, floor(_x0 / gridCellSize), floor(_y / gridCellSize));
		_x1Res = mp_grid_get_cell(grid, floor(_x1 / gridCellSize), floor(_y / gridCellSize));
		_y0Res = mp_grid_get_cell(grid, floor(_x / gridCellSize), floor(_y0 / gridCellSize));
		_y1Res = mp_grid_get_cell(grid, floor(_x / gridCellSize), floor(_y1 / gridCellSize));
	} while_(-1 == _x0Res && -1 == _x1Res && -1 == _y0Res && -1 == _y1Res);
	
	if(_x0Res == 0) {
		_x = _x0;
	} else if(_x1Res == 0) {
		_x = _x1;
	} else if(_y0Res == 0) {
		_y = _y0;
	} else if(_y1Res == 0) {
		_y = _y1;
	}
	
	return {
		m_x : _x,
		m_y : _y
	};
}

/// @desc 获取最近的床边
function GetBedSide(_x, _y, _bedIns, _stepDis = 1) {
	var _xBed = _bedIns.x, _yBed = _bedIns.y + 80 * SLEEPERSCALE;
	var _x0 = _xBed, _x1 = _xBed; // 上床只能从左边或右边
	var _x0Res = -1, _x1Res = -1;
	var _safe = 128;
	
	var _left = _bedIns.side == 0
		? (_xBed - _x > 0)
		: (_bedIns.side == -1 ? true : false);
	
	do {
		if(_left) {
			_x0 -= _stepDis;
			_x0Res = mp_grid_get_cell(grid, floor(_x0 / gridCellSize), floor(_yBed / gridCellSize));
		} else {
			_x1 += _stepDis;
			_x1Res = mp_grid_get_cell(grid, floor(_x1 / gridCellSize), floor(_yBed / gridCellSize));
		}
		_safe -= _stepDis;
	} while_(-1 == _x0Res && -1 == _x1Res && _safe >= 0);
	
	if(_x0Res == 0) {
		_x = _x0;
	} else if(_x1Res == 0) {
		_x = _x1;
	}
	
	return {
		m_x : _x,
		m_y : _yBed
	};
}

function MouseOnGui() {
	if(instance_exists(obj_RightClickMenu)) {
		return obj_RightClickMenu.mouseOnMe;
	}
	return false;
}
