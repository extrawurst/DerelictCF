/*
The MIT License (MIT)

Copyright (c) 2015 Stephan Dilly

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
module derelict.cf.cf;

public
{
	import derelict.cf.types;
	import derelict.cf.funcs;
}

private
{
    import derelict.util.loader;

    version(darwin)
        version = MacOSX;
    version(OSX)
        version = MacOSX;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if (Derelict_OS_Mac)
        enum libNames = "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation";
    else
        static assert(0, "No implemenation of this lib on this OS");
}

final class DerelictCFLoader : SharedLibLoader
{
    protected
    {
        override void loadSymbols()
        {
			bindFunc(cast(void**)&CFBundleGetMainBundle, "CFBundleGetMainBundle");
            bindFunc(cast(void**)&CFBundleCopyResourcesDirectoryURL, "CFBundleCopyResourcesDirectoryURL");
            bindFunc(cast(void**)&CFURLGetFileSystemRepresentation, "CFURLGetFileSystemRepresentation");
            bindFunc(cast(void**)&CFRelease, "CFRelease");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictCFLoader DerelictCF;

shared static this()
{
	DerelictCF = new DerelictCFLoader();
}
