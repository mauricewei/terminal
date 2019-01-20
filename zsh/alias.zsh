alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ag='ag --color-match "1;31"'
alias tailf='tail -f'
alias proxy='env http_proxy=http://10.211.55.2:8123 https_proxy=http://10.211.55.2:8123'
alias tm='tmux'

if ls /usr/local/vim8/bin/vim &>/dev/null; then
    export PATH=$PATH:/usr/local/vim8/bin/
fi

if which vim &>/dev/null; then
    alias vi='vim'
fi

alias j='z'
