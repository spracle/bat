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
ECHO ��ѡ��Ҫ���еĲ�����Ȼ�󰴻س�
ECHO =========================================
ECHO.
ECHO 1. ������
ECHO 2. ���Ƕ�
ECHO 3. ����
ECHO 4. ���±�
ECHO 5. ��ΰ
ECHO 6. �����
ECHO 7. ����
ECHO 8. ����
ECHO 9. �ܷ�
ECHO.


SET Choice=
SET /P Choice=ѡ��:
rem �趨����"Choice"Ϊ�û�������ַ�
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
rem ����������1λ,ȡ��1λ,��������132,�򷵻�ֵΪ1
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
ECHO ѡ����Ч������������
ECHO.
GOTO start
rem �����ǰ���ѡ��

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
