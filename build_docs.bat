RD %~dp0doc\script\ /S /Q
call %~dp0lua\luadoc_start.bat bin -d %~dp0doc\script\ 

REM call Python26\Scripts\rst2s5.bat doc\design\pve.txt doc\slide\pve.html
REM call Python26\Scripts\rst2html.bat doc\design\pve_state.txt doc\html\pve_state.html
REM call Python26\Scripts\rst2s5.bat doc\work.txt doc\slide\work.html

pause
