#!/bin/bash

warning() {
  printf '\e[36m'; echo "$@"; printf '\E[0m'
}

success() {
  printf '\e[32m'; echo "$@"; printf '\E[0m'
}

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}

ubuntu_python() {
warning '[ ? ] Install python 3.10? (y/n) : '
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty "$old_stty_cfg"
if echo "$answer" | grep -iq "^y" ;then
    echo "[ * ] Installing important packages..."
    sudo apt install software-properties-common curl git -y &>/dev/null 
    success "[ ✔ ] Installed!"
    echo "[ * ] Installing repo for python 3.10..."
    sudo add-apt-repository ppa:deadsnakes/ppa -y &>/dev/null
    success "[ ✔ ] Installed!"
    echo "[ ~ ] Installing python 3.10"
    sudo apt install -y python3.10 python3.10-distutils &>/dev/null && curl -s https://bootstrap.pypa.io/get-pip.py | python3.10 &>/dev/null
    success "[ ✔ ] Installed!"
else
    clear
    error '[ ! ] User Aborted python 3.10 Installation.'
    exit 1;
fi
}

ubuntu_python