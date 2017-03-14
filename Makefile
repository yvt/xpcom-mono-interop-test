
# C# compiler
CSC := mcs

# Gecko SDK
# The target architecture (i386/x86_64) must match that of mono
# (which can be obtained at https://developer.mozilla.org/en-US/docs/Mozilla/Gecko/Gecko_SDK)
GSDK := ./xulrunner-sdk

# Python 2.7 command
PY2 := python2

# Perl
PERL := perl

# Compiler flags
CXXFLAGS := $(CFLAGS) -I$(GSDK)/include -I$(GSDK)/include/nspr -std=c++11 -arch i386
LDFLAGS := -L$(GSDK)/lib -lxpcomglue -lmozglue
XPIDLFLAGS := -I$(GSDK)/idl

# Targets
TARGET_EXE := ManagedApplication.exe
TARGET_SO := libUnmanagedLibrary.dylib

default: all
all: $(TARGET_EXE) $(TARGET_SO)

clean:
	rm -f $(TARGET_EXE) $(TARGET_SO)
	rm -f nsIMyService.cs nsIMyService.h

.PHONY: default all clean

$(TARGET_EXE): ManagedApplication.cs nsIMyService.cs
	$(CSC) ManagedApplication.cs nsIMyService.cs

$(TARGET_SO): UnmanagedLibrary.cpp nsIMyService.h
	$(CXX) UnmanagedLibrary.cpp -shared -o $(TARGET_SO) -g $(CXXFLAGS) $(LDFLAGS)

	# macOS specific
	install_name_tool -change "@executable_path/libmozglue.dylib" "$(GSDK)/lib/libmozglue.dylib" $(TARGET_SO)
	otool -L $(TARGET_SO)

nsIMyService.h: nsIMyService.idl
	$(PY2) $(GSDK)/sdk/bin/header.py $(XPIDLFLAGS) nsIMyService.idl > nsIMyService.h || { rm -f nsIMyService.h && false; }

nsIMyService.cs: nsIMyService.idl
	$(PERL) vendor/xpidl2cs.pl -n -f ../../nsIMyService.idl -p $(GSDK)/idl/

