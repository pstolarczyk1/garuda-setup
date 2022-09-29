#!/bin/sh

readonly username=$SUDO_USER

# constants
readonly remove=("garuda-setup-assistant" "garuda-welcome" "firedragon" "")
readonly base_install=("performance-tweaks" "garuda-backgrounds" "garuda-walpapers" "bottles" "visual-studio-code-bin" "firefox" "eagle" "termius" "balena-etcher" "rpi-imager" "obsidian" "obs-studio" "telegram-desktop" "git" "kicad" "github-desktop")
readonly opt_install=("steam" "minecraft-launcher" "lutris")

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
	pamac update --no-confirm

	
	echo -e "\n\033[0;32mInfo:\033[0;37m Installing essential packages... " 
    for ins in "${base_install[@]}"; do
	    pamac install "$ins" --no-confirm --no-upgrade
	done
	
}

opt_packages(){
	echo -e "\n\033[0;32mInfo:\033[0;37m Installing optional packages... " 
	
	for opt in "${base_install[@]}"; do
		pamac install "$opt" --no-confirm --no-upgrade
	done
	# wget -O - https://bit.ly/cl4lx | bash
}

req_tweaks(){
	gpasswd -a pawel uucp
	chown -R openvpn:openvpn /var/lib/openvpn3
	systemctl disable NetworkManager-wait-online.service
	
}

gnome_tweaks(){
	su pawel --session-command "bash s.sh"
	# sudo -Eu pawel "bash gnome_tweaks.sh"
}


#MAIN

initial_check
req_packages
req_tweaks
# if parameter empty
if [ -z $1 ]
then         
	opt_packages
	gnome_tweaks
fi
