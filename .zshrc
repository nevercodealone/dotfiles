export ZSH="$HOME/.oh-my-zsh"

path+=(
  $HOME/.local/share/sonar-scanner/bin
  $HOME/.config/composer/vendor/bin
  $HOME/.local/bin
  $HOME/.yarn/bin
  $HOME/.config/yarn/global/node_modules/.bin
  /opt
  $HOME/anaconda3/bin
)
export PATH

ZSH_THEME="fino"

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
  jira
  docker-compose
  ssh-agent
)

source $ZSH/oh-my-zsh.sh

# ---- User configuration ----

ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
bindkey '^f' vi-forward-blank-word

ox () {
    if ! command -v docker &>/dev/null; then
        echo "ox: docker not found" >&2; return 1
    fi
    if [ -z "$SSH_AUTH_SOCK" ]; then
        echo "ox: SSH agent not running" >&2; return 1
    fi
    local tty_flag=""
    tty -s && tty_flag=--tty
    docker run \
        $tty_flag \
        --interactive \
        --rm \
        --user "$(id -u):$(id -g)" \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume "$HOME/.ssh:$HOME/.ssh:ro" \
        --volume "$(pwd):/app" \
        --volume "$SSH_AUTH_SOCK:/ssh-agent" \
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

# >>> conda initialize >>>
if [ -d "$HOME/anaconda3" ] && [ -x "$HOME/anaconda3/bin/conda" ]; then
    eval "$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)" || \
        source "$HOME/anaconda3/etc/profile.d/conda.sh" 2>/dev/null
fi
# <<< conda initialize <<<

# nvm (lazy-loaded for fast shell startup)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
node()  { nvm use --lts >/dev/null 2>&1 || nvm install --lts >/dev/null 2>&1; command node "$@"; }
npm()   { nvm use --lts >/dev/null 2>&1 || nvm install --lts >/dev/null 2>&1; command npm "$@"; }
npx()   { nvm use --lts >/dev/null 2>&1 || nvm install --lts >/dev/null 2>&1; command npx "$@"; }

# Local bin takes precedence
export PATH="$HOME/bin:$PATH"

# Auto-start tmux (fresh session per terminal, skip if already in tmux, VS Code, or SSH)
if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ -z "$VSCODE_IPC_HOOK_CLI" ] && [ -z "$SSH_CONNECTION" ]; then
  tmux new-session
fi

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

