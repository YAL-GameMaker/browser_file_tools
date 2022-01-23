var b = buffer_create(16, buffer_grow, 1);
buffer_write(b, buffer_text, "hello!");
browser_show_save_dialog(b, "hi.txt", "text/plain", buffer_tell(b));
buffer_delete(b);