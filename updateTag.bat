@echo off
 
set VSEXE="D:\Microsoft\Visual Studio 9.0\Common7\IDE\devenv.exe"
set TAG_DIR=E:
set TAG_PATH=E:/ETC_Depot/tag
set RecordDisk=%~d0
set RecordPath=%~dp0
 
echo.
echo.
echo ===================================================
echo Steps:
echo 1. Sync tag depot 
echo 2. Generating vs solution and Building solution
echo 3. Copy Files 
echo 4. SVN Add New files:
echo ===================================================
echo.
echo step 1. Sync tag depot ...
echo.
echo Make sure:
echo Set up your tag depot Path
echo ===================================================
echo.
echo Press Any Key to continue...
pause>nul
cls
 
 
p4 sync %TAG_PATH%/...
@IF ERRORLEVEL 1 PAUSE echo p4 sync Error
 
echo.
echo.
echo ================p4 Sync Successful!
echo.
echo.
echo ===================================================
echo step 2. Generating vs solution and Building solution
echo.
echo Make Sure that:
echo 1. Set up your devenv.exe path(if chosing building by VS)
echo 2. make sure_  #define TAG_USE_PRESTIGE    1 (File Path: ETC_Depot\tag\include\tag\config.h)
echo ===================================================
echo.
echo Press Any Key to continue...
pause>nul
cls
 
 
%TAG_DIR%
cd  %TAG_PATH%/build
set MAINSLNFILE=./vs2008/tagmain.sln
set THIRDSLNFILE=./vs2008/thirdparty.sln
 
echo. 
echo ===================================================
echo Generating Vs2008 solution............................
echo ===================================================
echo. 
premake4 vs2008
 
ECHO.
ECHO =========================================
ECHO Please make a choice for Building:
ECHO =========================================
ECHO.
ECHO 1. vs
ECHO 2. incrediBuild
ECHO.
 
SET Choice=1
SET /P Choice=Your choice:
IF NOT "%Choice%"=="" SET Choice=%Choice:~0,1%
ECHO.
 
 
IF EXIST Build.log del build.log
 
echo. 
echo ===================================================
echo Visual Studio 2008 Building THIRDSLNFILE...
echo ===================================================
echo. 
 
IF /I "%Choice%"=="1" %VSEXE% %THIRDSLNFILE% /Build "Debug|Win32" /Out build.log
IF /I "%Choice%"=="2" BuildConsole %THIRDSLNFILE% /prj="*" /Build /OpenMonitor /cfg="Debug|Win32" /Out build.log
@IF ERRORLEVEL 1 PAUSE
 
IF /I "%Choice%"=="1" %VSEXE% %THIRDSLNFILE% /Build "Release|Win32" /Out build.log
IF /I "%Choice%"=="2" BuildConsole %THIRDSLNFILE% /prj="*" /Build /OpenMonitor /cfg="Release|Win32" /Out build.log
@IF ERRORLEVEL 1 PAUSE
 
IF /I "%Choice%"=="1" %VSEXE% %THIRDSLNFILE% /Build "Profile|Win32" /Out build.log
IF /I "%Choice%"=="2" BuildConsole %THIRDSLNFILE% /prj="*" /Build /OpenMonitor /cfg="Profile|Win32" /Out build.log
@IF ERRORLEVEL 1 PAUSE
 
echo. 
echo ===================================================
echo Visual Studio 2008 Building MAINSLNFILE ....
echo ===================================================
echo. 
 
IF /I "%Choice%"=="1" %VSEXE% %MAINSLNFILE% /Build "ReleaseDLL|Win32" /Out build.log
IF /I "%Choice%"=="2" BuildConsole %MAINSLNFILE% /prj="*" /Build /OpenMonitor /cfg="ReleaseDLL|Win32" /Out build.log
@IF ERRORLEVEL 1 PAUSE
 
IF /I "%Choice%"=="1" %VSEXE% %MAINSLNFILE% /Build "ProfileDLL|Win32" /Out build.log
IF /I "%Choice%"=="2" BuildConsole %MAINSLNFILE% /prj="*" /Build /OpenMonitor /cfg="ProfileDLL|Win32" /Out build.log
@IF ERRORLEVEL 1 PAUSE
 
IF /I "%Choice%"=="1" %VSEXE% %MAINSLNFILE% /Build "DebugDLL|Win32" /Out build.log
IF /I "%Choice%"=="2" BuildConsole %MAINSLNFILE% /prj="*" /Build /OpenMonitor /cfg="DebugDLL|Win32" /Out build.log
@IF ERRORLEVEL 1 PAUSE
 
echo.
echo.
echo ================Building Successful!
echo. 
echo.
echo ===================================================
echo Step 3: COPY Files....
echo ===================================================
echo. 
echo Press Any Key to Copy Files...
pause>nul
cls
 
%RecordDisk%
cd %RecordPath%
 
echo copy  dll
xcopy /Y/R "%TAG_PATH%\bin\tag_*_vs2008.dll" ..\bin\
@IF ERRORLEVEL 1 echo copy dll Error PAUSE
xcopy /Y/R "%TAG_PATH%\bin\tag_*_vs2008.pdb" ..\bin\
@IF ERRORLEVEL 1 echo copy dll Error PAUSE
 
echo copy lib
xcopy /Y/R "%TAG_PATH%\lib\tag_*_vs2008.lib" ..\lib\
@IF ERRORLEVEL 1 echo copy lib Error PAUSE
 
echo copy  *.h
xcopy /Y/R/S "%TAG_PATH%\include\*.h" ..\sdk\
@IF ERRORLEVEL 1 echo copy *.h Error PAUSE
xcopy /Y/R/S "%TAG_PATH%\include\*.inl" ..\sdk\
@IF ERRORLEVEL 1 echo copy *.h Error PAUSE
 
echo editor
xcopy /Y/R/S "%TAG_PATH%\tool\prestigeeditor\frontend\*.*" ..\bin\prestige\
@IF ERRORLEVEL 1 echo copy editor Error PAUSE
 
echo.
echo.
echo ================Copy Successful!
echo ===================================================
echo Step4: SVN Add New files
echo ===================================================
echo.
echo Press Any Key to Continue...
pause>nul
cls
 
echo add new file
for /f "delims=" %%a in ('dir ..\sdk\tag\*.h /b /s') do svn add --force %%a
@IF ERRORLEVEL 1 echo add Error PAUSE
for /f "delims=" %%a in ('dir ..\bin\prestige\*.* /b /s') do svn add --force %%a
@IF ERRORLEVEL 1 echo add Error PAUSE
 
echo ================Add Successful!
echo.
echo.
echo All Done Successfully!
echo Press Any Key to Exist...
pause>nul