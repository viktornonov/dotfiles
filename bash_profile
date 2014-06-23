#bashrc

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

complete -cf sudo

source ~/.git-completion.bash

export PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '
export CLICOLOR=1

