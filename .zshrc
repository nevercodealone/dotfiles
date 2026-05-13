# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# PATH (use $HOME everywhere for portability)
export PATH="$PATH:$HOME/.local/share/sonar-scanner/bin:$HOME/.config/composer/vendor/bin:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/opt:$HOME/anaconda3/bin"

# Theme
ZSH_THEME="fino"

# Plugins (added 'ssh-agent' to manage SSH keys cleanly across shells)
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
  ssh-agent
)

source $ZSH/oh-my-zsh.sh

# ---- User configuration ----

ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
bindkey '^f' vi-forward-blank-word

# ox helper: run keywanghadamioxid/ox in docker with host user/SSH
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

## Setup notes (one-time, per fresh machine):
# sudo apt install fortune-mod gawk
# nvm install --lts
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions.git    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Blank line before each prompt
precmd() { print "" }

# zmv & friends
autoload zmv
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zsy='noglob zmv -Ls'

# >>> conda initialize >>> (only if anaconda is actually installed)
if [ -d "$HOME/anaconda3" ]; then
  __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
          . "$HOME/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="$HOME/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
fi
# <<< conda initialize <

# nvm (single load, no duplicate)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm use --lts >/dev/null   # always uses whatever LTS is currently installed

# Local bin takes precedence
export PATH="$HOME/bin:$PATH"

# Auto-attach tmux per directory (skip if already inside tmux)
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  session_name=$(basename "$PWD")
  tmux new-session -A -s "$session_name"
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/roland/.lmstudio/bin"
# End of LM Studio CLI section

