# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export JAVA_HOME="/usr"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$PATH:$HOME/.yarn/bin"
export CLASSPATH=/usr/local/lib/postgresql-42.7.1.jar:$CLASSPATH

precmd() {
    precmd() {
        echo
    }
}

# ZSH_THEME="bira"

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

plugins=(
  tmux
  git
  zsh-syntax-highlighting
  zsh-autosuggestions  
) 
  
source $ZSH/oh-my-zsh.sh
 
# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/ghost/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ghost/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# # The next line enables shell command completion for gcloud.
# if [ -f '/home/ghost/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ghost/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


declare -A pomo_options
pomo_options["work"]="45"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"

op () {
  find ~/projects -maxdepth 3 -path '*' -type d -readable -not -path '*/node_modules*' -not -path '*/\.*' -print 2>/dev/null | fzf --query "$1" | read -r dir; 
  cd "$dir";
}

opv () {
  find ~/projects -maxdepth 2 -path '*' -type d -readable -not -path '*/node_modules*' -not -path '*/\.*' -print 2>/dev/null | fzf --query "$1" | read -r dir; 
  cd "$dir";
  nvim
}

cg () {
  grep --exclude-dir={node_modules,.git,.next} -RP "$2" "$1" | awk -F: '{printf "\033[1;32m%s\033[0m", $1":\t";  for(i=2;i<=NF;i++){ if( i!= 2) { printf ":"};printf "%s", $i} printf "\n"}' \
  | fzf --ansi | grep -Po '(?<=\t).*' | wl-copy
}

eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%{$fg[blue]%}%~ %{$reset_color%}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
    local kube_prompt='$(kube_ps1)'
else
    local kube_prompt=''
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

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
