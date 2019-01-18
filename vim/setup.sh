#!/bin/sh
cp -v vimrc ~/.vimrc
cp -rv plugin  ~/.vim/
cp -rv autoload  ~/.vim/
vim "+PluginInstall" "+x" "+x"
