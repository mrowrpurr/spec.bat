@echo off
setlocal EnableDelayedExpansion

if not "%CURRENTLY_RUNNING_SPEC_FILE%" == "" goto :eof

set SPEC_BAT_VERSION=0.1.0

if "%~1" == "" call :usage
if "%~2" == "run" (
    echo ^RUN %3
    goto %3
    goto :eof
)

:process_arguments
    if not "%~1" == "" call :run_spec "%~1"
    shift
    if not "%~1" == "" goto :process_arguments
    goto :eof

goto :eof

:run_spec
    echo ^RUN %~1
    set CURRENTLY_RUNNING_SPEC_FILE="%~1"
    for /f "usebackq delims=" %%i in (`
        powershell -c "Select-String -Pattern ^: -Path '%~1' | %% { $_.Line }"
    `) do (
        call "%~1" %%i
    )
    set CURRENTLY_RUNNING_SPEC_FILE=
    goto :eof

:usage
    echo spec.bat (version %SPEC_BAT_VERSION%)
    goto :eof