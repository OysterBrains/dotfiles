#####Install i3 peripherals
#apt-fast install -y suckless-tools i3status i3blocks i3lock
#add-apt-repository -y ppa:kgilmer/speed-ricer
#apt-fast install -y polybar

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
