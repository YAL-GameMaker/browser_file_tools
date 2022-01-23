draw_set_font(fnt_test);
draw_set_color(c_white);
draw_text(120, 5, text);

button_x = 5;
button_y = 5;
if (button("Open dialog")) {
	browser_show_open_dialog("*", false, handle);
}
if (button("Save dialog")) {
	var _buf = buffer_create(16, buffer_grow, 1);
	buffer_write(_buf, buffer_text, text);
	browser_show_save_dialog(_buf, "test.txt", "text/plain", buffer_tell(_buf));
	buffer_delete(_buf);
}
if (sprite != -1) draw_sprite(sprite, 0, button_x, button_y);
