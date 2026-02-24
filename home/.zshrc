
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
	export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias ll="ls -al"
alias rm="rm -i"
alias vim="nvim"
alias type="type -a"
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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
export PATH=/home/bi/.opencode/bin:$PATH

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
