#!/bin/bash

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
cp .zshrc ~/.zshrc
brew cask install caskroom/fonts/font-hack

# amix vimrc
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp my_configs.vim ~/.vim_runtime/

# tmux
brew install tmux
rm -rf .tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf

# sublime
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
cp Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/

# add Solarized Dark to the OS X Terminal
open Solarized\ Dark.terminal
