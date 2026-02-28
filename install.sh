os=$(cat /etc/os-release | grep -e "^NAME=*")
if [[ $os != "NAME=\"Arch Linux\"" ]]; then
  echo -n "You are not using Arch Linux. Do you want to continue? [y/n]: "
  read answer
  if [[ 'n' == $answer || 'N' == $answer ]]; then
    echo "Bye!"
    exit 0
  fi
fi

echo "Creating ~/tmp directory..."
mkdir -p ~/tmp
cd ~/tmp
git clone https://github.com/Pumbiwe/dotfiles
cd dotfiles
echo "Success."

sudo pacman -Syu sddm awesome git nautilus alacritty vim neovim code polkit-gnome rofi zsh fastfetch lxappearance dpkg qt6-5compat qt5 loupe scrot cmake firefox debugedit make fakeroot gcc i3-wm i3status feh polybar github-cli --noconfirm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install yay
git clone https://aur.archlinux.org/yay.git ~/tmp/yay
(cd ~/tmp/yay && makepkg -si --noconfirm)

# Installing paru pkgs
yay -S ttf-iosevka-nerd catppuccin-cursors-mocha orchis-theme postman-bin sddm-theme-noctalia-git --noconfirm

# sddm theme
echo "[Theme]
Current=noctalia" | sudo tee /etc/sddm.conf

# Set wallpaper
cp -r wallpaper ~/

# Themes
cp -r config/* ~/.config

# zshrc
sudo echo "$(<.zshrc)" >~/.zshrc

# Firefox theme
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/user.js -o ~/.mozilla/firefox/user.js
mkdir -p ~/.mozilla/firefox/chrome
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/add.svg -o ~/.mozilla/firefox/chrome/add.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/left-arrow.svg -o ~/.mozilla/firefox/chrome/left-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/right-arrow.svg -o ~/.mozilla/firefox/chrome/right-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userChrome.css -o ~/.mozilla/firefox/chrome/userChrome.css
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userContent.css -o ~/.mozilla/firefox/chrome/userContent.css

# Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Rofi theme
mkdir -p ~/.local/share/rofi/themes
cp rofi/spotlight-dark.rasi ~/.local/share/rofi/themes/

# LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim

echo "Successfully installed dotfiles! Have a nice day!"
systemctl enable sddm
systemctl restart sddm
