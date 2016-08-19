@echo off

echo ===================================================
echo Before start, please make sure these envionment variables already set up :
echo.
echo     * UE4_PATH（Path like this："F:\ETCVR\SH_SandBoxGame\UEengine4.12.5")
echo     * VSEXE(Path like this:"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe")
echo ---------------------------------------------------
echo.
echo Four steps:
echo.  
echo 	1. Update from Perforce...
echo 	2. Re-GenerateProjectFiles...
echo 	3. Delete dlls...
echo 	4. Visual Studio 2015 Building Project...
echo ===================================================
echo.
echo Press Any Key to continue...
pause>nul
cls

echo ===================================================
echo Update from Perforce...
echo ===================================================
echo.
echo Press Any Key to continue...
pause>nul
cls
p4 sync //SH_SandBoxGame/SolarGameUE4/...



echo ===================================================
echo Re-GenerateProjectFiles...
echo.
echo Please make a choice for Building:
ECHO 1. ignore
ECHO 2. re-generate
echo ===================================================
echo.
SET Choice=1
SET /P Choice=Your choice:
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
ECHO.
IF /I "%Choice%"=="2" call "%UE4_PATH%\Engine\Build\BatchFiles\GenerateProjectFiles.bat" %~dp0SolarGame.uproject -Game
@IF ERRORLEVEL 1 goto error1

cls
echo....................................................
echo. 
echo ===================================================
echo Delete dlls...
echo ===================================================
echo.
echo Press Any Key to continue...
pause>nul
cls

rem 文件夹遍历统配技术
for /d %%i in (%~dp0Plugins\*) do del %%i\Binaries\Win64\UE4Editor*.dll
for /d %%i in (%~dp0Plugins\*) do del %%i\Binaries\Win64\UE4Editor*.modules
del /f %~dp0Binaries\Win64\UE4Editor*.dll


IF EXIST Build.log del build.log

echo....................................................
echo. 
echo ===================================================
echo Visual Studio 2015 Building Project...
echo ===================================================
echo.
echo Press Any Key to continue...
pause>nul
cls

"%VSEXE%" %~dp0SolarGame.sln /Build "Development Editor|Win64" /Out build.log
@IF ERRORLEVEL 1 goto error2

echo ==========All Successful!
echo Press Any Key to Exit...
pause>nul
exit

:error1
echo Re-GenerateProjectFiles Error!
pause>nul
exit

:error2
echo Build errors happened, please check build.log!
pause>nul
exit