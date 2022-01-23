@echo off
set /p ver="Version?: "
echo Uploading %ver%...
set user=yellowafterlife
set name=browser_file_tools
set ext=gamemaker-browser-file-tools
cmd /C itchio-butler push %name%-for-GMS1.gmez %user%/%ext%:gms1 --userversion=%ver%
cmd /C itchio-butler push %name%-for-GMS2.yymp %user%/%ext%:gms2 --userversion=%ver%
cmd /C itchio-butler push %name%-for-GMS2.3+.yymps %user%/%ext%:gms2.3 --userversion=%ver%
cmd /C itchio-butler push %name%-demo-for-GMS2.3+.yyz %user%/%ext%:gms2.3-demo --userversion=%ver%

pause