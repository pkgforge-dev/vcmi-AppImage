#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q vcmi | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export ADD_HOOKS="self-updater.bg.hook"
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/vcmiclient.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/vcmiclient.svg
# app is hardcoded in multiple places
export PATH_MAPPING_HARDCODED='*vcmi*'

# Deploy dependencies
quick-sharun \
	/usr/bin/vcmi*  \
	/usr/lib/vcmi/* \
	/usr/lib/vcmi/*/*

# Turn AppDir into AppImage
quick-sharun --make-appimage
