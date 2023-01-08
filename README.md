# Spec.bat

> Test Framework for Windows BATCH .bat files

Because I can.

```bat
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
```

```
.\ExampleSpec.bat

[PASS] :test_should_pass
[FAIL] :test_should_fail
> hi from setup
> [Failure] expected "1" to equal "2"
> [Failure] expected "Foo" to equal "Bar"
> hi from teardown
```

P.S. Totally unsupported, just playing around.
