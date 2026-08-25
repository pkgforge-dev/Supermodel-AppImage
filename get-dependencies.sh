#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    glu      \
    sdl2_net

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

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
