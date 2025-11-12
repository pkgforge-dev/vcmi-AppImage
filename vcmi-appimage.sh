#!/bin/sh

set -eux

ARCH="$(uname -m)"
VERSION="$(cat ~/version)"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"

export ADD_HOOKS="self-updater.bg.hook"
export OUTPUT_APPIMAGE=1
export OUTNAME=vcmi-"$VERSION"-"$ARCH".AppImage
export DESKTOP=/usr/share/applications/vcmiclient.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/vcmiclient.svg

#Download and run quick-sharun
curl -o ./quick-sharun "$SHARUN"
chmod +x ./quick-sharun
./quick-sharun /usr/bin/vcmi*

mkdir -p ./dist
mv -v ./*.AppImage* ./dist
mv -v ~/version     ./dist
