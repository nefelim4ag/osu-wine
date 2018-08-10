#!/bin/bash
# I ain't living dangerously
set -e

# Error handlers
INFO(){ echo -e '\033[0;32m'"INFO:\033[0m $*"; }
WARN(){ echo -e '\033[0;33m'"WARN:\033[0m $*"; }
ERRO(){ echo -e '\033[0;31m'"ERRO:\033[0m $*"; exit 1; }

INFO "Checking dependencies..."
if [ ! -e ./osu-wine ]; then
	cd ..
	rm -rf osu-wine/
	git clone https://github.com/diamondburned/osu-wine
	cd osu-wine
fi

function install() {
	[ $EUID -ne 0 ] && ERRO "Please run as root!"
	[ -e /usr/bin/osu-wine ] && ERRO "Please uninstall before installing!"
	
	INFO "Installing icons..."
	which awk &> /dev/null || ERRO "Missing awk!";
	dimensions_arr=( $(ls ./icons | awk -F '-' '{print $3}' | awk -F '.' '{print $1}') )
	for dimensions in "${dimensions_arr[@]}"; do
		cp "./icons/osu-wine-${dimensions}.png" "/usr/share/icons/hicolor/${dimensions}/apps/osu-wine.png" || ERRO "Failed to install icons";
		chmod 644 "/usr/share/icons/hicolor/${dimensions}/apps/osu-wine.png" || ERRO "chmod icons failed";
	done
	
	INFO "Installing desktop files..."
	cp ./desktops/*.desktop /usr/share/applications/ || ERRO "Failed to install desktop files"
	chmod 644 /usr/share/applications/osu-wine*.desktop
	
	INFO "Installing main script..."
	cp ./osu-wine /usr/bin/osu-wine && chmod 755 /usr/bin/osu-wine || ERRO "Can't install script"
	
	INFO "Installing config files..."
	cp ./osu-wine.conf /etc/osu-wine
	WARN "Not installing user config file! To do so, please run this command post installation:"
	WARN "cp /etc/osu-wine.conf ~/.osu-wine.conf"

	INFO "Installation completed. Run 'osu-wine' to install."
	exit 0
}

function uninstall() {
	[ $EUID -ne 0 ] && ERRO "Please run as root!" 
	
	INFO "Uninstalling icons..."
	which awk &> /dev/null || ERRO "Missing awk!";
	dimensions_arr=( $(ls ./icons | awk -F '-' '{print $3}' | awk -F '.' '{print $1}') )
	for dimensions in "${dimensions_arr[@]}"; do
		rm -f "/usr/share/icons/hicolor/${dimensions}/apps/osu-wine.png"
	done

	INFO "Uninstalling desktop files..."
	rm -f /usr/share/applications/osu-wine*.desktop

	INFO "Uninstalling main script..."
	rm -f /usr/bin/osu-wine

	read -p "$(INFO "Do you want to uninstall the config files? (y/n)")" CHOICE
	if [[ $CHOICE = 'y' || $ CHOICE = 'Y' ]]; then
		INFO "Uninstalling config files..."
		rm -f /etc/osu-wine.conf
		WARN "Not uninstalling user config files."
	fi

	INFO "Uninstallation completed."
	exit 0
}

function help() {
	HELP="
		To install, run './install.sh'
		To uninstall, run './install.sh uninstall'
		To print this help dialog, run './install.sh help'

		More help at https://github.com/diamondburned/osu-wine
	"
	echo -e "${HELP:1:-2}" | cut -d$'\t' -f3-
}

case "$1" in
	'uninstall')	uninstall
		;;
	'help')			help
		;;
	'')				install
		;;
	*)				ERRO "Unknown argument. Refer to ./install.sh help"
		;;
esac
