# PARBS 
echo "===== PARBoids RISE UP ====="

SSID=""			# Leave empty if ethernet
LAPTOP=false		# Power Efficiency Services

# =======================================================
#
# OS INSTALL INSTRUCTIONS
# RUN MANUALLY FROM INSTALL MEDIUM
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
# sudo pacman -Syu archinstall
# archinstall
# mount /mnt /dev/nvme0n1p2
# arch-chroot /mnt
# pacman -Syu networkmanager
# reboot
#
# =======================================================

# Connect to the internet.
if [ -n "$SSID" ]; then
	echo "===== Connecting to network $SSID ====="
	sudo systemctl enable NetworkManager
	sudo systemctl start NetworkManager
	nmcli radio wifi
	nmcli dev wifi list
	nmcli dev wifi connect $SSID --ask
fi

# install AUR manager
echo "===== Installing yay ====="
cd
if [ -d "~/yay" ]; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd
fi

# install packages
echo "===== Installing Packages ====="
if sudo pacman -S --needed --noconfirm acpi base base-devel blueman bluez bluez-utils brave-bin btop code discord dmenu downgrade gedit git gnu-free-fonts grub gst-plugin-pipewire htop hugo i3-wm i3blocks i3lock i3status imagemagick intel-media-driver intel-ucode iwd jq js-beautify kitty libpulse libreoffice-fresh libva-intel-driver lightdm linux linux-firmware ly man-db nautilus networkmanager noto-fonts numlockx obs-studio openssh pa-applet-git pinta pipewire pipewire-alsa pipewire-jack pipewire-pulse polybar powertop python-keyboard python-pandas python-pip python-pyautogui python-pyqt5 python-scikit-learn ranger rofi rxvt-unicode scrot terminus-font tidy tlp tlp-rdw tmux tree ttf-dejavu ttf-droid ttf-liberation ttf-roboto ttf-ubuntu-font-family unzip vim vlc vulkan-intel vulkan-radeon wireplumber xclip xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xf86-video-vmware xorg-bdftopcf xorg-iceauth xorg-mkfontscale xorg-server xorg-sessreg xorg-smproxy xorg-x11perf xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinit xorg-xinput xorg-xkbevd xorg-xkbprint xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xpr xorg-xrandr xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwd xorg-xwininfo xorg-xwud yay yay-debug zram-generator ; then
	echo "===== Successfully Installed Packages ====="
else
	echo "===== Package Install Failure ====="
	exit
fi


echo "N" | yay -S pa-applet-git
echo "N" | yay -S brave-bin

# Enable Services
echo "===== Enabling Services ====="
sudo systemctl enable bluetooth
sudo systemctl enable fstrim.timer
sudo systemctl enable ly.service

# Power Efficiency Settings
if [ "$LAPTOP" = true ] ; then
	echo "===== Setting up power efficiency services ====="
	sudo systemctl enable tlp
	sudo systemctl enable tlp-sleep
	sudo systemctl mask systemd-rfkill.service
	sudo systemctl mask systemd-rfkill.socket
fi
#
# Get dots!
echo "===== Loading dots ====="
cd ~/setup
cp dots/linux-bashrc ~/.bashrc
cp dots/linux-tmux.conf ~/.tmux.conf
mkdir ~/.config
mkdir ~/.config/i3
cp dots/main/i3-config ~/.config/i3/config


echo "===== PARBS OUT! ====="
reboot
