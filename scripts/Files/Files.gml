#macro FILENAME_PILLOW "pillow.json"

globalvar gPillowData; // uid : pillowIndex
gPillowData = {};

function PillowDataRead(_uid) {
	if(gPillowData[$ _uid] == undefined) {
		return -1;
	} else {
		return gPillowData[$ _uid];
	}
}

function PillowDataWrite(_uid, _pillowIndex) {
	gPillowData[$ _uid] = _pillowIndex;
}

function PillowDataFileRead() {
	var file = file_text_open_read(FILENAME_PILLOW);
	if(file != -1) {
		gPillowData = json_parse(file_text_read_string(file));
		file_text_close(file);
	}
}

function PillowDataFileWrite() {
	var file = file_text_open_write(FILENAME_PILLOW);
	if(file != -1) {
		file_text_write_string(file, json_stringify(gPillowData));
		file_text_close(file);
	}
}
