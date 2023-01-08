@echo off
setlocal EnableDelayedExpansion

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
    %assert% 69 == 420 %is_true%
    echo after fail
    goto :eof
