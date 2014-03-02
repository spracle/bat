@ECHO off
del 1.txt
echo .pdb>>1.txt
echo .lib>>1.txt
echo .exp>>1.txt
echo .log>>1.txt
echo .txt>>1.txt
echo .ilk>>1.txt
echo .suo>>1.txt
echo .bak>>1.txt
echo .svn>>1.txt
:start
CLS
ECHO =========================================
ECHO 请选择要进行的操作，然后按回车
ECHO =========================================
ECHO.
ECHO 1. 伯广雨
ECHO 2. 高亚东
ECHO 3. 骆易
ECHO 4. 汪德兵
ECHO 5. 汪伟
ECHO 6. 王洪浩
ECHO 7. 杨旭
ECHO 8. 杨轩
ECHO 9. 周帆
ECHO.


SET Choice=
SET /P Choice=选择:
rem 设定变量"Choice"为用户输入的字符
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
rem 如果输入大于1位,取第1位,比如输入132,则返回值为1
ECHO.
IF /I "%Choice%"=="1" SET IP=172.27.1.69
IF /I "%Choice%"=="2" SET IP=172.27.1.133
IF /I "%Choice%"=="3" SET IP=172.27.1.27
IF /I "%Choice%"=="4" SET IP=172.27.1.137
IF /I "%Choice%"=="5" SET IP=172.27.1.35
IF /I "%Choice%"=="6" SET IP=172.27.1.39
IF /I "%Choice%"=="7" SET IP=172.27.1.66
IF /I "%Choice%"=="8" SET IP=172.27.1.128
IF /I "%Choice%"=="9" SET IP=172.27.1.20
GOTO yi
ECHO 选择无效，请重新输入
ECHO.
GOTO start
rem 以上是按键选项

:yi
CLS

ECHO.
IF NOT EXIST  .\%IP% md .\%IP%
cd .\%IP%
rd /q /s .\script\
xcopy /e /y \\%IP%\script\*.lua .\script\
xcopy /e /y \\%IP%\script\*.dll .\script\
xcopy /e /y \\%IP%\client\script\*.* .\script\
xcopy \\%IP%\client\*.* /y /D /EXCLUDE:../1.txt
xcopy \\%IP%\client\Audio\*.* Audio\ /y /D /S /EXCLUDE:../1.txt
xcopy \\%IP%\client\Data\*.* Data\ /y /D /S
xcopy \\%IP%\client\Media\*.* Media\ /y /D /S /EXCLUDE:../1.txt
xcopy \\%IP%\client\UIDataFiles\*.* UIDataFiles\ /y /D /S /EXCLUDE:../1.txt

del /f/s/q  .\crashdump\*.*
del /f/s/q  .\log\*.*
del /f/s/q  .\*.log

.\Client.exe  ip:%IP%

pause
