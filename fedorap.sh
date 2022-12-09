#!/bin/bash

#======================================================================#
#    __     ___  __      __   __   __   ___  __
#   |__) | |__  |__)    /  ` /  \ |  \ |__  |__)
#   |    | |___ |  \    \__, \__/ |__/ |___ |  \
#
#   My Fedora i3 post installation script.
#   Install packages after installing a base i3-Fedora installation.
#======================================================================#

echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf

sudo dnf upgrade -y
sudo dnf autoremove -y

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y fedora-workstation-repositories
sudo dnf upgrade --refresh

sudo dnf upgrade -y

sudo dnf install -y neofetch picom lxappearance \
		slick-greeter lightdm-settings \
		flameshot pasystray \
		kitty geany apostrophe \
		ristretto parole atril thunderbird \
		fontawesome-fonts thunar-archive-plugin thunar-volman \
		gtk-murrine-engine adwaita-gtk2-theme \
		python3-pip
pip3 install i3altlayout

sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

sudo dnf copr enable kwizart/fedy
sudo dnf install fedy -y

mkdir -p ~/.config/
ln -s ~/FedoraP/.config/* ~/.config/
ln -s ~/FedoraP/.config/.picom.conf ~/.config/

mkdir -p ~/.wallpapers
cp bg.jpg ~/.wallpapers

mkdir geanythemes
cd geanythemes
git clone https://github.com/geany/geany-themes
mkdir -p ~/.config/geany/colorschemes/
mv geany-themes/colorschemes/*.conf ~/.config/geany/colorschemes/
cd ..
rm -rf geanythemes

sudo dnf upgrade -y
sudo dnf autoremove -y

sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
