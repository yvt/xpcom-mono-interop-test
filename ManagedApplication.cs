using System;
using System.Runtime.InteropServices;
using Mono.Mozilla;

static class NativeMethods
{
    [DllImport("UnmanagedLibrary")]
    public static extern void CLInitialize([MarshalAs(UnmanagedType.Interface)] out nsIMyService outService);
}

namespace Mono.WebBrowser
{
    interface IWebBrowser
    {
        // I just dunno what this does *derp*
    }
}

namespace Mono.Mozilla
{
    static class Base
    {
        public static object GetProxyForObject(Mono.WebBrowser.IWebBrowser control, Guid guid, object hoge)
        {
            // I just dunno what this does *derp*
            return null;
        }
    }
}

[ComVisible(true)]
class MyService : nsIMyService
{
    public void Hoge(nsIMyService otherService)
    {
        Console.WriteLine("MyService.Hoge (managed)");
    }
}

public static class ManagedApplication
{
    public static void Main(string[] args)
    {
        nsIMyService comService;
        NativeMethods.CLInitialize(out comService);

        comService.Hoge(null);
        comService.Hoge(new MyService());
    }
}
