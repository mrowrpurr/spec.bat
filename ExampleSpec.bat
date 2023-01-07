@echo off
setlocal EnableDelayedExpansion

call Spec.bat %0
for %%x in (%*) do call %%~x
exit /b 69
%END%
echo AFTER
echo AFTER
echo AFTER
echo AFTER

:setup
    echo "------ THIS IS SETUP"
    goto :eof

:teardown
    echo "-------THIS IS TEARDOWN"
    goto :eof

:test_should_pass
    @REM assert 69 == 69
    echo -------- test should pass
    goto :eof

:test_should_fail
    %assert% 69 == 69 %is_true%
    %assert% "foo" == "foo" %is_true%
    %assert% "bar" == "foo" %is_true%
    %assert% 69 == 420 %is_true%
    echo --------- test should fail
    goto :eof

:eof
    echo HI FROM EOF
