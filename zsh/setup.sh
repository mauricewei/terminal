#!/bin/bash

# 安装 zsh
yum install zsh -y

# 安装 oh my zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "Install oh-my-zsh ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# 拷贝 zsh 环境变量和 alias 文件
cp -v alias.zsh ~/.alias
cp -v zshrc ~/.zshrc

source ~/.zshrc
