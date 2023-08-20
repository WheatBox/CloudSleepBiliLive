image_xscale = SLEEPERSCALE;
image_yscale = SLEEPERSCALE;

depth = -y;

bedId = 0;
bedSkinId = 0;
side = 0; // 床边状态，-1 = 只有左半边，0 = 两边都有，1 = 只有右半边

haveSleeper = false;

MySleeperSleep = function(_skinId) {
	haveSleeper = true;
	sprite_index = GetBedSleeperSkin(bedSkinId, _skinId);
}

MySleeperGetUp = function() {
	haveSleeper = false;
	sprite_index = gArrBedSkinSprs[bedSkinId];
}

alarm_set(0, 1);
