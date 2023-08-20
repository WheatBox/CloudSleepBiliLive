draw_self();
draw_set_color(#111111);
var _textXAdd = -48;
if(side == -1) {
	_textXAdd = -36;
} else if(side == 1) {
	_textXAdd = 36 - string_width(string(bedId));
}
draw_text_transformed(x + _textXAdd * SLEEPERSCALE, y + 122 * SLEEPERSCALE, bedId, 0.9, 0.9, 0);
draw_set_color(c_white);