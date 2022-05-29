if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ip='ip -color'
alias ll='ls -l'
alias l='ll -a'
alias ls='exa --icons --group-directories-first'
alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker'

starship init fish | source
