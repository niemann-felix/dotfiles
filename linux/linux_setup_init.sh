#/bin/bash

sudo apt update
sudo apt install wget git keepassxc ffmpeg firefox-esr sqlitebrowser -y

wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O vscode.deb
OBSIDIAN_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget "https://github.com/obsidianmd/obsidian-releases/releases/download/${OBSIDIAN_VERSION}/obsidian_${OBSIDIAN_VERSION}_amd64.deb" -O obsidian.deb

sudo apt install ./vscode.deb ./obsidian.deb -y

rm ./vscode.deb ./obsidian.deb

cd ~/Documents
mkdir github
mkdir newlocalnas
mkdir share

printf "TODO: Setup \n #1 firefox \n #2 git \n #3 keepassxc \n #4 vscode \n #6 Obsidian"
