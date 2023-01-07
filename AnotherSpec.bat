:setup
    echo "THIS IS SETUP"
    goto :end

:teardown
    echo "THIS IS TEARDOWN"
    goto :end

:test_should_pass
    @REM assert 69 == 69
    echo test should pass
    goto :end

:test_should_fail
    @REM assert 69 == 420
    echo test should fail
    goto :end
