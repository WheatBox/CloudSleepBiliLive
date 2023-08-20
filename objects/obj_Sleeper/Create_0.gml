uid = -1;
name = ""; // 名称
text = ""; // 聊天内容
skinId = RandomSkinId(); // 皮肤编号

sprite_index = GetSkin(skinId);

image_xscale = SLEEPERSCALE;
image_yscale = SLEEPERSCALE;

sayTimeMax = GAMEFPS * 10;
sayTime = 0;

isGoingToSleep = false; // 在去睡觉的路上
isSleeping = false; // 在睡觉
sleepBedIns = noone; // 目标或在睡中的床

// 睡前坐标
xBeforeSleep = x;
yBeforeSleep = y;

generateDestPosCd = GAMEFPS * random_range(5, 30);

MyRandomPos = function() {
	var _x = irandom_range(40, room_width - 40);
	var _y = irandom_range(160, room_height - 20);
	
	if(-1 == mp_grid_get_cell(grid, floor(_x / gridCellSize), floor(_y / gridCellSize))) {
		return GetNearestAvailablePosOnGrid(_x, _y, 32);
	}
	
	return {
		m_x : _x,
		m_y : _y
	};
}

MyCheckAndGenerateDestPos = function() {
	generateDestPosCd = GAMEFPS * random_range(5, 30);
	
	var _pos = MyRandomPos();
	if(MyPathCanGo(_pos.m_x, _pos.m_y)) {
		MyPathGo(_pos.m_x, _pos.m_y);
	}
}

MySay = function(_text) {
	text = _text;
	sayTime = sayTimeMax;
}
MyChangeSkin = function(_skinId) {
	skinId = _skinId;
	sprite_index = GetSkin(skinId);
}
MyGoToSleep = function(_bedIns) {
	if(MyPathIsRunning()) {
		MyPathStop();
	}
	
	sleepBedIns = _bedIns;
	var _destPos = GetBedSide(x, y, _bedIns, 2);
	
	if(MyPathCanGo(_destPos.m_x, _destPos.m_y)) {
		MyPathGo(_destPos.m_x, _destPos.m_y);
		isGoingToSleep = true;
	}
}
MySleepOnBed = function(_sleepBedIns) {
	if(instance_exists(_sleepBedIns))
	if(_sleepBedIns.haveSleeper == false) {
		_sleepBedIns.MySleeperSleep(skinId);
		sleepBedIns = _sleepBedIns;
		isSleeping = true;
		
		xBeforeSleep = x;
		yBeforeSleep = y;
		
		x = _sleepBedIns.x;
		y = _sleepBedIns.y + 80 * SLEEPERSCALE;
	}
}
MyGetUp = function() {
	isSleeping = false;
	x = xBeforeSleep;
	y = yBeforeSleep;
	if(instance_exists(sleepBedIns)) {
		sleepBedIns.MySleeperGetUp();
	}
	
	sleepBedIns = noone;
}

MyLeave = function() {
	if(isSleeping) {
		MyGetUp();
	}
	instance_destroy(id);
}


timeI = irandom_range(-180, 180);
moveTimeI = 0;
anglePositive = choose(-2, 2);

myPath = path_add();
mySpeed = 2;

myPathDestX = undefined;
myPathDestY = undefined;

MyPathCanGo = function(destX, destY) {
	var pathTemp = path_add();
	var res = mp_grid_path(grid, pathTemp, x, y, destX, destY, true);
	path_delete(pathTemp);
	return res;
}
MyPathGenerate = function(destX, destY) {
	return mp_grid_path(grid, myPath, x, y, destX, destY, true);
}
MyPathGo = function(destX, destY) {
	if(MyPathGenerate(destX, destY)) {
		path_set_kind(myPath, 1);
		path_set_precision(myPath, 8);
		path_start(myPath, mySpeed, path_action_stop, true);
		
		myPathDestX = destX;
		myPathDestY = destY;
		
		anglePositive = choose(-2, 2);
	}
}
MyPathIsRunning = function() {
	return myPathDestX != undefined;
}
MyPathStop = function() {
	path_end();
	myPathDestX = undefined;
	myPathDestY = undefined;
}

/* 表情相关 */

emoteTimeMax = GAMEFPS * 10;
emoteTime = emoteTimeMax;
emoteAnimationTimeOffset = GAMEFPS * 0.1;

emoteIndex = -1; // -1 为 无表情
MyEmote = function(_emoteId) {
	var _arrTemp = gArrSkinEmoteSprs[skinId];
	if(_emoteId < 0 || _emoteId >= array_length(_arrTemp)) {
		return;
	}
	
	emoteTime = 0;
	emoteIndex = _emoteId;
}

/* 抱枕相关 */

pillowIndex = -1; // -1 代表没有抱枕
pillowSpr = -1;
pillowOnBedSpr = -1;
MyGiveOrChangePillow = function(_pillowIndex = 0) {
	if(_pillowIndex >= 0 && _pillowIndex < array_length(gArrPillowSprs)) {
		pillowIndex = _pillowIndex;
		pillowSpr = gArrPillowSprs[_pillowIndex];
		pillowOnBedSpr = gArrPillowOnBedSprs[_pillowIndex];
		
		PillowDataWrite(uid, _pillowIndex);
		PillowDataFileWrite();
	}
}
MyRemovePillow  = function() {
	pillowIndex = -1;
	pillowSpr = -1;
	pillowOnBedSpr = -1;
	
	PillowDataWrite(uid, -1);
	PillowDataFileWrite();
}

isDragging = false;
