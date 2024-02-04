#!/bin/bash

echo "Installing Neovim..."
echo "Update apt..."
sudo apt update

echo "Install dependencies..."
sudo apt install ninja-build gettext cmake unzip curl nodejs ripgrep bat python3 -y

#echo "Install Neovim..."
#sudo apt install neovim -y
sudo apt remove neovim neovim-runtime -y

cd ~/Downloads
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

echo "Installing nerdfonts..."
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/BitstreamVeraSansMono.zip -O BitstreamVeraSansMono.zip
mkdir BitstreamVeraSansMono
unzip BitstreamVeraSansMono.zip -d BitstreamVeraSansMono
sudo mv BitstreamVeraSansMono /usr/share/fonts/
rm BitstreamVeraSansMono.zip

echo "Installing lazygit"

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

echo "Installing bottom"
# x86-64
BOTTOM_VERSION=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -LO https://github.com/ClementTsang/bottom/releases/download/v${BOTTOM_VERSION}/bottom_${BOTTOM_VERSION}_amd64.deb
sudo dpkg -i bottom_${BOTTOM_VERSION}_amd64.deb

echo "Installing AstroNeovim"

mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

nvim