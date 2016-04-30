#!/usr/bin/env bash

system=$(uname)

sudo -v

function install_osx_cmdlinetools()
{
  #cmdline tools include bunch of compilers, git, make and some other utitilies
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
          grep "\*.*Command Line" |
          head -n 1 | awk -F"*" '{print $2}' |
          sed -e 's/^ *//' |
          tr -d '\n')
  softwareupdate -i "$PROD" -v;
}

#function installCommonApps() {
#  brew cask install google-chrome
#  brew cask install dropbox
#  brew cask install iterm2
#  brew cask install slack
#  brew cask install skype
#  brew cask install spectacle
#  brew cask install awareness
#  brew cask install rescuetime
#  brew cask install evernote
#  brew cask install flux
#}

############################################################################
#                                 START                                    #
############################################################################
if [ $system = "Linux" ]; then
  echo "Linux"
  sudo apt-get install -y tmux zsh vim git tree
  #TODO[VN] finish the linux part
elif [ $system = "Darwin" ]; then
  echo "Darwin"
  #Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  xcode_installed=$(xcode-select -p)
  if [ $xcode_installed = "/Applications/Xcode.app/Contents/Developer" ]; then
    echo "XCode Cmd tools are already installed"
  else
    install_osx_cmdlinetools
  fi

  brew tap homebrew/bundle
  mkdir -p ~/github && cd ~/github && git clone https://github.com/viktornonov/dotfiles && cd ./dotfiles && brew bundle

  #RVM and Ruby install
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable --ruby

  sudo easy_install pip
  pip install mps-youtube
  pip install youtube_dl

  #powerline stuff
  pip3 install --user powerline-config
  pip3 install netifaces
  pip3 install psutils

  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  chsh -s /usr/local/bin/zsh

  cd ~/github/dotfiles && rake install

# keyboard shortcuts osx

#  read -p "This will install common apps like chrome, skype, slack etc. Are you sure? (y/n) " -n 1;
#  echo "";
#  if [[ $REPLY =~ ^[Yy]$ ]]; then
#    installCommonApps;
#  fi;

  source "~/github/dotfiles/.osx"

  #make solarized theme default in Terminal.app with plistBuddy


  #ssh-keygen -b 4096
  #cat ~/.ssh/id_rsa.pub
else
  echo "Unknown system ${system}"
  exit 1
fi

