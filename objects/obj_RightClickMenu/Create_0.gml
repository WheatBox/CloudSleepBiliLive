clickIns = noone;
clickX = 0;
clickY = 0;

lineWidth = 128;
lineHeight = 20;

arrFuncArgs = []; // 会在鼠标右键交互的部分定义
arrFunctions = [
	function(_ins) { // 给予抱枕
		_ins.MyGiveOrChangePillow();
	},
	function(_ins) { // 移除抱枕
		_ins.MyRemovePillow();
	},
	function(_uid) { // 移除睡客
		if(instance_exists(obj_Manager)) {
			obj_Manager.MyCheckAndRemoveSleeper(_uid);
		}
	}
];
arrText = [
	"给予抱枕",
	"移除抱枕",
	"移除睡客",
];

lineNum = array_length(arrFunctions);

running = false;
mouseOnMe = false;
