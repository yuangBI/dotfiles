# Basic history configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Editor selection
if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
typeset -U path

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME/.git" ] && mkdir -p "${ZINIT_HOME:h}" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Completion system
autoload -Uz compinit
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"

# zsh-vi-mode hooks
zvm_after_init() {
  if command -v fzf >/dev/null 2>&1 && [[ -o interactive ]] && [[ -t 0 ]] && [[ -t 1 ]]; then
    source <(fzf --zsh)
  fi
}

# Plugins
zinit light zsh-users/zsh-autosuggestions
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_CLIPBOARD_COPY_CMD='wl-copy'
ZVM_CLIPBOARD_PASTE_CMD='wl-paste -n'
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting


# Useful aliases
alias ls="ls --color=auto"
alias ll="ls -al"
alias rm="rm -i"
alias vim="nvim"
alias type="type -a"

#y function of yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd <"$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

