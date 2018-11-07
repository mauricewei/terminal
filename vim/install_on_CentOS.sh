#!/bin/sh

yum install -y ctags cmake gcc-c++ python-devel ncurses-devel unzip zlib-devel automake pcre-devel xz-devel wget

# 安装Vim8
pushd /tmp
wget https://github.com/vim/vim/archive/master.zip
unzip master.zip
cd ./vim-master/src
./configure --with-features=huge -enable-pythoninterp --with-python-config-dir=/usr/lib64/python2.7/config/
sudo make
sudo make install
export PATH=/usr/local/bin:$PATH
popd
rm -rf /tmp/master.zip /tmp/vim-master

if ! ctags --list-languages | grep -qi python; then
    echo "Fail to install ctags!"
    exit 1
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "Install vundle ..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# 安装ag
pushd /tmp
wget https://github.com/ggreer/the_silver_searcher/archive/master.zip
mv master.zip ag.zip
unzip ag.zip
cd the_silver_searcher-master/
./build.sh --with-png --without-zlib
make install
popd
rm -rf /tmp/ag.zip /tmp/the_silver_searcher-master/ 

# 配置ag.vim插件
pushd ~/.vim/bundle
git clone https://github.com/rking/ag.vim ag
popd

cp -v vimrc ~/.vimrc
mkdir ~/.vim/colors
cp -v solarized.vim  ~/.vim/colors

vim "+PluginInstall" "+x" "+x"

~/.vim/bundle/YouCompleteMe/install.sh
