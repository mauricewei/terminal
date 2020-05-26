#!/bin/bash

# 安装基础安装包
apt install -y ctags cmake  unzip automake wget ruby perl ncurses-dev libxt-dev git


# 安装 pip
apt install python-pip -y

pip install flake8

# 安装vim
pushd /tmp
git clone https://github.com/vim/vim.git
cd ./vim/src
./configure --disable-selinux \
		--enable-perlinterp=yes \
		--enable-pythoninterp=yes \
		--enable-python3interp=yes \
		--with-python3-command=/usr/lib/python3.6/ \
		--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
		--enable-rubyinterp=yes \
		--enable-cscope \
		--enable-gui=auto \
		--with-features=huge \
		--enable-multibyte \
		--enable-xim \
		--with-x \
		--with-gnome \
		--with-compiledby="Maurice Wei" \
		--prefix=/usr/local/vim8 \
		--enable-luainterp
sudo make
sudo make install
popd
# 设置 vim8 环境变量
echo 'export PATH=/usr/local/vim8/bin/:$PATH' >> /etc/profile
source /etc/profile

# 检查 ctags 是否安装
if ! ctags --list-languages | grep -qi python; then
    echo "Fail to install ctags!"
    exit 1
fi

# 检查 vundle 是否安装
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "Install vundle ..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# 安装ag
apt install silversearcher-ag -y

# 配置ag.vim插件
pushd ~/.vim/bundle
git clone https://github.com/rking/ag.vim ag
popd

cp -v vimrc ~/.vimrc
cp -rv plugin  ~/.vim/
cp -rv autoload  ~/.vim/

vim "+PluginInstall" "+x" "+x"

~/.vim/bundle/YouCompleteMe/install.sh
