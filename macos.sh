#!/bin/sh

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
cp .zshrc ~/.zshrc

# amix vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp my_configs.vim ~/.vim_runtime/

# basics
brew install pearcleaner the-unarchiver logi-options-plus microblog replacicon --cask

# dev tools
brew install rbenv
brew install iterm2 rubymine font-jetbrains-mono rapidapi --cask

# games
brew install nvidia-geforce-now --cask

# music production
brew install izotope-product-portal native-access --cask
