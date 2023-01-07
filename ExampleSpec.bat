@echo off

call Spec.bat %0
for %%x in (%*) do call %%~x 
goto :eof

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
    @REM assert 69 == 420
    echo test should fail
    goto :eof
