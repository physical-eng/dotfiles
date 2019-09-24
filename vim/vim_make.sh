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


RUBY2_VER=2.5.3
PY2_VER=2.7.12
PY3_VER=3.7.4

PY2_MAJOR_VER=$(echo ${PY2_VER} | awk -F "[.]" '{print $1 "." $2}')
PY3_MAJOR_VER=$(echo ${PY3_VER} | awk -F "[.]" '{print $1 "." $2}')

YUM_PKGS=""
YUM_PKGS="${YUM_PKGS} gcc"
YUM_PKGS="${YUM_PKGS} zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel lua-devel gtk2-devel"
YUM_PKGS="${YUM_PKGS} gtk2-devel"
YUM_PKGS="${YUM_PKGS} libffi-devel"
YUM_PKGS="${YUM_PKGS} libgnomeui-devel"
YUM_PKGS="${YUM_PKGS} gtk+-devel gtk2-devel ncurses-devel"

echo "Version is  ${PY3_VER}"
echo "Major is  ${PY3_MAJOR_VER}"

cd /tmp

 yum install -y ${YUM_PKGS}
 
 ################################################################################
 ##Ruby
 ################################################################################
 
  repo_url=https://github.com/rbenv/rbenv.git
  dist_dir=~/.rbenv
  update_repo $repo_url $dist_dir
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile.local
  source ~/.bash_profile.local
  rbenv -v
  
  repo_url=https://github.com/rbenv/ruby-build.git
  dist_dir=$HOME/.rbenv/plugins/ruby-build
  update_repo $repo_url $dist_dir
  
  $dist_dir/install.sh
  #rbenv install -l
  rbenv install ${RUBY2_VER} --skip-existing
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile.local
  source ~/.bash_profile.local
 
 rbenv global ${RUBY2_VER}
 ruby -v
## 
## ################################################################################
## ##Pyenv
## ################################################################################
## echo "===================================="
## echo "Python"
## echo "===================================="
## export PYENV_ROOT="/home/ito.nobuo/.pyenv"
## export PATH="$PYENV_ROOT/bin:$PATH"
## 
## repo_url=https://github.com/yyuu/pyenv.git 
## dist_dir=${PYENV_ROOT}
## update_repo $repo_url $dist_dir
## 
## eval "$(pyenv init -)"
## 
## CONFIGURE_OPTS="--enable-shared" pyenv install --skip-existing ${PY2_VER}
## CONFIGURE_OPTS="--enable-shared" pyenv install --skip-existing ${PY3_VER}
## pyenv global ${PY3_VER} ${PY2_VER}
## pyenv rehash
## python2 --version
## python3 --version
## 
## ################################################################################
## ## LUA/ LUA-JIT
## ################################################################################
## echo "===================================="
## echo "LUA"
## echo "===================================="
## 
## 
## #repo_url=http://luajit.org/git/luajit-2.0.git
## repo_url=https://github.com/LuaJIT/LuaJIT.git
## dist_dir=/usr/local/src/luajit
## update_repo $repo_url $dist_dir
## 
## #sudo make clean
## make && make install
## 
################################################################################
##Vim 
################################################################################
echo "===================================="
echo "Vim"
echo "===================================="
repo_url=https://github.com/vim/vim.git
dist_dir=/usr/local/src/vim
update_repo $repo_url $dist_dir

make distclean

LDFLAGS="-Wl,-rpath=${PYENV_ROOT}/versions/${PY3_VER}/lib" \
./configure \
    --with-features=huge \
    --with-x=yes \
    --prefix=/usr/local  \
    --enable-gui=gnome2 \
    --enable-perlinterp \
    --enable-pythoninterp \
     --with-python-config-dir=/home/ito.nobuo/.pyenv/versions/${PY2_VER}/lib/python${PY2_MAJOR_VER}/config \
    --enable-python3interp \
     --with-python3-config-dir=/home/ito.nobuo/.pyenv/versions/${PY3_VER}/lib/python${PY3_MAJOR_VER}/config-${PY3_MAJOR_VER}m-x86_64-linux-gnu \
    --enable-rubyinterp \
    --enable-luainterp \
    --enable-fail-if-missing | grep gui
    #--with-luajit \
    #--with-luajit-prefix=/usr/local/lib \

make && make install
