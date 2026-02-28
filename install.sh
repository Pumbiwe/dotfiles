sudo pacman -Syu sddm awesome git nautilus alacritty vim neovim code polkit-gnome rofi zsh fastfetch lxappearance dpkg qt6-5compat qt5 loupe scrot cmake picom firefox debugedit make fakeroot gcc i3-wm i3status feh polybar github-cli --noconfirm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="mrtazz"/' ~/.zshrc
# Install yay
mkdir ~/tmp
git clone https://aur.archlinux.org/yay.git ~/tmp/yay
(cd ~/tmp/yay && makepkg -si --noconfirm)

# Installing paru pkgs
yay -S ttf-iosevka-nerd catppuccin-cursors-mocha orchis-theme postman-bin --noconfirm

# sddm theme
sudo git clone https://github.com/kamack38/sddm-greenleaf-theme.git /usr/share/sddm/themes/greenleaf
echo "[Theme]
Current=greenleaf" | sudo tee /etc/sddm.conf

# Set wallpaper
cp -r wallpaper ~/

# Themes
cp -r config/* ~/.config

# zshrc
sudo echo "$(<config/.zshrc )" > ~/.zshrc

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

# Volume controller
sudo cp volumeControl /bin/

sudo echo "$(<config/etc.rc.lua )" > /etc/xdg/awesome/rc.lua

echo "Successfully installed dotfiles! Have a nice day!"
systemctl enable sddm
systemctl restart sddm
