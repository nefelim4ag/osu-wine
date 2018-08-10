# osu-wine
osu! install/run wrapper, forked by diamondburned.

## Instructions

Run `./install.sh` **as root/sudo**

## Uninstalling

Run `./install.sh uninstall` **as root/sudo**

## Installing user config file

Run `cp /etc/osu-wine.conf ~/.osu-wine.conf` as user

## Extra options

- `osu-wine --winetricks [packages]` runs `winetricks` inside that `WINEPREFIX`
- `osu-wine --winecfg` opens `winecfg` dialog
- `marcRPC=true` in `~/.osu-wine.conf` enables Rich Presence support 
- PooN's `wine-osu` instructions:
	- At the bottom of the `~/.osu-wine.conf` file, there are 2 variables:
		1. `STAGING_AUDIO_DURATION` to change audio duration
		2. `PATH` to make osu! use PooN's Wine (you must NOT change this)
	- [More information at his blog](https://blog.thepoon.fr/osuLinuxAudioLatency/)

## Credits

- [Original code](https://github.com/Nefelim4ag/osu-wine) by [Nefelim4ag](https://github.com/Nefelim4ag)
- [Wine RPC](https://github.com/Marc3842h/rpc-wine) by [Marc3842h](https://github.com/Marc3842h)
