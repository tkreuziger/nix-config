# nixGL for kitty
if command -v nixGLIntel &> /dev/null; then
    alias kitty='nixGLIntel kitty'
fi

# Listing
if command -v eza &> /dev/null; then
    alias lls='ls'
    alias ls='eza -a --icons=auto --group-directories-first'
    alias ll='eza -lag --icons=auto --group-directories-first --time-style=long-iso'
    alias lt='eza -a --tree --level=2'
fi

# Bat
if command -v bat &> /dev/null; then
    alias ccat='cat'
    alias cat='bat --paging=never'
    alias ccat='command cat'

    export BAT_THEME="TwoDark"
    export BAT_STYLE="numbers,changes,header"
fi

# Grep
if command -v rg &> /dev/null; then
    fuzzygrep() {
        local query="$1"
        [[ -z "$query" ]] && read -rp "Query: " query

        local result
        result=$(rg --line-number --no-heading --color=always "$query" \
            | fzf --ansi --delimiter : \
                --preview 'bat_preview {1} {2}' \
                --preview-window=right:70% \
                --bind 'enter:accept')

        if [[ -n "$result" ]]; then
            local file
            local line
            file=$(echo "$result" | cut -d: -f1)
            line=$(echo "$result" | cut -d: -f2)
            nvim +"$line" "$file"
        fi
    }

    alias ffg='fuzzygrep'
fi

# Tmux
if command -v tmux &> /dev/null; then
    alias tm='tmux'
    alias tml='tmux ls'
    alias tma='tmux attach -t'
    alias tmn='tmux new -s'
    alias tmh='tmux_helper'
fi

# Emacs
alias emx="emacsclient -c > /dev/null 2>&1 & disown"
alias emx-capture="emacsclient -ne '(tris-capture)' > /dev/null 2>&1 & disown"
alias emx-status="systemctl status --user emacs"
alias emx-start="systemctl start --user emacs"
alias emx-restart="systemctl restart --user emacs"
alias emx-stop="systemctl stop --user emacs"

alias orgcal="/home/tristan/org/0\ Meta/03\ Sync/orgcal"

# Enable completion for aliases
complete -o default -o nospace -F _git g
