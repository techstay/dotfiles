#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

source ~/.proxy.sh
