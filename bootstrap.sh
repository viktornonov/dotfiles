#!/usr/bin/env bash

system=$(uname)

# Ask for password
sudo -v

# Keep the sudo alive
echo " Keep-alive: update existing sudo time stamp until the script has finished"
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

function install_osx_cmdlinetools()
{
  #cmdline tools include bunch of compilers, git, make and some other utitilies
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
          grep "\*.*Command Line" |
          head -n 1 | awk -F"*" '{print $2}' |
          sed -e 's/^ *//' |
          tr -d '\n')
  if [ -z $PROD ]; then
    echo "Coulndn't find Command Line Tools in the update list"
    exit
  fi
  softwareupdate -i "$PROD" -v;
}

############################################################################
#                                 START                                    #
############################################################################
if [ $system = "Linux" ]; then
  echo "Linux"
  sudo apt-get install -y tmux zsh vim git tree
  #TODO[VN] finish the linux part
elif [ $system = "Darwin" ]; then
  echo "Darwin"

  echo "Looking for Command Line Tools"
  if [ -d "/Library/Developer/CommandLineTools" ]; then
    echo "XCode Cmd tools are already installed"
  else
    install_osx_cmdlinetools
  fi

  #Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  if [ ! -f "/usr/local/bin/brew" ]; then
    echo "brew was not installed"
    exit
  fi

  brew tap homebrew/bundle
  mkdir -p ~/github && cd ~/github && git clone https://github.com/viktornonov/dotfiles
  cd ~/github/dotfiles && brew bundle

  #enable the dark mode
  dark-mode dark

  #RVM and Ruby install
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable --ruby

  sudo easy_install pip
  sudo pip3 install --upgrade pip
  pip3 install mps-youtube
  pip3 install youtube_dl

  #powerline stuff
  pip3 install --user powerline-status
  pip3 install netifaces
  pip3 install psutil

  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  chsh -s /usr/local/bin/zsh

  cd ~/github/dotfiles && rake install

# keyboard shortcuts osx

  source "$HOME/github/dotfiles/.osx"

  #iTerm shows error when it starts

  #TODO[VN] start the apps
  # add flux and awareness plists

  #awareness
  #spectacle
  #iterm2
  #flux
  #rescuetime
else
  echo "Unknown system ${system}"
  exit 1
fi

