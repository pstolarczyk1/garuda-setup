#!/bin/sh

# constants
readonly remove=("garuda-setup-assistant" "garuda-welcome" "firedragon" "")
readonly base_install=("performance-tweaks" "garuda-backgrounds" "garuda-walpapers" "bottles" "visual-studio-code-bin" "firefox" "eagle" "termius" "balena-etcher" "rpi-imager" "obsidian" "obs-studio" "telegram-desktop" "git"performance-tweaks
	echo -e "\n\033[0;32mInfo:\033[0;37m Installing essential packages... " 
    for ins in "${base_install[@]}"; do
	    pamac install "$ins" --no-confirm --no-upgrade
	done
	
}

opt_packages (){
	echo -e "\n\033[0;32mInfo:\033[0;37m Installing optional packages... " 
	
	for opt in "${base_install[@]}"; do
		pamac install "$opt" --no-confirm --no-upgrade
	done
	wget -O - https://bit.ly/cl4lx | bash
}

req_tweaks(){
	gpasswd -a pawel uucp
	chown -R openvpn:openvpn /var/lib/openvpn3
	systemctl disable NetworkManager-wait-online.service
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll "true"
	gsettings set org.gnome.desktop.peripherals.touchpad click-method default
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	
}

opt_tweaks(){
	gsettings set org.gnome.desktop.background show-desktop-icons true

}


#MAIN
initial_check
req_packages
if [ -z $1 ]
then
	opt_packages
	opt_tweaks
fi
req_tweaks



#TODO:


#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Launch terminal'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'<Super>t'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'gnome-terminal'"
