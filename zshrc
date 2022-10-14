export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR='emacs'
export FZF_DEFAULT_COMMAND='find .'
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
PROMPT="%F{blue}[%n@%m %~]%f$ "

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    startx
fi

# ls after cd
function chpwd() {
    exa -l
}


# plugins
[[ -f ~/src/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/src/zsh-snap

source ~/src/zsh-snap/znap.zsh  # Start Znap

# znap source marlonrichert/zsh-autocomplete
znap source Aloxaf/fzf-tab \
# znap source zsh-users/zsh-autosuggestions
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=2"
znap source zdharma/fast-syntax-highlighting

# Setopt needs to go after znap or it doesn't work
setopt share_history autocd nomatch
unsetopt beep          # Dont beep on error

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return # needed for tramp

# Play nice with vterm
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# aliases
alias pcsleep="systemctl suspend"
alias config='/usr/bin/git --git-dir=/home/karl/dotfiles --work-tree=/home/karl'
alias volume="alsamixer -c HD"

alias pin="paru -S"
alias prm="paru -Rs"
alias pss="paru -Ss"


alias make-dwm="cd ~/src/dwm && make && sudo make install && cd"
alias make-st="cd ~/src/st && make && sudo make install && cd"
alias copy="xclip -selection clipboard"
alias nogui="Xvfb :99 & DISPLAY=:99"
alias pag="ps aux | grep"
alias v="nvim"
alias e="emacsclient -c"
alias te="emacs -nw"
alias rmrf="rm -rf"
alias sudo="sudo -E"
alias chx="chmod +x"
alias ls="exa -l"
alias screenshot="maim ~/Screenshots/$(date +%s).png"
alias windows="\"sudo\" grub-reboot 1 && systemctl reboot"

alias hlmatch="grep --color=always -e "^" -e"

alias rm="gio trash"

alias gcl="git clone"
alias gcm="git commit -m"
alias gaa="git add -A"

alias sp="splash"
alias amx="alsamixer -c 1"
