text = ("Click here and then:"
	+ "\nCtrl+V to paste image/text"
	+ "\nOr drag and drop files here"
);

sprite = -1;
function handle(_data, _name, _type) {
	if (sprite != -1) {
		sprite_delete(sprite);
		sprite = -1;
	}
	
	if (_name == undefined) {
		text = "[" + string(_type) + "]: " + string(data);
	} else if (string_pos("image/", _type) == 1) {
		// this looks like an image, so load that
		text = "[" + string(_type) + "]: " + string(_name);
		sprite = sprite_add(_data, 1, 0, 0, 0, 0);
	} else {
		// some other binary data, but not an image
		_data = string_delete(_data, 1, string_pos(_data, ","));
		var _buf = buffer_base64_decode(_data);
		text = "file: (" + string(_name) + ") - " + string(buffer_get_size(_buf)) + " bytes";
		buffer_delete(_buf);
	}
}
browser_paste_bind(handle);
browser_drop_bind(handle);

clickable_add(5, 5, sprite_get_tpe(spr_buttons, 0), "gmcallback_show_open_dlg", "", "");
clickable_add(50, 5, sprite_get_tpe(spr_buttons, 1), "gmcallback_show_save_dlg", "", "");