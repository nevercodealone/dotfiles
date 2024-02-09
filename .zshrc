# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="$HOME/.oh-my-zsh"
  # ... (der restliche Inhalt deiner .zshrc)

export PATH="$PATH:$HOME/.local/share/sonar-scanner/bin:$HOME/.config/composer/vendor/bin:/home/rolandgolla/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/opt:/home/rolandgolla/anaconda3/bin"
  
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="fino"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  extract
  jump
  z
  zsh-syntax-highlighting
  vi-mode
  web-search
  history-substring-search
  zsh-autosuggestions
  history
  chucknorris
  jira
  docker-compose
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
bindkey '^f' vi-forward-blank-word

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

ox () {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume $HOME:$HOME \
        --volume $(pwd):/app \
        --volume $(pwd)/ox:/tmp \
        --volume $SSH_AUTH_SOCK:/ssh-agent \
        --env SSH_AUTH_SOCK=/ssh-agent \
         keywanghadamioxid/ox "$@"
     }
     
## need to install
# zsh-syntax-highlighting/
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

precmd() { print "" }

autoload zmv
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zsy='noglob zmv -Ls'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rolandgolla/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rolandgolla/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/rolandgolla/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/rolandgolla/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
