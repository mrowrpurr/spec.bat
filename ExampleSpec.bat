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
    %assert_eq% 69 == 69
    goto :eof

:test_should_fail
    %assert_eq% 1 2
    %assert_eq% Foo Bar %or_fail%
    %assert_eq% 69 420
    goto :eof
