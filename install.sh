#!/bin/bash
#####Setup script for laptop i3

#####basic setups--drivers, sound, etc. 
apt-get install -y software-properties-common
add-apt-repository -y ppa:apt-fast/stable
apt-get install -y apt-fast
apt-fast install -y network-manager ubuntu-drivers-common mesa-utils mesa-utils-extra intel-microcode alsa-utils lxappearance gtk-chtheme compton
systemctl start NetworkManager.service
systemctl enable NetworkManager.service
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service

#####make home directories
cd ~
mkdir Documents
mkdir Downloads
mkdir Pictures
mkdir Videos
mkdir .config
mkdir .fonts
mkdir Music

#####install i3-gaps source & devlibs, then compile
apt-fast install -y git libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxcb-xrm-dev libxkbcommon-x11-dev autoconf xutils-dev libtool libxcb-shape0-dev
cd ~ && mkdir Git
cd Git
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install

#####Install i3 peripherals
apt-fast install -y suckless-tools i3status i3blocks i3lock
add-apt-repository -y ppa:kgilmer/speed-ricer
apt-fast install -y polybar

#####install lightdm, gtk-greeter & mini-greeter
apt-fast install -y lightdm libgtk-3-dev automake pkg-config liblightdm-gobject-1-dev lightdm-gtk-greeter lightdm-gtk-greeter-settings 
cd ~/Git
git clone https://github.com/prikhi/lightdm-mini-greeter
cd lightdm-mini-greeter
./autogen.sh
./configure --datadir /usr/share --bindir /usr/bin --sysconfdir /etc
make
sudo make install

#####Install X utilities
apt-fast install -y xinit xorg xserver-xorg xterm tmux

###### Get and install San Francisco Font
#cd ~/Git 
#git clone https://github.com/supermarin/YosemiteSanFranciscoFont.git
#cp -v YosemiteSanFranciscoFont/*.ttf ~/.fonts
#rm -rf YosemiteSanFranciscoFont

###### Get and install Font Awesome Web Font
#cd ~/Git
#git clone https://github.com/FortAwesome/Font-Awesome.git
#cp -v Font-Awesome/fonts/*.ttf ~/.fonts
#rm -rf Font-Awesome

###### Get and install Moka icon theme
#add-apt-repository ppa:moka/daily -y
#apt-fast update
#apt-fast install -y moka-icon-theme

#####Install Numix stuff
#apt-fast install -y numix-icon-theme numix-icon-theme-square numix-icon-theme-circle numix-gtk-theme
#cd ~/Git
#git clone https://github.com/numixproject/numix-folders
#wget https://github.com/numixproject/numix-cursor-theme/releases/download/v1.1/numix-cursor-1.1.tar
#tar -xf numix-cursor-1.1.tar
#cp Numix-Cursor /usr/share/icons
#cp Numix-Cursor-Light /usr/share/icons

#####Clean up and remove unneeded libs/utils
#apt-fast remove -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxcb-xrm-dev libxkbcommon-x11-dev autoconf xutils-dev libtool libxcb-shape0-dev libgtk-3-dev automake pkg-config liblightdm-gobject-1-dev
#apt-fast clean
#apt-fast autoclean
#apt-fast autoremove
#cd ~ && rm -rf Git
