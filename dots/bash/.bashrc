# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Save history immediately after each command
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Increase history size and make it more useful
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE='ls:ll:la:cd:pwd:exit:date:history'

# Better tab completion
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

# Enable useful bash options
shopt -s autocd        # cd by typing directory name
shopt -s cdspell       # correct minor spelling errors in cd
shopt -s dirspell      # correct directory spelling errors
shopt -s globstar      # enable ** recursive globbing
shopt -s checkwinsize  # update LINES and COLUMNS after each command

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Colored GCC warnings and errors.
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable programmable completion features.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Extend PATH.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.config/emacs/bin/" ] ; then
    PATH="$HOME/.config/emacs/bin:$PATH"
fi

# fzf
if command -v fzf &> /dev/null; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash

    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_VIM_KEYS='--bind "ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up"'

    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -500' $FZF_VIM_KEYS"

    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
    export FZF_ALT_C_OPTS="--preview 'eza -l --no-user --no-permissions --icons=always --color=always {}' $FZF_VIM_KEYS"

    export FZF_CTRL_R_OPTS="--sort --reverse --preview 'echo {}' $FZF_VIM_KEYS"
    export FZF_DEFAULT_OPTS="$FZF_VIM_KEYS \
        --color=spinner:#F5E0DC,hl:#F38BA8 \
        --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
        --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
        --color=selected-bg:#45475A \
        --color=border:#313244,label:#CDD6F4"
fi

# Enable starship.
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

