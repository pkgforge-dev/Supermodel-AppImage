#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q supermodel-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/trzy/Supermodel/refs/heads/master/Docs/Images/Real3D_Logo.png
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/supermodel
mv /usr/share/supermodel/* ./AppDir/bin
echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/bin' >> ~/.config/supermodel/.env

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
