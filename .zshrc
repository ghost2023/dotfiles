ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


### ENV
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

export JAVA_HOME="/usr"

export ANDROID_HOME=/opt/android-sdk/

export GOPATH=$HOME/go

export QT_QPA_PLATFORM=xcb # Forces X11 mode for stability on Wayland
export ANDROID_EMULATOR_USE_VULKAN=false # NVIDIA + Wayland Vulkan can be unstable; GLES is safer

##
## PATH
##
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/projects/automations/scripts:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/.local/share/mise/installs/node/22.5.1/bin:$PATH"
export PATH="$HOME/.cargo/env:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/projects/scripts/global:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin/:$PATH"
export PATH=/home/ghost/.opencode/bin:$PATH

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR="$HOME/.local/share/bob/nvim-bin/nvim"

export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"

export GTK_USE_PORTAL=1

# ========================
# plugins
# ========================

# omz
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::aliases
zinit snippet OMZP::colored-man-pages

zinit snippet OMZT::gnzh

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

autoload -U compinit && compinit
zinit light Aloxaf/fzf-tab

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
alias l="exa --icons -1"

# ========================
# Options
# ========================

HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[B" down-line-or-beginning-search

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search

bindkey '^v' edit-command-line

# [Ctrl-Delete] - delete whole forward-word
bindkey '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group completions by type
zstyle ':completion:*' group-name ''

# Add descriptions to options
zstyle ':completion:*' auto-description 'always'
# zstyle ':completion:*' menu no

# ========================
# inits 
# ========================

eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"


run_app() {
  cd ./apps/pdv || exit
  tmux new-session \;\
  send-keys 'flutter run --debug -d linux --pid-file=/tmp/appdev.pid --dart-define-from-file=env-debug.json' Enter \;\
  split-window -v \;\
  send-keys 'cd ../ && npx -y nodemon -e dart -x "cat /tmp/appdev.pid | xargs -r kill -USR1"' Enter \;\
  select-pane -t 0 \;
}

# bun completions
[ -s "/home/ghost/.bun/_bun" ] && source "/home/ghost/.bun/_bun"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ghost/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ghost/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ghost/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ghost/tmp/google-cloud-sdk/completion.zsh.inc'; fi


# Load Angular CLI autocompletion.
source <(ng completion script)
