/*
 * FileSaver.js
 * A saveAs() FileSaver implementation.
 *
 * By Eli Grey, http://eligrey.com
 *
 * License : https://github.com/eligrey/FileSaver.js/blob/master/LICENSE.md (MIT)
 * source  : http://purl.eligrey.com/github/FileSaver.js
 */
(function(a,b){
	if("function"==typeof define&&define.amd)define([],b);else if("undefined"!=typeof exports)b();else{b(),a.FileSaver={exports:{}}.exports
}})(this,function(){"use strict";
	function b(a,b){return"undefined"==typeof b?b={autoBom:!1}:"object"!=typeof b&&(console.warn("Deprecated: Expected third argument to be a object"),b={autoBom:!b}),b.autoBom&&/^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(a.type)?new Blob(["\uFEFF",a],{type:a.type}):a}
	function c(a,b,c){var d=new XMLHttpRequest;d.open("GET",a),d.responseType="blob",d.onload=function(){g(d.response,b,c)},d.onerror=function(){console.error("could not download file")},d.send()}
	function d(a){var b=new XMLHttpRequest;b.open("HEAD",a,!1);try{b.send()}catch(a){}return 200<=b.status&&299>=b.status}
	function e(a){try{a.dispatchEvent(new MouseEvent("click"))}catch(c){var b=document.createEvent("MouseEvents");b.initMouseEvent("click",!0,!0,window,0,0,0,80,20,!1,!1,!1,!1,0,null),a.dispatchEvent(b)}}
	var f="object"==typeof window&&window.window===window?window:"object"==typeof self&&self.self===self?self:"object"==typeof global&&global.global===global?global:void 0,a=/Macintosh/.test(navigator.userAgent)&&/AppleWebKit/.test(navigator.userAgent)&&!/Safari/.test(navigator.userAgent),g=f.saveAs||("object"!=typeof window||window!==f?function(){}:"download"in HTMLAnchorElement.prototype&&!a?function(b,g,h){var i=f.URL||f.webkitURL,j=document.createElement("a");g=g||b.name||"download",j.download=g,j.rel="noopener","string"==typeof b?(j.href=b,j.origin===location.origin?e(j):d(j.href)?c(b,g,h):e(j,j.target="_blank")):(j.href=i.createObjectURL(b),setTimeout(function(){i.revokeObjectURL(j.href)},4E4),setTimeout(function(){e(j)},0))}:"msSaveOrOpenBlob"in navigator?function(f,g,h){if(g=g||f.name||"download","string"!=typeof f)navigator.msSaveOrOpenBlob(b(f,h),g);else if(d(f))c(f,g,h);else{var i=document.createElement("a");i.href=f,i.target="_blank",setTimeout(function(){e(i)})}}:function(b,d,e,g){if(g=g||open("","_blank"),g&&(g.document.title=g.document.body.innerText="downloading..."),"string"==typeof b)return c(b,d,e);var h="application/octet-stream"===b.type,i=/constructor/i.test(f.HTMLElement)||f.safari,j=/CriOS\/[\d]+/.test(navigator.userAgent);if((j||h&&i||a)&&"undefined"!=typeof FileReader){var k=new FileReader;k.onloadend=function(){var a=k.result;a=j?a:a.replace(/^data:[^;]*;/,"data:attachment/file;"),g?g.location.href=a:location=a,g=null},k.readAsDataURL(b)}else{var l=f.URL||f.webkitURL,m=l.createObjectURL(b);g?g.location=m:location.href=m,g=null,setTimeout(function(){l.revokeObjectURL(m)},4E4)}});f.saveAs=g.saveAs=g,"undefined"!=typeof module&&(module.exports=g)
});

(function() {
	function get_callback_func(name) {
		return name ? window["gml_Script_" + name] : null;
	}
	
	function procFile(file, gmlHandler, gmlFilter, gmlSelf, gmlOther) {
		if (gmlFilter && !gmlFilter(gmlSelf, gmlOther, "file", file.type)) return;
		
		var reader = new FileReader();
		reader.onload = function(e) {
			gmlHandler(gmlSelf, gmlOther, e.target.result, file.name || "", file.type);
		};
		reader.readAsDataURL(file);
	}
	function procItem(item, gmlHandler, gmlFilter, gmlSelf, gmlOther) {
		var item_type = item.type;
		if (gmlFilter && !gmlFilter(gmlSelf, gmlOther, item.kind, item_type)) return;
		if (!gmlHandler) return;
		if (item.kind == "string") {
			item.getAsString(function(str) {
				gmlHandler(gmlSelf, gmlOther, str, undefined, item_type);
			});
		} else if (item.kind == "file") {
			procFile(item.getAsFile(), gmlHandler, null, gmlSelf, gmlOther);
		}
	}
	
	var pasteHandler, pasteFilter, pasteSelf, pasteOther, pasteBound = false;
	function onPaste(e) {
		if (!pasteHandler) return;
		var items = e.clipboardData.items;
		for (var i = 0; i < items.length; i++) {
			procItem(items[i], pasteHandler, pasteFilter, pasteSelf, pasteOther);
		}
	}
	var onKeyDown_base = null;
	function onKeyDown_hook(e) {
		// don't let GM eat Ctrl+V/Cmd+V/Shift+Insert:
		if (pasteHandler) {
			if ((e.ctrlKey || e.metaKey) && (e.which == 86 || e.key == "v")) return;
			if (e.shiftKey && (e.which == 45 || e.key == "Insert")) return;
		}
		// run the original handler:
		if (onKeyDown_base) onKeyDown_base(e);
	}
	
	///~
	window.browser_paste_bind_raw = function(gmlHandler, gmlFilter, gmlSelf, gmlOther) {
		pasteHandler = get_callback_func(gmlHandler);
		pasteFilter = get_callback_func(gmlFilter);
		pasteSelf = gmlSelf;
		pasteOther = gmlOther;
		
		if (pasteHandler) {
			if (window.onkeydown != onKeyDown_hook) {
				onKeyDown_base = window.onkeydown;
				window.onkeydown = onKeyDown_hook;
			}
			if (!pasteBound) {
				document.addEventListener("paste", onPaste);
				pasteBound = true;
			}
		} else {
			if (window.onkeydown == onKeyDown_hook) {
				window.onkeydown = onKeyDown_base;
			}
			if (pasteBound) {
				document.removeEventListener("paste", onPaste);
				pasteBound = false;
			}
		}
	}
	
	var dropHandler, dropFilter, dropSelf, dropOther, dropBound = false;
	function onDragOver(e) {
		e.preventDefault();
		return false;
	}
	function onDrop(e) {
		e.preventDefault();
		var files = e.dataTransfer.files;
		for (var i = 0; i < files.length; i++) {
			procFile(files[i], dropHandler, dropFilter, dropSelf, dropOther);
		}
		return false;
	}
	///~
	window.browser_drop_bind_raw = function(gmlHandler, gmlFilter, gmlSelf, gmlOther) {
		dropHandler = get_callback_func(gmlHandler);
		dropFilter = get_callback_func(gmlFilter);
		dropSelf = gmlSelf;
		dropOther = gmlOther;
		
		if (dropHandler) {
			if (!dropBound) {
				document.addEventListener("dragover", onDragOver);
				document.addEventListener("dragenter", onDragOver);
				document.addEventListener("drop", onDrop);
				dropBound = true;
			}
		} else {
			if (dropBound) {
				document.removeEventListener("dragover", onDragOver);
				document.removeEventListener("dragenter", onDragOver);
				document.removeEventListener("drop", onDrop);
				dropBound = false;
			}
		}
	}
	
	var openHandler, openFilter, openSelf, openOther, openBound = false;
	var openForm, openInput;
	function onOpen(e) {
		var files = openInput.files;
		if (!files) return;
		for (var i = 0; i < files.length; i++) {
			procFile(files[i], openHandler, openFilter, openSelf, openOther);
		}
	}
	///~
	window.browser_show_open_dialog_raw = function(accept, multiselect, gmlHandler, gmlFilter, gmlSelf, gmlOther) {
		openHandler = get_callback_func(gmlHandler);
		openFilter = get_callback_func(gmlFilter);
		openSelf = gmlSelf;
		openOther = gmlOther;
		
		if (!openBound) {
			openBound = true;
			openForm = document.createElement("form");
			openForm.setAttribute("style", [
				"position: absolute",
				"top: -9999px",
				"overflow: hidden",
				"width: 0px",
				"height: 0px",
			].join(";"));
			openInput = document.createElement("input");
			openInput.type = "file";
			openInput.addEventListener("change", onOpen);
			openForm.appendChild(openInput);
			document.body.appendChild(openForm);
		} else openForm.reset();
		openInput.accept = accept;
		openInput.multiple = multiselect;
		openInput.click();
	}
	
	///~
	window.browser_show_save_dialog_raw = function(abuf, name, type, size) {
		if (abuf.length != size) {
			abuf = abuf.slice(0, size);
		}
		var blob = new Blob([abuf], { type: type });
		saveAs(blob, name);
	}
})();

