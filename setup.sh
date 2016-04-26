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
  echo >&2 "No package manager found. Exiting."
  exit 1;
fi

# Basic utilities

## git

if ! command -v git >/dev/null 2>&1; then
  pkg_install git;
fi

cp .gitconfig ~/

## vim

if ! command -v vim >/dev/null 2>&1; then
  pkg_install vim;
fi

cp .vimrc ~/

### vim scripts

mkdir -p ~/.vim/autoload ~/.vim/bundle
cp scripts.vim ~/.vim/

curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone --no-hardlinks ./vim-racket ~/.vim/bundle/
git clone --no-hardlinks ./pollen.vim ~/.vim/bundle/

## tmux

if ! command -v tmux >/dev/null 2>&1; then
  pkg_install tmux
fi

cp .tmux.conf ~/

## gist

if ! command -v gem >/dev/null 2>&1; then
  pkg_install gem
fi

sudo gem install gist
gist --login

# GCC latest
releases=$(mktemp)
gcc=$(grep -o 'gcc-[0-9]\.[0-9]\.[0-9]' $releases | tail -n 1)
rm $releases

echo "Latest version of GCC is $gcc; install?"
select yn in "y" "n"; do
  case $yn in
    Yes )
      pwd=$(pwd)
      mkdir -p /usr/local/ar
      cd /usr/local/ar
      wget ${gcc}.tar.gz
      tar -xf ${gcc}.tar.gz -C ../src/
      cd ../src/${gcc}/
      ./contrib/download_prerequisites
      cd ..
      mkdir build
      cd build
      ../${gcc}/configure --enable-languages=c,c++ --program-suffix=$(echo $gcc | tail -c +5) \
                          --enable-shared --enable-threads=posix --enable-libstdcxx-debug \
                          --enable-plugin --disable-werror --disable-multilib
      make
      sudo make install
      break;;
    No )
      break;;
  esac
done
