#!/bin/bash

if [[ ! -d $HOME/.ssh ]]; then
    mkdir $HOME/.ssh
fi

cat << EOF > $HOME/.ssh/config
# 设置session复用，在session生命周期内，不需要重复输入密码，在使用跳板机时特别有用
Host *
    KeepAlive yes
    ServerAliveInterval 60
    ControlPersist yes
    KexAlgorithms +diffie-hellman-group1-sha1

# 设置目的端服务器连接本地计算机的转发端口
# remotecopy的client会通过此端口拷贝数据给本地计算机的server端
Host 10.211.55.*
    RemoteForward 2019 localhost:2019
EOF
