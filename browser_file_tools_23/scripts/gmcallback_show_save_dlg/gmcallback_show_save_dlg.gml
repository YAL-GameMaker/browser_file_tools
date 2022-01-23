function gmcallback_show_save_dlg() {
	with (obj_test) {
		var _buf = buffer_create(16, buffer_grow, 1);
		buffer_write(_buf, buffer_text, text);
		browser_show_save_dialog(_buf, "test.txt", "text/plain", buffer_tell(_buf));
		buffer_delete(_buf);
	}
}