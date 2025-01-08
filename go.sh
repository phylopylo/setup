# PARBS 

SSID=""			# Leave empty if ethernet
LAPTOP=false		# Power Efficiency Services

# =======================================================
#
# OS INSTALL INSTRUCTIONS
# RUN MANUALLY
#
# Boot Arch Linux Install Medium
# Connect to the internet.
#
# iwctl
# device list
# station wlan0 scan
# station wlan0 get-networks
# station wlan0 connect NETWORK_SSID
# station wlan0 show
#
# sudo pacman -Syu archinstall networkmanager
# archinstall
# reboot
#
# =======================================================

# Connect to the internet.
if [ -n "$SSID" ]; then
	sudo systemctl enable NetworkManager
	sudo systemctl start NetworkManager
	nmcli radio wifi
	nmcli dev wifi list
	nmcli dev wifi connect $SSID --ask
fi

# install AUR manager
cd
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

# install packages
sudo pacman -S --needed git base-devel bluez bluez-utils blueman xorg-server xorg-apps xorg-xinit i3-gaps i3blocks i3lock numlockx noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-roboto terminus-font rxvt-unicode ranger rofi dmenu kitty tlp tlp-rdw powertop acpi 

yay -S pa-applet-git

# Get dots!
cd
git clone https://phylopylo/dots.git
cp dots/main/linux-bashrc ~/.bashrc
cp dots/main/linux-tmux.conf ~/.tmux.conf

# Enable Services
sudo systemctl enable bluetooth
sudo systemctl enable fstrim.timer
sudo systemctl enable lightdm

# Power Efficiency Settings
if [ "$LAPTOP" = true ] ; then
	sudo systemctl enable tlp
	sudo systemctl enable tlp-sleep
	sudo systemctl mask systemd-rfkill.service
	sudo systemctl mask systemd-rfkill.socket
fi








