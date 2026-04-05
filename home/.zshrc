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

#### zsh-vi-mode (ZVM) config START ####

# zsh-vi-mode setup:
# - initialize at source time (so widgets/keymaps exist immediately)
# - disable lazy keybindings (so our custom remaps always apply)
ZVM_INIT_MODE=sourcing
ZVM_LAZY_KEYBINDINGS=false

# Enable system clipboard integration for zsh-vi-mode.
# Keep these as explicit Wayland commands.
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_CLIPBOARD_COPY_CMD='wl-copy'
ZVM_CLIPBOARD_PASTE_CMD='wl-paste -n'

# Helper: remap normal-mode p/P to system clipboard paste
# (default behavior is gp/gP for system clipboard).
_zvm_remap_p_to_clipboard() {
	zvm_bindkey vicmd 'p' zvm_paste_clipboard_after
	zvm_bindkey vicmd 'P' zvm_paste_clipboard_before
}

# Run after zsh-vi-mode init.
zvm_after_init() {
	_zvm_remap_p_to_clipboard
}

# Also run after lazy-keybinding phase (safe even when lazy is disabled).
zvm_after_lazy_keybindings() {
	_zvm_remap_p_to_clipboard
}

zinit light jeffreytse/zsh-vi-mode

# Fix plugin gap: di( / di' (surround text-object path) updated CUTBUFFER
# but did not sync to system clipboard. Override and add clipboard sync.
zvm_change_surround_text_object() {
	local ret=($(zvm_parse_surround_keys))
	local action=${1:-${ret[1]}}
	local surround=${2:-${ret[2]//$ZVM_ESCAPE_SPACE/ }}
	ret=($(zvm_search_surround "${surround}"))
	if [[ ${#ret[@]} == 0 ]]; then
		zvm_select_vi_mode $ZVM_MODE_NORMAL
		return
	fi
	local bpos=${ret[1]}
	local epos=${ret[2]}
	if [[ ${action:1:1} == 'i' ]]; then
		((bpos++))
	else
		((epos++))
	fi
	CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))}
	zvm_clipboard_copy_buffer
	case ${action:0:1} in
		c)
			BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
			CURSOR=$bpos
			zvm_select_vi_mode $ZVM_MODE_INSERT
			;;
		d)
			BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}"
			CURSOR=$bpos
			;;
	esac
}

#### zsh-vi-mode (ZVM) config END ####


#alias
alias ll="ls -al"
alias rm="rm -i"
alias vim="nvim"
alias type="type -a"

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

source <(fzf --zsh)

# Lazy-load conda to speed up shell startup.
export CONDA_EXE="/opt/miniconda/bin/conda"
_lazy_conda_init() {
	unset -f conda _lazy_conda_init
	local __conda_setup
	__conda_setup="$($CONDA_EXE shell.zsh hook 2>/dev/null)"
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
	IFS= read -r -d '' cwd <"$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# if is raspberry OS
if [[ $(uname -n) = "raspberrypi" ]]; then
	export PATH="$PATH:/opt/nvim-linux-arm64/bin"
fi

# opencode
export PATH=$HOME/.opencode/bin:$PATH

eval "$(starship init zsh)"

# Keep vi-mode key bindings after all plugins/scripts.
	bindkey -M viins '^?' backward-delete-char
	bindkey -M viins '^H' backward-delete-char
