#!/bin/sh

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
cp .zshrc ~/.zshrc

# basics
brew install pearcleaner the-unarchiver logi-options-plus netnewswire replacicon --cask

# dev tools
brew install rbenv lazyvim lazygit ripgrep opencode tmux
brew install ghostty font-jetbrains-mono-nerd-font --cask

# lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
cp nvim.lua ~/.config/nvim/lua/config/options.lua

# opencode
mkdir -p ~/.config/opencode
cp opencode.json ~/.config/opencode/

# tmux
mkdir -p ~/.config/tmux
cp tmux.conf ~/.config/tmux/
cp tmux.conf.local ~/.config/tmux/

# ghostty
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
cp ghostty.conf ~/Library/Application\ Support/com.mitchellh.ghostty/config

# games
brew install nvidia-geforce-now --cask

# music production
brew install izotope-product-portal native-access ilok-license-manager --cask
