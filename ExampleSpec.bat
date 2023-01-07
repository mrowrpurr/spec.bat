@echo off

call Spec.bat %0
%RUN_SPECS%

:setup
    echo "THIS IS SETUP"
    goto :eof

:teardown
    echo "THIS IS TEARDOWN"
    goto :eof

:test_should_pass
    @REM assert 69 == 69
    echo test should pass
    goto :eof

:test_should_fail
    @REM this command does not exist
    @REM assert 69 == 420
    echo test should fail
    goto :eof
