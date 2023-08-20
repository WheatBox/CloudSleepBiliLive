#macro CONFIG_INI "config.ini"

globalvar gDrawCommands, gDrawFps, gDrawEmotes, gDrawMaker;

globalvar gEnableDouble;

ini_open(CONFIG_INI);

gDrawCommands = ini_read_real("GUI", "commands", 1);
gDrawFps = ini_read_real("GUI", "fps", 1);
gDrawEmotes = ini_read_real("GUI", "emotes", 1);
gDrawMaker = ini_read_real("GUI", "maker", 1);

gEnableDouble = ini_read_real("Beds", "EnableDouble", 0);

var r = ini_read_real("Background", "red", 86);
var g = ini_read_real("Background", "green", 92);
var b = ini_read_real("Background", "blue", 124);

ini_close();

globalvar gBackgroundColor;
gBackgroundColor = make_color_rgb(r, g, b);
