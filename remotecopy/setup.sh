#!/bin/bash

# 拷贝remoteserver小程序到指定目录
cp -v ./remotecopy /usr/local/bin
cp -v ./remotecopyserver /usr/local/bin

read -p "你正在安装remotecopy的server端？(y/n)?" r

# 为server端创建remotecopyserver启动脚本
if [[ $r == "y" ]];then
cat << EOF > $HOME/.startremotecopy.sh
#!/bin/bash
/usr/local/bin/remotecopyserver >/dev/null 2>&1 &
EOF
chmod +x $HOME/.startremotecopy.sh
fi
