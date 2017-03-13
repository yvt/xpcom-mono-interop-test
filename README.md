XPCOM-Mono Interop Test
=======================

Playing around with XPCOM for some awesome new project

Only tested on macOS

Example Output
--------------

```
$ mono ManagedApplication.exe
entering CLInitialize (native)
leaving CLInitialize (native)
nsMyService::Hoge(nullptr) (native)
nsMyService::Hoge(non-nullptr) (native)
MyService.Hoge (managed)
```

References
----------

- Mono, "[`cominterop.c`](https://github.com/mono/mono/blob/master/mono/metadata/cominterop.c)"
- Mono, "[*COM Interop*](http://www.mono-project.com/docs/advanced/com-interop/)"
- Mozilla Developer Network, "[*Gecko SDK*](https://developer.mozilla.org/en-US/docs/Mozilla/Gecko/Gecko_SDK)"
- Mozilla Developer Network, "[*Creating the Component Code*](https://developer.mozilla.org/en-US/docs/Mozilla/Tech/XPCOM/Guide/Creating_components/Creating_the_Component_Code#Creating_an_Instance_of_Your_Component)"
