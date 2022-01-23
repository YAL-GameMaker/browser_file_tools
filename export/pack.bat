@echo off

set name=browser_file_tools

if not exist "%name%-for-GMS1" mkdir "%name%-for-GMS1"
cmd /C copyre ..\%name%.gmx\extensions\%name%.extension.gmx %name%-for-GMS1\%name%.extension.gmx
cmd /C copyre ..\%name%.gmx\extensions\%name% %name%-for-GMS1\%name%
cmd /C copyre ..\%name%.gmx\datafiles\%name%.html %name%-for-GMS1\%name%\Assets\datafiles\%name%.html
cd %name%-for-GMS1
cmd /C 7z a %name%-for-GMS1.7z *
move /Y %name%-for-GMS1.7z ../%name%-for-GMS1.gmez
cd ..

if not exist "%name%-for-GMS2\extensions" mkdir "%name%-for-GMS2\extensions"
if not exist "%name%-for-GMS2\datafiles" mkdir "%name%-for-GMS2\datafiles"
if not exist "%name%-for-GMS2\datafiles_yy" mkdir "%name%-for-GMS2\datafiles_yy"
cmd /C copyre ..\%name%_yy\extensions\%name% %name%-for-GMS2\extensions\%name%
cmd /C copyre ..\%name%_yy\datafiles\%name%.html %name%-for-GMS2\datafiles\%name%.html
cmd /C copyre ..\%name%_yy\datafiles_yy\%name%.html.yy %name%-for-GMS2\datafiles_yy\%name%.html.yy
cd %name%-for-GMS2
cmd /C 7z a %name%-for-GMS2.zip *
move /Y %name%-for-GMS2.zip ../%name%-for-GMS2.yymp
cd ..

if not exist "%name%-for-GMS2.3+\extensions" mkdir "%name%-for-GMS2.3+\extensions"
if not exist "%name%-for-GMS2.3+\datafiles" mkdir "%name%-for-GMS2.3+\datafiles"
cmd /C copyre ..\%name%_23\extensions\%name% %name%-for-GMS2.3+\extensions\%name%
cmd /C copyre ..\%name%_23\datafiles\%name%.html %name%-for-GMS2.3+\datafiles\%name%.html
cd %name%-for-GMS2.3+
cmd /C 7z a %name%-for-GMS2.3+.zip *
move /Y %name%-for-GMS2.3+.zip ../%name%-for-GMS2.3+.yymps
cd ..

cd ..\%name%_23
cmd /C 7z a %name%-demo-for-GMS2.3+.zip *
move /Y %name%-demo-for-GMS2.3+.zip ..\export\%name%-demo-for-GMS2.3+.yyz
cd ..\export

pause