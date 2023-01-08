@echo off
setlocal EnableDelayedExpansion

set SPEC_BAT_VERSION=0.1.0

set assert=if not
set "is_true=( echo failed >%TEMP%\Spec.bat_test_failed )"

if not "%CURRENTLY_RUNNING_SPEC_FILE%" == "" goto :eof

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
        powershell -c "Select-String -Pattern ^:test -Path '%~1' | %% { $_.Line }"
    `) do (
        echo CALL RESET
        call :reset_spec
        echo RUNNING THE THING
        echo Before running, though...
        if exist "%TEMP%\Spec.bat_test_failed" (
            echo "BEFORE IT IS THERE - SO FAIL"
        ) else (
            echo "BEFORE Not there, we are good"
        )
        echo ^RUNNING TEST: %%i
        for /f "usebackq delims=" %%x in (`
            "%~1" :setup %%i :teardown
        `) do (
            echo RAN THE THING
            echo ^OUTPUT [%%x]
        )
        if exist "%TEMP%\Spec.bat_test_failed" (
            echo "IT IS THERE - SO FAIL"
            echo ^[FAIL] %%i
        ) else (
            echo "Not there, we are good"
            echo ^[PASS] %%i
        )
    )
    set CURRENTLY_RUNNING_SPEC_FILE=
    goto :eof

:reset_spec
    if exist "%TEMP%\Spec.bat_test_failed" del "%TEMP%\Spec.bat_test_failed"
    @REM pause
    if exist "%TEMP%\Spec.bat_test_failed" echo IT IS STILL THERE
    goto :eof

:usage
    echo spec.bat (version %SPEC_BAT_VERSION%)
    goto :eof
