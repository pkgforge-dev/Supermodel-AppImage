#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    glu      \
    sdl2_net \
    zlib

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

# Comment this out if you need an AUR package
#make-aur-package supermodel-git
#mkdir -p /usr/share/supermodel/Assets
#mv -v supermodel-git/src/supermodel/Assets/* /usr/share/supermodel/Assets/
# If the application needs to be manually built that has to be done down here

echo "Building Supermodel..."
echo "---------------------------------------------------------------"
REPO="https://github.com/trzy/Supermodel"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./Supermodel
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./Supermodel
make -f 'Makefiles/Makefile.UNIX'
mv -v ./bin/supermodel ./Assets ./Config ../AppDir/bin
