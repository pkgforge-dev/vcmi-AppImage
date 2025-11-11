#!/bin/sh
set -eux

ARCH="$(uname -m)"
VERSION="$(cat ~/version)"

#export ADD_HOOKS="self-updater.bg.hook"
export OUTNAME=vcmi-"$VERSION"-musl-"$ARCH".AppImage
#export DESKTOP=./vcmi/usr/share/applications/vcmiclient.desktop
#export ICON=./vcmi/usr/share/icons/hicolor/scalable/apps/vcmiclient.svg
#export URUNTIME_PRELOAD=1

export DESKTOP=DUMMY
export ICON=DUMMY

SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"

# Copy shipped libraries
#mkdir -p ./AppDir/lib/
#cp -r ./vcmi/usr/lib/x86_64-linux-gnu/vcmi/*.so ./AppDir/lib/
#cp -r ./vcmi/usr/lib/x86_64-linux-gnu/vcmi/AI/*.so ./AppDir/lib/

# ADD LIBRARIES

#Copy needed data
#mkdir -p ./AppDir/share/vcmi
#cp -r ./vcmi/usr/share/vcmi/* ./AppDir/share/vcmi/

tree .
#Download and run quick-sharun
curl -o ./quick-sharun "$SHARUN"
chmod +x ./quick-sharun
./quick-sharun ./vcmi/usr/games/* #./vcmi/usr/share/libs/vcmi/* ./vcmi/usr/share/libs/vcmi/AI*


# turn appdir into appimage
curl -o ./uruntime2appimage "$URUNTIME"
chmod +x ./uruntime2appimage
./uruntime2appimage

mkdir -p ./dist
mv -v ./*.AppImage* ./dist
