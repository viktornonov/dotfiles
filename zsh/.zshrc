# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="wedisagree"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR='vim'
export BUNDLER_EDITOR=$EDITOR
export PSQL_EDITOR=$EDITOR

TranslateWheelToCursor=on
DisableWheelToCursorByCtrl=on
ctags=/usr/local/bin/ctags

export PATH="/usr/local/bin:$PATH:$HOME/.rvm/bin:$HOME/bin"

#make man pages more readable
export MANWIDTH=80

# Custom command prompt
function prompt_char {
  if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}
PS1='%{$fg[green]%}[%{$fg[magenta]%}%2c%{$fg[green]%}]%{$fg[cyan]%}$(prompt_char) %{$reset_color%}'

# export POWERLINE_LOC="/Users/viktor/Library/Python/3.5/lib/python/site-packages"
# export PATH="$PATH:$POWERLINE_LOC/../../../bin/"

#FZF related config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Overriden function of fzf, which allows to select a command with Tab when you
# filter historical commands, and also directly execute it with Enter.
# Slightly modified version of https://github.com/junegunn/fzf/issues/477#issuecomment-631707533
custom-fzf-history-widget () {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=($(fc -rl 1 |
FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort --expect=tab $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)))
  local ret=$?
  if [ -n "$selected" ]
  then
    local only_select=0
    if [[ $selected[1] == tab ]]
    then
      only_select=1
      shift selected
    fi
    num=$selected[1]
    if [ -n "$num" ]
    then
      zle vi-fetch-history -n $num
      [[ $only_select == 0 ]] && zle accept-line
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N   custom-fzf-history-widget
bindkey "^R" custom-fzf-history-widget

# Key bindings
bindkey "^H" backward-word
bindkey "^J" forward-word

# History customization
SAVEHIST=100000
HISTSIZE=100000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

export HOMEBREW_NO_AUTO_UPDATE=1

# Python environment managing with Direnv (Works similarly to rvm's .ruby-version .ruby-gemset)
# the follwoing is result of eval $(direnv hook zsh)
_direnv_hook() {
  trap -- '' SIGINT;
  eval "$("/usr/local/bin/direnv" export zsh)";
  trap - SIGINT;
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions=( _direnv_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z ${chpwd_functions[(r)_direnv_hook]} ]]; then
  chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
fi
