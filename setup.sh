#!/bin/bash
#
# setup symlinks for dwm desktop
# (cedwards@zelut.org)

# set some lazy-variables
DWM_GIT="${HOME}/Projects/dwm.git"

# permission checks
if [ ${UID} != 0 ]; then
    echo "run with sudo"
    return 1
fi

(pacman -Q artwiz-fonts)            || return 1
(pacman -Q dwm)                     || return 1
(pacman -Q dmenu)                   || return 1
(pacman -Q rxvt-unicode-256color)   || return 1
(pacman -Q terminus-font)           || return 1

# begin linking
ln -s "${DWM_GIT}"/.Xdefaults          "${HOME}"/.Xdefaults &>/dev/null
ln -s "${DWM_GIT}"/.xinitrc            "${HOME}"/.xinitrc &>/dev/null
ln -s "${DWM_GIT}"/.bash_aliases       "${HOME}"/.bash_aliases &>/dev/null
ln -s "${DWM_GIT}"/battery.py          "${HOME}"/battery.py &>/dev/null
ln -s "${DWM_GIT}"/server_room_temp.pl "${HOME}"/server_room_temp.pl &>/dev/null
ln -s "${DWM_GIT}"/dwm.png             "${HOME}"/dwm.png

/usr/bin/feh --bg-scale "${HOME}/dwm.png"

/bin/cp -a dwm02 /usr/share/slim/themes/

/bin/cp -a 20-fonts.conf /etc/X11/xorg.conf.d/
