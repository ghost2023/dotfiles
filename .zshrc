# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export JAVA_HOME="/usr"
export ANDROID_HOME=$HOME/Android/Sdk
export CLASSPATH=/usr/local/lib/postgresql-42.7.1.jar:$CLASSPATH
export GOPATH=$HOME/go
export PATH="/home/ghost/.config/herd-lite/bin:$PATH:$HOME/.yarn/bin:$HOME/projects/automations/scripts:$GOPATH/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/home/ghost/.local/share/mise/installs/node/22.5.1/bin"

export EDITOR="/usr/bin/nvim"
export KITTY_ENABLE_WAYLAND=0

precmd() {
    precmd() {
        echo
    }
}
USE_POWERLINE="true"
# amuse
# gnzh
# ZSH_THEME="random"

# aliases
alias v=nvim
alias y=yarn
alias yw="yarn workspace"
alias p=pnpm
alias yd="yarn dev"
alias n=npm
alias nr="npm run"
alias ipa="ip a | grep wlan0 | grep inet | awk '{ print \$2 }' | awk -F/ '{ print \$1}'"
alias d=docker
alias wlc="wl-copy"
alias wlp="wl-paste"
alias lg=lazygit
alias qrg="qrencode -t ansiutf8 -m 2"
alias cd=z
alias c=clear
alias b=bpytop

function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

opv () {
  fd --maxdepth 2 --base-directory ~/projects -t d -a | fzf --query "$1" | read -r dir && cd "$dir" && nvim
}


plugins=(
  tmux
  git
  zsh-syntax-highlighting
  zsh-autosuggestions  
  colored-man-pages
  aliases
  zsh-vi-mode
) 

source $ZSH/oh-my-zsh.sh


local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%{$fg[blue]%}%~ %{$reset_color%}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"
setopt PROMPT_SUBST
PROMPT=" ${current_dir}${vcs_branch}${venv_prompt}
%b%F{green}❯%f "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Options
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Append a command directly
zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" |  wl-copy -n
	zvm_exit_visual_mode
}
zvm_after_init_commands+=('eval "$(fzf --zsh)"')

VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_INSERT=6
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
bindkey -v
export KEYTIMEOUT=1

# Created by `pipx` on 2024-06-09 23:58:53
export PATH="$PATH:/home/ghost/.local/bin"
if [ -f "/home/ghost/.config/fabric/fabric-bootstrap.inc" ]; then . "/home/ghost/.config/fabric/fabric-bootstrap.inc"; fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
# [[ -f /home/ghost/.dart-cli-completion/zsh-config.zsh ]] && . /home/ghost/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

eval "$(mise activate zsh)"

alias l="exa --icons -1"

export PHP_INI_SCAN_DIR="/home/ghost/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
. "/home/ghost/.deno/env"

source /home/ghost/.daytona.completion_script.zsh
