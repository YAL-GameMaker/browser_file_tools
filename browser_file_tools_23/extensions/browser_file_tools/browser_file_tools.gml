#define browser_file_tools_init
global.__browser_file_tools_paste_handler = -1;
global.__browser_file_tools_paste_filter = -1;
global.__browser_file_tools_drop_handler = -1;
global.__browser_file_tools_drop_filter = -1;
global.__browser_file_tools_open_handler = -1;
global.__browser_file_tools_open_filter = -1;

#define browser_file_tools_callback_get_name
var _script = argument0;
if (_script != undefined && script_exists(_script)) {
	var _name = script_get_name(_script);
	if (string_pos("gmcallback_", _name) != 1) {
		show_error("Callback script names must start with `gmcallback_` in GMS1", 1);
		return undefined;
	}
	return _name;
} else return undefined;

#define browser_file_tools_callback_is_valid
var _func = argument0;
if (_func == undefined) return false;
// GMS >= 2.3:
if (is_method(_func)) return true;
//*/
return script_exists(_func);

#define browser_file_tools_callback_invoke3
// GMS >= 2.3:
if (is_method(argument0)) {
	var _func = argument0;
	return _func(argument1, argument2, argument3);
}
//*/
return script_execute(argument0, argument1, argument2, argument3);

#define browser_file_tools_cb_invoke
var _script = argument0;

#define gmcallback_browser_file_tools_paste_handler
var _data = argument0, _name = argument1, _type = argument2;
return browser_file_tools_callback_invoke3(global.__browser_file_tools_paste_handler, _data, _name, _type);

#define gmcallback_browser_file_tools_paste_filter
var _data = argument0, _name = argument1, _type = argument2;
return browser_file_tools_callback_invoke3(global.__browser_file_tools_paste_filter, _data, _name, _type);

#define browser_paste_bind
/// (?handler_script:function<data:string;name:string;type:string;void>, ?filter_script:function<type:string;bool>)
var _handler = argument_count > 0 ? argument[0] : undefined;
var _filter = argument_count > 1 ? argument[1] : undefined;
// GMS >= 2:
global.__browser_file_tools_paste_handler = _handler;
global.__browser_file_tools_paste_filter = _filter;
return browser_paste_bind_raw(
	browser_file_tools_callback_is_valid(_handler) ? "gmcallback_browser_file_tools_paste_handler" : undefined,
	browser_file_tools_callback_is_valid(_filter) ? "gmcallback_browser_file_tools_paste_filter" : undefined,
	argument[-2], argument[-1],
);
/*/
_handler = browser_file_tools_callback_get_name(_handler);
_filter = browser_file_tools_callback_get_name(_filter);
return browser_paste_bind_raw(
	browser_file_tools_callback_get_name(_handler),
	browser_file_tools_callback_get_name(_filter),
	argument[-2], argument[-1],
);
//*/

#define gmcallback_browser_file_tools_drop_handler
var _data = argument0, _name = argument1, _type = argument2;
return browser_file_tools_callback_invoke3(global.__browser_file_tools_drop_handler, _data, _name, _type);

#define gmcallback_browser_file_tools_drop_filter
var _data = argument0, _name = argument1, _type = argument2;
return browser_file_tools_callback_invoke3(global.__browser_file_tools_drop_filter, _data, _name, _type);

#define browser_drop_bind
/// (?handler_script:function<data:string;name:string;type:string;void>, ?filter_script:function<type:string;bool>)
var _handler = argument_count > 0 ? argument[0] : undefined;
var _filter = argument_count > 1 ? argument[1] : undefined;
// GMS >= 2:
global.__browser_file_tools_drop_handler = _handler;
global.__browser_file_tools_drop_filter = _filter;
return browser_drop_bind_raw(
	browser_file_tools_callback_is_valid(_handler) ? "gmcallback_browser_file_tools_drop_handler" : undefined,
	browser_file_tools_callback_is_valid(_filter) ? "gmcallback_browser_file_tools_drop_filter" : undefined,
	argument[-2], argument[-1],
);
/*/
_handler = browser_file_tools_callback_get_name(_handler);
_filter = browser_file_tools_callback_get_name(_filter);
return browser_drop_bind_raw(
	browser_file_tools_callback_get_name(_handler),
	browser_file_tools_callback_get_name(_filter),
	argument[-2], argument[-1],
);
//*/

#define gmcallback_browser_file_tools_open_handler
var _data = argument0, _name = argument1, _type = argument2;
return browser_file_tools_callback_invoke3(global.__browser_file_tools_open_handler, _data, _name, _type);

#define gmcallback_browser_file_tools_open_filter
var _data = argument0, _name = argument1, _type = argument2;
return browser_file_tools_callback_invoke3(global.__browser_file_tools_open_filter, _data, _name, _type);

#define browser_show_open_dialog
/// (accept:string, multiselect:bool, handler_script:function<data:string;name:string;type:string;void>, ?filter_script:function<type:string;bool>)
var _accept = argument[0], _multiselect = argument[1], _handler = argument[2];
var _filter = argument_count > 3 ? argument[3] : undefined;
// GML >= 2:
global.__browser_file_tools_open_handler = _handler;
global.__browser_file_tools_open_filter = _filter;
return browser_show_open_dialog_raw(_accept, _multiselect,
	browser_file_tools_callback_is_valid(_handler) ? "gmcallback_browser_file_tools_open_handler" : undefined,
	browser_file_tools_callback_is_valid(_filter) ? "gmcallback_browser_file_tools_open_filter" : undefined,
	argument[-2], argument[-1],
);
/*/
_handler = browser_file_tools_callback_get_name(_handler);
_filter = browser_file_tools_callback_get_name(_filter);
return browser_show_open_dialog_raw(_accept,
	browser_file_tools_callback_get_name(_handler),
	browser_file_tools_callback_get_name(_filter),
	argument[-2], argument[-1],
);
//*/

#define browser_show_save_dialog
/// (buffer, name, ?type, ?size)
var _buffer = argument[0], _name = argument[1];
var _type = argument_count > 2 ? argument[2] : undefined;
var _size = argument_count > 3 ? argument[3] : buffer_get_size(_buffer);
if (_type == undefined) _type = "application/octet-stream";
return browser_show_save_dialog_raw(buffer_get_address(_buffer), _name, _type, _size);