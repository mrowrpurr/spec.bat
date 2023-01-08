@echo off
setlocal EnableDelayedExpansion

call Spec.bat %0
for %%x in (%*) do call %%~x

:setup
    echo "------ THIS IS SETUP"
    goto :eof

:teardown
    echo "-------THIS IS TEARDOWN"
    goto :eof

:test_should_pass
    echo HI FROM TEST SHOLD PASS
    @REM assert 69 == 69
    echo -------- test should pass
    goto :eof

:test_should_fail
    echo HI FROM TEST SHOULD FAIL
    @REM %assert% 69 == 69 %is_true%
    @REM %assert% "foo" == "foo" %is_true%
    @REM %assert% "bar" == "foo" %is_true%
    %assert% 69 == 420 %is_true%
    echo --------- test should fail
    goto :eof
