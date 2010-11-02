#!/bin/bash
#
# setup symlinks for dwm desktop
# (cedwards@zelut.org)

# set some lazy-variables
DWM_GIT="/home/cedwards/Projects/dwm.git"
DWM_DEST="/home/cedwards"

# permission checks
if [ ${UID} != 0 ]; then
    echo "run with sudo"
    exit 1
fi

(pacman -Q artwiz-fonts)            || exit 1
(pacman -Q dwm)                     || exit 1
(pacman -Q dmenu)                   || exit 1
(pacman -Q rxvt-unicode-256color)   || exit 1
(pacman -Q terminus-font)           || exit 1
(pacman -Q slim)                    || exit 1
(pacman -Q feh)			    || exit 1

# begin linking
ln -s "${DWM_GIT}"/.Xdefaults          "${DWM_DEST}"/.Xdefaults &>/dev/null
ln -s "${DWM_GIT}"/.xinitrc            "${DWM_DEST}"/.xinitrc &>/dev/null
ln -s "${DWM_GIT}"/battery.py          "${DWM_DEST}"/battery.py &>/dev/null
ln -s "${DWM_GIT}"/server_room_temp.pl "${DWM_DEST}"/server_room_temp.pl &>/dev/null
ln -s "${DWM_GIT}"/dwm.png             "${DWM_DEST}"/dwm.png

/bin/cp -a dwm02 /usr/share/slim/themes/

/bin/cp -a 20-fonts.conf /etc/X11/xorg.conf.d/

wget -q -c http://aur.archlinux.org/packages/urxvt-url-select/urxvt-url-select.tar.gz -O ${DWM_DEST}/Downloads/urxvt-url-select.tar.gz
wget -q -c http://aur.archlinux.org/packages/ttf-droid-monovar/ttf-droid-monovar.tar.gz -O ${DWM_DEST}/Downloads/ttf-droid-monovar.tar.gz
wget -q -c http://aur.archlinux.org/packages/gtk-theme-shiki-colors-murrine/gtk-theme-shiki-colors-murrine.tar.gz -O ${DWM_DEST}/Downloads/gtk-theme-shiki-colors-murrine.tar.gz
wget -q -c http://aur.archlinux.org/packages/gnome-colors-icon-theme/gnome-colors-icon-theme.tar.gz -O ${DWM_DEST}/Downloads/gnome-colors-icon-theme.tar.gz

echo
echo "==> Build the 'urxvt-url-select' package in ~/Downloads"
echo "==> Build the 'ttf-droid-monovar' package in ~/Downloads"
echo "==> Build the 'gtk-theme-shiki-colors-murrine' package in ~/Downloads"
echo "==> Build the 'gnome-colors-icon-theme' package in ~/Downloads"
echo
