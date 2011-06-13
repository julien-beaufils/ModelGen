@echo off

set SDK=C:\Program Files (x86)\FlashDevelop\Tools\redtamarin\v0.3

if exist "%SDK%\asc.jar" goto build
echo =====================================================
echo Please fix the path to redtamarin SDK in 'build.bat'.
echo =====================================================
exit 1

:build
set IMPORTS=-import "%SDK%\builtin.abc" -import "%SDK%\toplevel.abc"

if exist src\program.abc del /F src\program.abc
java -jar "%SDK%\asc.jar" -AS3 %IMPORTS% src\program.as

if not exist src\program.abc exit 1