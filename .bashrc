#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export HISTFILE="$HOME/.cache/bash/history"
source "$HOME/.config/bash/profile"
source "$HOME/.config/bash/logout"

