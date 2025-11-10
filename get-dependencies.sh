#!/bin/sh

set -eu

EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"
PACKAGE_BUILDER="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/make-aur-package.sh"

echo "Installing build dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm   \
	base-devel            \
	curl                  \
	git                   \
	libx11                \
	libxrandr             \
	libxss                \
	pulseaudio            \
	pulseaudio-alsa       \
	qt5-base		      \
	wget                  \
	xorg-server-xvfb      \
	zsync                 #\
#    boost-libs            \
#    desktop-file-utils    \
#    ffmpeg                \
#    gtk-update-icon-cache \
#    hicolor-icon-theme    \
#    libxkbcommon-x11      \
#    luajit                \
#    sdl2_image            \
#    sdl2_mixer            \ 
#    sdl2_ttf              \
#    tbb                   \
#    boost                 \
#    cmake                 \
#    qt5-tools             \
#    innoextract           \
#    unshield              \
#    unzip 

	

#echo "Installing debloated packages..."
#echo "---------------------------------------------------------------"
#wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
#chmod +x ./get-debloated-pkgs.sh
#./get-debloated-pkgs.sh --add-opengl --prefer-nano opus-mini

echo "Building touchhle..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$PACKAGE_BUILDER" -O ./make-aur-package.sh
chmod +x ./make-aur-package.sh
./make-aur-package.sh vcmi

pacman -Q vcmi | awk '{print $2; exit}' > ~/version
