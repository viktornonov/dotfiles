alias gr="grep -rn"
# Rails
alias rdmt="rake db:migrate; rake db:migrate RAILS_ENV=test"
alias rdm="rake db:migrate"
alias rdbrt="rake db:rollback; rake db:rollback RAILS_ENV=test"
alias rdbr="rake db:rollback"
alias last-mig="vim ./db/migrate/\$(ls db/migrate | tail -n 1)"

alias gdc="git diff --cached"

alias zshrc="vim ~/.zshrc"
alias show-todos="grep -rn --exclude='.\*' --exclude-dir=tmp --exclude-dir=.git --exclude-dir=.bundle 'TODO\[VN\]' ."
alias new-todos="git diff master | grep -n 'TODO\[VN\]' | grep -v '^-'"
alias largest-dirs="du -s ./* | sort -rn | head"
alias et="emacsclient -t"
