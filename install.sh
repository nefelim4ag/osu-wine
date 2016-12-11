#!/bin/bash
################################################################################
# echo wrappers
INFO(){ echo -n "INFO: "; echo "$@" ;}
WARN(){ echo -n "WARN: "; echo "$@" ;}
ERRO(){ echo -n "ERRO: "; echo -n "$@" ; echo " Abort!"; exit 1;}

PREFIX="/"
case $1 in
    PREFIX=*) PREFIX="${1//PREFIX=/}";;
esac

cd "$(dirname "$0")" || exit 1
if [ "$PREFIX" == "/" ]; then
    if [ "$UID" != "0" ]; then
        command -v sudo &> /dev/null || ERRO "Run by root or install sudo!"
        SUDO=sudo
    else
        unset SUDO
    fi
fi

$SUDO install -Dm644 ./osu-wine.conf    "$PREFIX/etc/osu-wine.conf"
$SUDO install -Dm755 ./osu-wine         "$PREFIX/usr/bin/osu-wine"
$SUDO install -Dm644 ./osu-wine.png     "$PREFIX/usr/share/icons/hicolor/256x256/apps/osu-wine.png"

$SUDO install -Dm644 ./osu-wine.desktop "$PREFIX/usr/share/applications/osu-wine.desktop"
$SUDO install -Dm644 ./osu-wine-osk.desktop "$PREFIX/usr/share/applications/osu-wine-osk.desktop"
$SUDO install -Dm644 ./osu-wine-osr.desktop "$PREFIX/usr/share/applications/osu-wine-osr.desktop"
$SUDO install -Dm644 ./osu-wine-osz.desktop "$PREFIX/usr/share/applications/osu-wine-osz.desktop"
$SUDO install -Dm644 ./osu-wine-osz2.desktop "$PREFIX/usr/share/applications/osu-wine-osz2.desktop"
