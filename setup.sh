#!/bin/sh

# constants
readonly remove=("firedragon")
readonly base_install=("bottles" "visual-studio-code-bin" "firefox" "eagle" "termius" "balena-etcher" "rpi-imager" "obsidian" "obs-studio" "telegram-desktop" "discord" "kicad" "libreoffice-fresh" "vlc" "github-cli" "github-desktop" "openvpn")
readonly opt_install=("steam" "minecraft-launcher" "lutris")

initial_check (){
	[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
	echo -e "\033[0;32mInfo:\033[0;37m check done "
}

req_packages (){
	
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
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
	
}

opt_tweaks(){

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
