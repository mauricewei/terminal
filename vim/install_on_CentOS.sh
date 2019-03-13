#!/bin/sh

yum install -y ctags cmake gcc-c++ python-devel ncurses-devel unzip zlib-devel automake pcre-devel xz-devel wget libXt-devel gtk2-devel ruby ruby-devel perl perl-devel perl-ExtUtils-Embed git

# 插件vim-autoformat需要，否则无法对代码执行pep8格式化
pip install autopep8

# 安装vim
pushd /tmp
git clone https://github.com/vim/vim.git
cd ./vim/src
./configure --disable-selinux \
		--enable-perlinterp=yes \
		--enable-pythoninterp=yes \
		--enable-python3interp=yes \
		--with-python3-command=/usr/local/bin/python3 \
		--with-python3-config-dir=/usr/local/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
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
export PATH=/usr/local/vim8/bin/:$PATH
popd

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
cp -rv plugin  ~/.vim/
cp -rv autoload  ~/.vim/

vim "+PluginInstall" "+x" "+x"

~/.vim/bundle/YouCompleteMe/install.sh
