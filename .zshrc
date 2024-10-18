# Created by newuser for 5.8.1

unsetopt BEEP
unsetopt LIST_BEEP
set -o emacs
set -o AUTO_CD

export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T]"

setopt EXTENDED_HISTORY

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

autoload -Uz compinit && compinit

zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey -M menuselect '^[[Z' reverse-menu-complete

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

alias l='eza --icons --grid --group-directories-first';
alias ll='eza -l --icons --group-directories-first';
alias la='eza -a --icons --group-directories-first';
alias lla='eza -la --icons --group-directories-first';


source "$HOME/.cargo/env"


export DISPLAY="$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0"

# eval "$(starship init bash)"
eval "$(oh-my-posh init zsh --config $HOME/.config/omp/config.toml)"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
export HOST_IP="$(ip route | awk '/^default/{print $3}')"
export PULSE_SERVER="tcp:$HOST_IP"
#export DISPLAY="$HOST_IP:0.0"
export EDITOR=nvim


export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"
export LUA_INCDIR=/usr/include/lua5.1/

function searchify() {
	echo "$1"
	data=$(rg -l -e "$1" -- /mnt/c/Users/timob/Downloads/spotify)
	if [[ -z "$data" ]]; then
		echo "no matches"
		return
	fi
	echo "$data" | xargs cat | xsv select '"Track Name","Artist Name(s)","Album Name"' | xsv search -i "$1" | xsv table -c 30
}

# make fzf use `fd` and respect .gitignore
export FZF_DEFAULT_COMMAND="fd --type file --hidden"
export FZF_CTRL_T_COMMAND="fd --hidden"
# export FZF_ALT_C_COMMAND="fd -td --hidden"

_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

source $HOME/.config/broot/launcher/bash/br

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function mkcdir() {
	mkdir "$1" && cd "$1"
}

# Idris2
alias idris2='rlwrap ~/.idris2/bin/idris2'

# Turso

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm


# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


function cpdf() {
    "$HOME/.cpdf/cpdf" "$@" |& tail -n +3
}

alias flix='java -jar "$HOME/.flix/flix.jar"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function kill-path-word() {
    zle set-mark-command
    while [[ $CURSOR -gt 0 && $LBUFFER[-1] != "/"  ]] {
        if [[ $LBUFFER[-1] == " " ]]; then
            zle exchange-point-and-mark
            (( REGION_ACTIVE = 0 ))
            return
        fi
        (( CURSOR -= 1 ))
    }
    (( CURSOR -= 1 ))
    zle exchange-point-and-mark
    zle kill-region
}

zle -N kill-path-word
bindkey "^[m" kill-path-word


# path
export PATH="$PATH:/usr/local/flutter/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.turso"
export PATH="$PATH:$HOME/.roswell/bin/"
export PATH="$PATH:/usr/local/swift/usr/bin"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export PATH="$PATH:$HOME/.gleam/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.zig/bin"
