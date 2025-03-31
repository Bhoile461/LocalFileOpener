@echo off
setlocal enabledelayedexpansion

REM Log setup
echo Starting file opener > "%TEMP%\file_opener_log.txt"
echo Command: %* >> "%TEMP%\file_opener_log.txt"

REM Get protocol path
set "protocol_path=%~1"
echo Protocol path: %protocol_path% >> "%TEMP%\file_opener_log.txt"

REM Remove prefix
set "file_path=%protocol_path:fileopen://=%"
echo After removing prefix: %file_path% >> "%TEMP%\file_opener_log.txt"

REM Normalize slashes
set "clean_path=%file_path:/=\%"
echo Clean path: %clean_path% >> "%TEMP%\file_opener_log.txt"

REM Fix missing colon in drive letter
if "%clean_path:~1,1%" NEQ ":" (
  if "%clean_path:~0,1%" GEQ "A" if "%clean_path:~0,1%" LEQ "Z" (
    set "clean_path=%clean_path:~0,1%:%clean_path:~1%"
    echo Fixed missing colon: %clean_path% >> "%TEMP%\file_opener_log.txt"
  )
)

echo Final path: %clean_path% >> "%TEMP%\file_opener_log.txt"

REM Check if file exists
if exist "%clean_path%" (
  echo File exists >> "%TEMP%\file_opener_log.txt"

  REM Check file extension
  for %%F in ("%clean_path%") do set "ext=%%~xF"
  echo File extension: !ext! >> "%TEMP%\file_opener_log.txt"

  if /I "!ext!"==".rpt" (
    REM Try launching with rundll32
    echo Launching with rundll32... >> "%TEMP%\file_opener_log.txt"
    rundll32.exe shell32.dll,ShellExec_RunDLL "%clean_path%"
  ) else (
    echo trying with start command... >> "%TEMP%\file_opener_log.txt"
    start "" "%clean_path%"
  )
) else (
  echo File not found: %clean_path% >> "%TEMP%\file_opener_log.txt"
  echo File not found: %clean_path%
)

endlocal