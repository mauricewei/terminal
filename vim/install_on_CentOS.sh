#!/bin/sh

yum install -y ctags cmake gcc-c++ python-devel ncurses-devel unzip

wget https://github.com/vim/vim/archive/master.zip
unzip master.zip

pushd ./vim-master/src
./configure --with-features=huge -enable-pythoninterp --with-python-config-dir=/usr/lib64/python2.7/config/
sudo make
sudo make install
export PATH=/usr/local/bin:$PATH
popd

rm -rf master.zip ./vim-master

if ! ctags --list-languages | grep -qi python; then
    echo "Fail to install ctags!"
    exit 1
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "Install vundle ..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

cp -v vimrc ~/.vimrc
mkdir ~/.vim/colors
cp -v solarized.vim  ~/.vim/colors
vim "+PluginInstall" "+x" "+x"

~/.vim/bundle/YouCompleteMe/install.sh
