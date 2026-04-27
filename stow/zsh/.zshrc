export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="steeef"

plugins=(git sudo)

source $ZSH/oh-my-zsh.sh

alias ssh='TERM=xterm-256color ssh'
alias edit='emacsclient -t'
alias cat='bat'

export EDITOR='emacsclient -t'
export PATH=~/.npm-global/bin:$PATH
