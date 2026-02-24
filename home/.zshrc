# history persistence
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

##
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
	export EDITOR='nvim'
fi

# load zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME/.git" ] && mkdir -p "${ZINIT_HOME:h}" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit
compinit

# nvm (lazy-load via OMZ nvm plugin)
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY=1
# export NVM_COMPLETION=true
zinit ice wait"1" lucid
zinit snippet OMZP::nvm
# plugins (zinit installs automatically when missing)
zinit snippet OMZP::command-not-found/command-not-found.plugin.zsh
zinit snippet OMZP::colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZP::git/git.plugin.zsh
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

#alias
alias ll="ls -al"
alias rm="rm -i"
alias vim="nvim"
alias type="type -a"
bindkey -v

# ------------------------------
# Starship vi-mode state bridge
# ------------------------------
# Keep a lightweight mode flag so Starship can
# render current zle mode (I/N/V/R) via env_var module.
autoload -Uz add-zle-hook-widget
_update_starship_vi_mode() {
  local mode="INSERT"

  if (( REGION_ACTIVE )); then
    mode="VISUAL"
  elif [[ "$KEYMAP" == "vicmd" ]]; then
    mode="NORMAL"
  elif [[ "$ZLE_STATE" == *overwrite* ]]; then
    mode="REPLACE"
  fi

  export STARSHIP_VI_MODE="$mode"
  if zle >/dev/null 2>&1; then
    zle reset-prompt
  fi
}

add-zle-hook-widget keymap-select _update_starship_vi_mode
add-zle-hook-widget line-init _update_starship_vi_mode
add-zle-hook-widget line-pre-redraw _update_starship_vi_mode
_update_starship_vi_mode

# ------------------------------

if [[ -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
  exec niri
  #exec sway
fi

export IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export CLUTTER_IM_MODULE=fcitx


typeset -U path

# Lazy-load conda to speed up shell startup.
export CONDA_EXE="/opt/miniconda/bin/conda"
_lazy_conda_init() {
    unset -f conda _lazy_conda_init
    local __conda_setup
    __conda_setup="$($CONDA_EXE shell.zsh hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "/opt/miniconda/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda/bin:$PATH"
    fi
    unset __conda_setup
    conda "$@"
}
conda() {
    _lazy_conda_init "$@"
}

#y function of yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# opencode
export PATH=$HOME/.opencode/bin:$PATH

eval "$(starship init zsh)"
