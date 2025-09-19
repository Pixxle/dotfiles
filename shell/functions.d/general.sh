alias config-source='source ~/.config/shell/load.sh'

alias cat='bat'
alias l='eza'
alias ls='eza -la'
alias tree='erd'

alias pretty='prettier --write "**/*.{ts, tsx, js, jsx}"'

# Path: if work.sh does not exist, create it
# this is separated to ensure that i don't commit my work.sh file
gitignoredfile=~/.config/shell/functions.d/gitignored.sh
if [ ! -f $gitignoredfile ]; then
  echo "No hidden shell file found, creating one"
  touch $gitignoredfile
fi

eval "$(zoxide init zsh)"

ZSH_THEME="robbyrussell"

# use vi key bindings
bindkey -v
# avoid the annoying backspace/delete issue
# where backspace stops deleting characters
bindkey -v '^?' backward-delete-char
