#!/bin/bash

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
cp .zshrc ~/.zshrc

# amix vimrc
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp my_configs.vim ~/.vim_runtime/

# sublime
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/SolarizedDark
cp *.sublime-* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
cp -r SolarizedDark ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/SolarizedDark

# xcode
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp *.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/

# add Solarized Dark to Terminal.app
open Solarized\ Dark.terminal

# notify about iTerm
echo "All done! You can also import the iTerm.json file if using iTerm."
