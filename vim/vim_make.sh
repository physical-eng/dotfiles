#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

set -eu

update_repo () {
    local repo_url=$1
    local dist_dir=$2

    if [ ! -d $dist_dir ]; then
        git clone ${repo_url} ${dist_dir}
        cd ${dist_dir}
    else
        cd ${dist_dir}
        git pull
    fi
}

##Pyenv
# pyenv
export PYENV_ROOT="/home/ito.nobuo/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

repo_url=https://github.com/yyuu/pyenv.git 
dist_dir=${PYENV_ROOT}
update_repo $repo_url $dist_dir

eval "$(pyenv init -)"

#CONFIGURE_OPTS="--enable-shared" pyenv install 2.7.12
#CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.1
pyenv global 3.6.1 2.7.12
pyenv rehash
python2 --version
python3 --version

# LUA/ LUA-JIT
yum install -y gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel lua-devel git 

#repo_url=http://luajit.org/git/luajit-2.0.git
repo_url=https://github.com/LuaJIT/LuaJIT.git
dist_dir=/usr/local/src/luajit
update_repo $repo_url $dist_dir

#sudo make clean
make && make install

#Vim 
repo_url=https://github.com/vim/vim.git
dist_dir=/usr/local/src/vim

update_repo $repo_url $dist_dir

make distclean

LDFLAGS="-Wl,-rpath=${PYENV_ROOT}/versions/3.6.1/lib" \
./configure \
    --with-features=huge \
    --prefix=/usr/local  \
    --enable-gui=gnome2 \
    --enable-perlinterp \
    --enable-pythoninterp \
     --with-python-config-dir=/home/ito.nobuo/.pyenv/versions/2.7.12/lib/python2.7/config \
    --enable-python3interp \
     --with-python3-config-dir=/home/ito.nobuo/.pyenv/versions/3.6.1/lib/python3.6/config-3.6m-x86_64-linux-gnu \
    --enable-rubyinterp \
    --enable-luainterp \
    --enable-fail-if-missing 
    #--with-luajit \
    #--with-luajit-prefix=/usr/local/lib \

make && make install
