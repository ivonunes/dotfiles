#!/bin/bash

# amix vimrc
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh
cp my_configs.vim ~/.vim_runtime/

# tmux
rm -rf .tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
