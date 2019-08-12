#!/bin/bash
set -eu

SETUPDIR=$HOME/.auto-setup

sudo apt-get install -y git vim
git clone https://github.com/llbit/snippets $SETUPDIR
cd $SETUPDIR
cp dotfiles/inputrc ~/.inputrc
cp dotfiles/gitconfig ~/.gitconfig
cp dotfiles/tmux.conf ~/.tmux.conf
cp dotfiles/vimrc ~/.vimrc

# Set up vim
if [ ! -d $HOME/.vim/pack/tpope/start ]; then
  mkdir -p ~/.vim/pack/tpope/start
  cd ~/.vim/pack/tpope/start
  git clone https://github.com/tpope/vim-vinegar.git
fi
