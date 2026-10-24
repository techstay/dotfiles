if test -d "$HOME/.local/bin"
    set -gx PATH "$HOME/.local/bin" $PATH
end
if test -d "$HOME/.cargo/bin"
    set -gx PATH "$HOME/.cargo/bin" $PATH
end

# Automatically detect desktop environment for mise environment layering
if not set -q MISE_ENV
    switch "$XDG_CURRENT_DESKTOP"
        case "*KDE*" "*plasma*"
            set -gx MISE_ENV "kde"
        case "*GNOME*" "*gnome*"
            set -gx MISE_ENV "gnome"
    end
end

if command -v mise >/dev/null 2>&1
    mise activate fish | source
else if test -x "$HOME/.local/bin/mise"
    "$HOME/.local/bin/mise" activate fish | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "default"
end

alias ip='ip -color'
alias ll='ls -l'
alias l='ll -a'
alias ls='eza --icons --group-directories-first'
alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker'

if command -v bat >/dev/null 2>&1
    alias cat='bat --paging=never'
end

if command -v starship >/dev/null 2>&1
    starship init fish | source
end
