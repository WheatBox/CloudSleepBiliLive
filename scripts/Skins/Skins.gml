globalvar gArrSkinSprs, gArrBedSkinSprs, gArrBedSkinMasks, gArrBedSleeperSkinSprs;
gArrSkinSprs = [
	spr_SleeperBoy,
	spr_SleeperGirl,
	spr_SleeperPinkBoy,
	spr_SleeperPinkGirl,
];
gArrBedSkinSprs = [
	spr_Bed,
	spr_DoubleBedL,
	spr_DoubleBedR,
];
gArrBedSkinMasks = [ // 碰撞体
	spr_Bed,
	spr_DoubleBedL,
	spr_DoubleBedR,
];
gArrBedSleeperSkinSprs = [
	[
		spr_Bed_Boy,
		spr_Bed_Girl,
		spr_Bed_PinkBoy,
		spr_Bed_PinkGirl,
	],
	[
		spr_DoubleBedL_Boy,
		spr_DoubleBedL_Girl,
		spr_DoubleBedL_PinkBoy,
		spr_DoubleBedL_PinkGirl,
	],
	[
		spr_DoubleBedR_Boy,
		spr_DoubleBedR_Girl,
		spr_DoubleBedR_PinkBoy,
		spr_DoubleBedR_PinkGirl,
	],
];

function RandomSkinId() {
	return irandom_range(0, array_length(gArrSkinSprs) - 1);
}

function GetSkin(_skinId) {
	_skinId = floor(_skinId);
	if(_skinId >= 0 && _skinId <= array_length(gArrSkinSprs) - 1) {
		return gArrSkinSprs[_skinId];
	}
	return gArrSkinSprs[0];
}
function GetBedSleeperSkin(_bedSkinId, _skinId) {
	_skinId = floor(_skinId);
	if(_skinId >= 0 && _skinId <= array_length(gArrBedSleeperSkinSprs[_bedSkinId]) - 1) {
		return gArrBedSleeperSkinSprs[_bedSkinId][_skinId];
	}
	return gArrBedSleeperSkinSprs[_bedSkinId][0];
}

globalvar gMapSkinEmoteId, gArrSkinEmoteSprs;
gMapSkinEmoteId = ds_map_create();
gMapSkinEmoteId[? "[生气]"] = 0;
gMapSkinEmoteId[? "[大哭]"] = 1;
gMapSkinEmoteId[? "[惊喜]"] = 2;
gMapSkinEmoteId[? "[鼓掌]"] = 3;
gMapSkinEmoteId[? "[难过]"] = 4;
gMapSkinEmoteId[? "[害羞]"] = 5;
gMapSkinEmoteId[? "[大笑]"] = 6;
gMapSkinEmoteId[? "[委屈]"] = 7;
gMapSkinEmoteId[? "[调皮]"] = 8;
gMapSkinEmoteId[? "[微笑]"] = 9;

gArrSkinEmoteSprs[0] = [
	spr_SleeperBoy_Angry,
	spr_SleeperBoy_Cry,
	spr_SleeperBoy_Excited,
	spr_SleeperBoy_Pamper,
	spr_SleeperBoy_Sad,
	spr_SleeperBoy_Shy,
	spr_SleeperBoy_Smile,
	spr_SleeperBoy_Tearful,
	spr_SleeperBoy_Tricky,
	spr_SleeperBoy_UwU,
];
gArrSkinEmoteSprs[1] = [
	spr_SleeperGirl_Angry,
	spr_SleeperGirl_Cry,
	spr_SleeperGirl_Excited,
	spr_SleeperGirl_Pamper,
	spr_SleeperGirl_Sad,
	spr_SleeperGirl_Shy,
	spr_SleeperGirl_Smile,
	spr_SleeperGirl_Tearful,
	spr_SleeperGirl_Tricky,
	spr_SleeperGirl_UwU,
];
gArrSkinEmoteSprs[2] = [
	spr_SleeperPinkBoy_Angry,
	spr_SleeperPinkBoy_Cry,
	spr_SleeperPinkBoy_Excited,
	spr_SleeperPinkBoy_Pamper,
	spr_SleeperPinkBoy_Sad,
	spr_SleeperPinkBoy_Shy,
	spr_SleeperPinkBoy_Smile,
	spr_SleeperPinkBoy_Tearful,
	spr_SleeperPinkBoy_Tricky,
	spr_SleeperPinkBoy_UwU,
];
gArrSkinEmoteSprs[3] = [
	spr_SleeperPinkGirl_Angry,
	spr_SleeperPinkGirl_Cry,
	spr_SleeperPinkGirl_Excited,
	spr_SleeperPinkGirl_Pamper,
	spr_SleeperPinkGirl_Sad,
	spr_SleeperPinkGirl_Shy,
	spr_SleeperPinkGirl_Smile,
	spr_SleeperPinkGirl_Tearful,
	spr_SleeperPinkGirl_Tricky,
	spr_SleeperPinkGirl_UwU,
];

globalvar gArrPillowSprs, gArrPillowOnBedSprs;
gArrPillowSprs = [
	spr_PillowWhite,
	spr_PillowCarrot,
	spr_PillowCat,
	spr_PillowPancakeGodzilla,
	spr_PillowSisi,
	spr_PillowWheatBox
];
gArrPillowOnBedSprs = [
	spr_PillowOnBedWhite,
	spr_PillowOnBedCarrot,
	spr_PillowOnBedCat,
	spr_PillowOnBedPancakeGodzilla,
	spr_PillowOnBedSisi,
	spr_PillowOnBedWheatBox
];
