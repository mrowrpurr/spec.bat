@echo off
setlocal EnableDelayedExpansion

set SPEC_BAT_VERSION=0.1.0

set fail=call %0 fail
set assert_eq=call %0 assert_eq
set "or_fail=& if exist %TEMP%\Spec_bat_test_failed goto :eof"

if "%~1" == "fail" (
    echo.>%TEMP%\Spec_bat_test_failed
    set "_args=%*"
    set "_args=!_args:*%1 =!"
    echo ^[Failure] !_args!
    goto :eof
)

if "%~1" == "assert_eq" (
    if not "%~2" == "%~3" (
        %fail% expected "%~2" to equal "%~3"
    )
    goto :eof
)

if not "%CURRENTLY_RUNNING_SPEC_FILE%" == "" goto :eof

if "%~1" == "" call :usage

:process_arguments
    if not "%~1" == "" call :run_spec "%~1"
    shift
    if not "%~1" == "" goto :process_arguments
    goto :eof

goto :eof

:run_spec
(set \n=^
%=DO NOT REMOVE THIS LINE - This creates a variable for using newlines in PowerShell commands=%
)
    set CURRENTLY_RUNNING_SPEC_FILE="%~1"
    set SETUP=
    set TEARDOWN=
    for /f "usebackq delims=" %%i in (`
        powershell -c "Select-String -Pattern ^:setup$ -Path '%~1' | %% { $_.Line }"
    `) do set SETUP=:setup
    for /f "usebackq delims=" %%i in (`
        powershell -c "Select-String -Pattern ^:teardown$ -Path '%~1' | %% { $_.Line }"
    `) do set TEARDOWN=:teardown
    for /f "usebackq delims=" %%i in (`
        powershell -c "Select-String -Pattern ^:test -Path '%~1' | %% { $_.Line }"
    `) do (
        call :reset_spec
        set SPEC_OUTPUT=
        for /f "usebackq delims=" %%x in (`
            "%~1" %SETUP% %%i %TEARDOWN%
        `) do (
            set SPEC_OUTPUT=!SPEC_OUTPUT!^> %%x!\n!
        )
        if exist "%TEMP%\Spec_bat_test_failed" (
            echo ^[FAIL] %%i
            echo ^!SPEC_OUTPUT!
        ) else (
            echo ^[PASS] %%i
        )
    )
    set CURRENTLY_RUNNING_SPEC_FILE=
    goto :eof

:reset_spec
    if exist "%TEMP%\Spec_bat_test_failed" del "%TEMP%\Spec_bat_test_failed" >nul
    goto :eof

:usage
    echo spec.bat (version %SPEC_BAT_VERSION%)
    goto :eof
