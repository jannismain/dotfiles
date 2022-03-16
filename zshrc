# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export HOMEBREW=/usr/local
export PATH=$HOME/bin:$HOME/Developer/util:$HOME/Developer/japi2websocket:$HOMEBREW/sbin:$PATH:$HOMEBREW/bin

# Workaround for issues with locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX="true"

# Activate antigen (plugin manager)
source $HOMEBREW/share/antigen/antigen.zsh
antigen use oh-my-zsh
# antigen bundle git
antigen apply

# Change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=14

# enable command auto-correction.
ENABLE_CORRECTION="false"

# display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # git
  # common-aliases
  # python
  # colored-man-pages
  # docker
  # docker-compose
)

# load brewed zsh-completions
# ! must be called before `oh-my-zsh.sh`
if type brew &>/dev/null; then
 FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
 FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  # configure completion
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit
fi
source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='code --wait'

# SSH
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Interactive Shell
## Navigation
alias d="dirs -v | head -10"
alias 1="cd -"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="cd -6"
alias 7="cd -7"
alias 8="cd -8"
alias 9="cd -9"
function mkcd() { mkdir -p "$@" && cd "$_"; }

## Python
### Virtual Environments
alias venv="source env/bin/activate"
### Pip
alias pipi="pip install"
alias pipir="pip install -r requirements.txt"
alias pipl="pip list"
function pipu() {
  if [ -n "$1" ]
  then
    python -m pip install --upgrade "$1"
  else
    python -m pip install --upgrade pip
  fi
}
# Create requirements file
alias pipreq="pip freeze > requirements.txt"
# Update all installed packages
function pipupall {
  # non-GNU xargs does not support nor need `--no-run-if-empty`
  local xargs="xargs --no-run-if-empty"
  xargs --version 2>/dev/null | grep -q GNU || xargs="xargs"
  pip list --outdated --format freeze | cut -d= -f1 | ${=xargs} pip install --upgrade
}

# Uninstalled all installed packages
function pipunall {
  # non-GNU xargs does not support nor need `--no-run-if-empty`
  local xargs="xargs --no-run-if-empty"
  xargs --version 2>/dev/null | grep -q GNU || xargs="xargs"
  pip list --format freeze | cut -d= -f1 | ${=xargs} pip uninstall
}

CORRECT_IGNORE_FILE='.*'


function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

export RPROMPT='$(check_last_exit_code)'

autoload -Uz promptinit; promptinit
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# configure ls
export LSCOLORS=ExFxBxDxCxegedabagacad

# configure pipx
export PATH="$PATH:/Users/mkj/.local/bin"
eval "$(register-python-argcomplete pipx)"

# pip_search: use for `pip search`
# alias pip='function _pip(){
#     if [ $1 = "search" ]; then
#         pip_search "$2";
#     else pip "$@";
#     fi;
# };_pip'
# FIXME: alias search subcommand without breaking completion for pip

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# configure ruby
eval "$(rbenv init -)"

# git-extras
source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh

# node
# - activate specific system node version
# alias node14='export PATH="/usr/local/opt/node@14/bin:$PATH"'
# alias node16='export PATH="/usr/local/opt/node/bin:$PATH"'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.dotfiles/media

## fzf
# fuzzy search used by powerlevel10k and ctrl+r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
