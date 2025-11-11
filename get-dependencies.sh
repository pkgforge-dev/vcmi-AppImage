#!/bin/sh

set -eu

EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"
PACKAGE_BUILDER="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/make-aur-package.sh"

echo "Installing build dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel          \
	boost				\
	cmake				\
	curl                \
	git                 \
	libx11              \
	libxrandr           \
	libxss              \
	minizip				\
	ninja				\
	pulseaudio          \
	pulseaudio-alsa     \
	qt6-tools		    \
	wget                \
	xorg-server-xvfb    \
	zsync               \

	

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-opengl --prefer-nano opus-mini

echo "Building vcmi..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$PACKAGE_BUILDER" -O ./make-aur-package.sh
chmod +x ./make-aur-package.sh
./make-aur-package.sh --chaotic-aur vcmi

pacman -Q vcmi | awk '{print $2; exit}' > ~/version
