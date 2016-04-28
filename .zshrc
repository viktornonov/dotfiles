# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="wedisagree"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source ~/.alias-directories.bash
alias gr="grep -rn"
alias rdmt="rake db:migrate; rake db:migrate RAILS_ENV=test"
alias rdm="rake db:migrate"
alias rdbrt="rake db:rollback; rake db:rollback RAILS_ENV=test"
alias rdbr="rake db:rollback"
alias zshrc="vim ~/.zshrc"
alias last-mig="vim ./db/migrate/\$(ls db/migrate | tail -n 1)"
alias show-todos="grep -rn --exclude='.\*' --exclude-dir=tmp --exclude-dir=.git --exclude-dir=.bundle 'TODO\[VN\]' ."
alias vim="/usr/local/Cellar/vim/7.4.903/bin/vim"
alias gdc="git diff --cached"
export BUNDLER_EDITOR=vim
TranslateWheelToCursor=on
DisableWheelToCursorByCtrl=on
ctags=/usr/local/bin/ctags

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/bin" # Add home bin
export PATH="$PATH:$HOME/Library/Python/3.5/bin" # Add python bin

#make man pages more readable
export MANWIDTH=80

# Custom command prompt
function prompt_char {
  if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}
PS1='%{$fg[green]%}[%{$fg[magenta]%}%2c%{$fg[green]%}]%{$fg[cyan]%}$(prompt_char) %{$reset_color%}'

