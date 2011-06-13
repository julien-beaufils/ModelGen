@echo off

set SDK=C:\Program Files (x86)\FlashDevelop\Tools\redtamarin\v0.3

if exist "%SDK%\asc.jar" goto build
echo =====================================================
echo Please fix the path to redtamarin SDK in 'build.bat'.
echo =====================================================
exit 1

:build
set IMPORTS=-import "%SDK%\builtin.abc" -import "%SDK%\toplevel.abc"
set SHELL="%SDK%\redshell.exe"

java -jar "%SDK%\asc.jar" -AS3 %IMPORTS% -exe %SHELL% src\program.as

if not exist src\program.exe exit 1
move /Y src\program.exe bin\modelGen.exe