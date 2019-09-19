#!/bin/bash
#####setup script for laptop i3

#####basic setups--drivers, sound, etc. 
apt-get install -y software-properties-common
add-apt-repository -y ppa:apt-fast/stable
apt-get install -y apt-fast
apt-fast install -y network-manager feh tmux p7zip-full xterm suckless-tools udisks2 ubuntu-drivers-common mesa-utils mesa-utils-extra intel-microcode alsa-base lxappearance compton
systemctl start NetworkManager.service
systemctl enable NetworkManager.service
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service

#####copy wallpaper to home dir
cd ~/Git/dotfiles
cp wallpaper.jpg ~

#####copy cursor theme to .icons
mkdir ~/.icons
cp Bibata_Cursor_Pack.zip ~/.icons/
7z x ~/.icons/Bibata_Cursor_Pack.zip
rm -r ~/.icons/Bibata_Cursor_Pack.zip

#####install i3-gaps source & devlibs, then compile
apt-fast install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev
cd Git
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

#####install i3 peripherals
apt-fast -y install i3status 

#####install lightdm & mini-greeter
apt-fast install -y lightdm libgtk-3-dev automake pkg-config liblightdm-gobject-1-dev 
cd ~/Git
git clone https://github.com/josephsurin/lightdm-mini-greeter
cd lightdm-mini-greeter
./autogen.sh
./configure --datadir /usr/share --bindir /usr/bin --sysconfdir /etc
make
sudo make install

#####copy .conf files to correct locations
cd ~/Git/dotfiles
cp lightdm.conf /etc/lightdm
cp lightdm-mini-greeter.conf /etc/lightdm
cp .tmux.conf ~
cp .dmrc ~
cp .xinitrc ~
cp compton.conf ~/.config/
cp config ~/.config/i3/

#####install X utilities
apt-fast install -y xinit xorg xserver-xorg xserver-xorg-input-synaptics

#####install gotop
apt-fast install -y golang-go
go get github.com/cjbassi/gotop
cd ~/go/src/github.com/cjbassi/gotop
go build
cp gotop /usr/bin
cd ~ && rm -rf go
apt-fast remove -y golang-go

#####clean up unneeded libs/utils
apt-fast -y clean
apt-fast -y autoclean
apt-fast -y autoremove
cd ~ && rm -rf Git

reboot
