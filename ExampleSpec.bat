@echo off
setlocal EnableDelayedExpansion
set VERBOSE=true

call Spec.bat %0
for %%x in (%*) do call %%~x
goto :eof

:setup
    echo ^hi from setup
    goto :eof

:teardown
    echo ^hi from teardown
    goto :eof

:test_should_pass
    %assert% 69 == 69 %is_true%
    goto :eof

:test_should_fail
    echo before fail
    %assert_eq% 69 420
    echo after fail
    goto :eof
