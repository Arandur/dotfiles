#!/bin/sh

# Install basic development environment

# Install with system package manager
if command -v aptitude >/dev/null 2>&1; then
  pkg_install () { sudo aptitude install $1; }
elif command -v apt-get >/dev/null 2>&1; then
  pkg_install () { sudo apt-get install $1; }
elif command -v yum >/dev/null 2>&1; then
  pkg_install () { sudo yum install $1; }
else
  echo "No package manager found. Exiting."
  exit 1;
fi

# Basic utilities

## git

echo "Installing git..."
if command -v git >/dev/null 2>&1; then
  echo "git is already installed."
else
  pkg_install git || { echo "Did not install git; aborting."; exit 1; }
  echo "Installed git."
fi

cp .gitconfig ~/

## curl

echo "Installing cURL"
if command -v curl >/dev/null 2>&1; then
  echo "Curl is already installed."
else
  pkg_install curl || { echo "Did not install cURL; aborting."; exit 1; }
  echo "Installed cURL."
fi

## tree

echo "Installing tree..."
if command -v tree >/dev/null 2>&1; then
  echo "tree is already installed."
else
  pkg_install tree || { echo "Did not install tree; aborting."; exit 1; }
  echo "Installed tree."
fi

## vim

echo "Installing vim..."
if command -v vim >/dev/null 2>&1; then
  echo "vim is already installed."
else
  pkg_install vim || { echo "Did not install vim; aborting."; exit 1; }
  echo "Installed vim."
fi

cp .vimrc ~/

### vim scripts

mkdir -p ~/.vim/autoload ~/.vim/bundle
cp scripts.vim ~/.vim/

if [ ! -e "~/.vim/autoload/pathogen.vim" ]; then
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim --insecure
fi

git submodule update --init --recursive

if [ ! -e "~/.vim/bundle/vim-racket" ]; then
  git clone -l --no-hardlinks ./vim-racket ~/.vim/bundle/vim-racket
fi

if [ ! -e "~/.vim/bundle/pollen.vim" ]; then
  git clone -l --no-hardlinks ./pollen.vim ~/.vim/bundle/pollen.vim
fi

## tmux

echo "Installing tmux..."
if command -v tmux >/dev/null 2>&1; then
  echo "tmux is already installed."
else
  pkg_install tmux || { echo "Did not install tmux; aborting."; exit 1; }
  echo "Installed tmux."
fi

cp .tmux.conf ~/

## gist

echo "Installing gist..."
if command -v gist >/dev/null 2>&1; then
  echo "gist is already installed."
else
  pkg_install ruby || { echo "Did not install gem; aborting."; exit 1; }
  sudo gem install gist
  gist --login
  echo "Installed gist."
fi

# GCC latest
wget http://www.netgull.com/gcc/releases
gcc=$(grep -o 'gcc-[0-9]\.[0-9]\.[0-9]' ./releases | tail -n 1)
rm ./releases

while true; do
  read -p "Latest version of GCC is $gcc; install? " yn
  case $yn in
    [Yy]* )
      pwd=$(pwd)
      pkg_install build-essential && \
      sudo mkdir -p /usr/local/ar && \
      sudo chown $USER /usr/local/ar && \
      sudo chown $USER /usr/local/src && \
      cd /usr/local/ar && \
      wget http://www.netgull.com/gcc/releases/${gcc}/${gcc}.tar.gz && \
      tar -xf ${gcc}.tar.gz -C ../src/ && \
      cd ../src/${gcc}/ && \
      ./contrib/download_prerequisites && \
      cd .. && \
      mkdir build && \
      cd build && \
      ../${gcc}/configure --enable-languages=c,c++ --program-suffix=$(echo $gcc | tail -c +5) \
                          --enable-shared --enable-threads=posix --enable-libstdcxx-debug \
                          --enable-plugin --disable-werror --disable-multilib && \
      make && \
      sudo make install ||
      { echo "Could not install gcc; aborting."; exit 1; }
      break;;
    [Nn]* )
      echo "Not installing $gcc"
      break;;
    * ) echo "Please answer yes or no.";;
  esac
done
