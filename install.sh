#!/bin/bash
#####setup script for laptop i3

#####basic setups--drivers, sound, etc. 
apt-get install -y software-properties-common
add-apt-repository -y ppa:apt-fast/stable
apt-get install -y apt-fast
apt-fast install -y network-manager tmux xterm suckless-tools udisks2 ubuntu-drivers-common mesa-utils mesa-utils-extra intel-microcode alsa-utils lxappearance gtk-chtheme compton
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
mkdir .fonts
mkdir Music

#####copy wallpaper to Pictures dir
cd ~/Git/dotfiles
cp wallpaper.jpg ~/Pictures

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
add-apt-repository -y ppa:kgilmer/speed-ricer
apt-fast -y install polybar

#####install lightdm, gtk-greeter & mini-greeter
apt-fast install -y lightdm libgtk-3-dev automake pkg-config liblightdm-gobject-1-dev lightdm-gtk-greeter lightdm-gtk-greeter-settings 
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
cp ubuntu.desktop /usr/share/xsessions
cp .tmux.conf ~
cp .dmrc ~
cp .xinitrc ~

#####install X utilities
apt-fast install -y xinit xorg xserver-xorg xserver-xorg-input-synaptics

#####install background
apt-fast install nitrogen
nitrogen --set-auto ~/Pictures/wallpaper.jpg

#####install gotop
apt-fast install golang-go
go get github.com/cjbassi/gotop
cd ~/go/src/github.com/cjbassi/gotop
go build
cp gotop /usr/bin
cd ~ && rm -rf go
apt-fast remove golang-go

#####clean up unneeded libs/utils
apt-fast clean
apt-fast autoclean
apt-fast autoremove
cd ~ && rm -rf Git

reboot
