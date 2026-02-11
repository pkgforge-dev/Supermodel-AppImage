#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q supermodel-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook:wayland-is-broken.src.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/trzy/Supermodel/refs/heads/master/Docs/Images/Real3D_Logo.png
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/supermodel
mv /usr/share/supermodel/* ./AppDir/bin

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
#quick-sharun --test ./dist/*.AppImage
