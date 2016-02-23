#!/bin/sh
# setup/bootstrap.sh -- Bootstraps vim setup

# This file will automatically perform the steps required to setup vim
# and will also serve as documentation of the setup process.

echo "Clone vundle from git repo..."
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

echo "Install vundle plugins"
vim +PluginInstall +qall

echo "Setup helptags for ctrlp"
vim -c "helptags $HOME/.vim/bundle/ctrlp.vim/doc" -qall

