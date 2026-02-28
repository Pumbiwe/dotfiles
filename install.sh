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

if [ -d "$HOME/tmp/dotfiles" ]; then
  echo -n "The ~/tmp/dotfiles directory already exists. Do you want to delete it? [y/n]: "
  read answer
  if [[ 'n' != $answer && 'N' != $answer ]]; then
    echo "Removing ~/tmp/dotfiles/ directory."
    rm -rf ~/tmp/dotfiles
  fi
fi

git clone https://github.com/Pumbiwe/dotfiles
cd dotfiles
echo "Success."

packages=(sddm 
  awesome 
  git 
  nautilus 
  alacritty 
  vim 
  neovim
  code
  polkit-gnome
  rofi
  zsh
  fastfetch
  lxappearance
  dpkg
  qt6-5compat
  qt5
  loupe
  scrot
  cmake
  firefox
  debugedit
  make
  fakeroot
  gcc
  i3-wm
  i3status
  feh
  polybar
  github-cli)

echo "List of packages: "
n=1
for var in "${packages[@]}"; do
  echo "$n) $var"
  n=$((n + 1))
done
echo -n "Do you want to install these packages? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok, bye!"
  exit 0
fi
sudo pacman -Syu
for var in "${packages[@]}"; do
  sudo pacman -S $var --noconfirm
  if [[ $? == 1 ]]; then
    echo -e "\033[0;31m[ERROR] Package \033[0;34m$var\033[0;31m did not installed.\033[0;37m"
    read -p "Press [Enter] to continue..."
  fi
done


echo -n "Do you want to install zsh? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
else
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo echo "$(<.zshrc)" >~/.zshrc
fi


echo -n "Do you want to install yay? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
  exit 0
else
# Install yay
git clone https://aur.archlinux.org/yay.git ~/tmp/yay
(cd ~/tmp/yay && makepkg -si --noconfirm)
fi

packages=(ttf-iosevka-nerd 
  catppuccin-cursors-mocha
  orchis-theme
  postman-bin
  sddm-theme-noctalia-git)

echo "List of packages: "
n=1
for var in "${packages[@]}"; do
  echo "$n) $var"
  n=$((n + 1))
done
echo -n "Do you want to install these packages? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok, bye!"
  exit 0
fi
for var in "${packages[@]}"; do
  yay -S $var --noconfirm
  if [[ $? == 1 ]]; then
    echo -e "\033[0;31m[ERROR] Package \033[0;34m$var\033[0;31m did not installed.\033[0;37m"
    read -p "Press [Enter] to continue..."
  fi
done


echo -n "Do you want to install noctalia sddm theme? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
else
# sddm theme
echo "[Theme]
Current=noctalia" | sudo tee /etc/sddm.conf
fi

# Set wallpaper
cp -r wallpaper ~/

# Themes
cp -r config/* ~/.config

echo -n "Do you want to install firefox theme? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
else
# Firefox theme
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/user.js -o ~/.mozilla/firefox/user.js
mkdir -p ~/.mozilla/firefox/chrome
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/add.svg -o ~/.mozilla/firefox/chrome/add.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/left-arrow.svg -o ~/.mozilla/firefox/chrome/left-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/right-arrow.svg -o ~/.mozilla/firefox/chrome/right-arrow.svg
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userChrome.css -o ~/.mozilla/firefox/chrome/userChrome.css
curl https://raw.githubusercontent.com/gh0stzk/dotfiles/master/misc/firefox/chrome/userContent.css -o ~/.mozilla/firefox/chrome/userContent.css
fi

echo -n "Do you want to install rofi theme? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
else
# Rofi theme
mkdir -p ~/.local/share/rofi/themes
cp rofi/spotlight-dark.rasi ~/.local/share/rofi/themes/
fi

echo -n "Do you want to install LazyVim? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
else
# LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim
fi


echo -n "Do you want to enable and restart sddm? [y/n]: "
read answer
if [[ 'n' == $answer || 'N' == $answer ]]; then
  echo "Ok."
else
systemctl enable sddm
systemctl restart sddm
fi
