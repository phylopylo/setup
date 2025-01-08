OS Setup

Boot Arch Linux Install Medium
Connect to the internet.

iwctl
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect NETWORK_SSID
station wlan0 show

sudo pacman -Syu archinstall networkmanager
archinstall
reboot

DE Setup

Connect to the internet.

sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
nmcli radio wifi
nmcli dev wifi list
nmcli dev wifi connect NETWORK_SSID --ask

sudo pacman -S –needed git base-devel bluez bluez-utils blueman xorg-server xorg-apps xorg-xinit i3-gaps i3blocks i3lock numlockx noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-roboto terminus-font rxvt-unicode ranger rofi dmenu kitty tlp tlp-rdw powertop acpi 
install AUR manager

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

Setup

yay -S pa-applet-git
sudo systemctl enable bluetooth
sudo systemctl enable tlp
sudo systemctl enable tlp-sleep
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo systemctl enable fstrim.timer

sudo systemctl enable lightdm







