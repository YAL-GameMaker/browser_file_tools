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

button_x = 0; button_y = 0;
function button(_label) {
	var _w = string_width(_label) + 8;
	var _h = string_height(_label);
	var _mx = mouse_x - button_x, _my = mouse_y - button_y;
	var _over = (_mx >= 0 && _my >= 0 && _mx < _w && _my < _h);
	draw_set_color(c_white);
	draw_set_alpha(_over ? 1.0 : 0.9);
	draw_rectangle(button_x, button_y, button_x + _w, button_y + _h, false);
	draw_set_color(c_black);
	draw_set_alpha(1.0);
	draw_text(button_x + 4, button_y, _label);
	button_y += _h + 4;
	return _over && mouse_check_button_pressed(mb_left);
}