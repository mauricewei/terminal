#!/bin/sh

brew install ctags cmake flake8

if ! ctags --list-languages | grep -qi python; then
    echo "Fail to install ctags!"
    exit 1
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "Install vundle ..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd ~/.vim/bundle/Vundle.vim;git submodule update --recursive --init;cd -
fi

cp -v vimrc ~/.vimrc
cp -rv plugin  ~/.vim/
cp -rv autoload  ~/.vim/

vim "+PluginInstall" "+x" "+x"

~/.vim/bundle/YouCompleteMe/install.sh
~/.vim/bundle/YouCompleteMe/install.sh --clang-completer --go-completer
