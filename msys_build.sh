#!/bin/sh

set -e

if [ "$ARCH" = x86_64 ]; then
  bits=64
else
  bits=32
fi

# Use this mingw instead of the pre-installed mingw on Appveyor
if [ "$COMPILER" = g++ ]; then
    f=mingw-w$bits-bin-$ARCH-20161221.7z
    if ! [ -e $f ]; then
	echo "Downloading $f"
	curl -LsSO https://sourceforge.net/projects/mingw-w64-dgn/files/mingw-w64/$f
    fi
    7z x $f > /dev/null
    export PATH=$PWD/mingw$bits/bin:$PATH
fi

cd /c/projects/world-1
mkdir -p build && cd build
cmake -G "MSYS Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON ..
make
