#!/bin/sh

readonly username=$SUDO_USER

# constants
readonly remove=("garuda-setup-assistant" "garuda-welcome" "firedragon" "vim" "garuda-welcome" "geary" "sushi" "evince" "celluloid")
readonly base_install=("performance-tweaks" "garuda-backgrounds" "garuda-walpapers" "bottles-git" "discord" "visual-studio-code-bin" "dconf-editor" "vlc" "firefox" "termius" "etcher-bin" "rpi-imager" "obsidian" "obs-studio" "virt-manager" "telegram-desktop" "github-desktop")
readonly opt_install=("steam" "minecraft-launcher" "lutris" "qbittorrent")

initial_check(){
	[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
	echo -e "\033[0;32mInfo:\033[0;37m check done "
}

req_packages(){

	echo -e "\n\033[0;31mInfo:\033[0;37m Removing Garuda bloatware... " #red

	for rm in "${remove[@]}"; do
	    pamac remove "$rm" --no-confirm
	done

	echo -e "\n\033[0;32mInfo:\033[0;37m Installing updates... " 
	pacman -Syuq --noconfirm

	
	echo -e "\n\033[0;32mInfo:\033[0;37m Installing essential packages... " 
    for ins in "${base_install[@]}"; do
	    pamac install "$ins" --no-confirm --no-upgrade
	done
	
}

opt_packages(){
	echo -e "\n\033[0;32mInfo:\033[0;37m Installing optional packages... " 
	
	for opt in "${opt_install[@]}"; do
		pamac install "$opt" --no-confirm --no-upgrade
	done
	# wget -O - https://bit.ly/cl4lx | bash
}

req_tweaks(){
	gpasswd -a pawel uucp
	chown -R openvpn:openvpn /var/lib/openvpn3
	systemctl disable NetworkManager-wait-online.service
}

#MAIN
bash gnome_tweaks.sh
initial_check
req_packages
req_tweaks

# if parameter empty
if [ -z $1 ]
then         
	opt_packages
fi