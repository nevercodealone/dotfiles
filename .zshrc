# ---- oh-my-zsh ----
export ZSH="$HOME/.oh-my-zsh"

# Doppelte PATH-Einträge automatisch entfernen
typeset -U path PATH

# Basis-PATH (zentral, nicht mehr über die ganze Datei verstreut)
path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/.opencode/bin
  $HOME/.lmstudio/bin
  $HOME/.local/share/sonar-scanner/bin
  $HOME/.config/composer/vendor/bin
  $HOME/.yarn/bin
  $HOME/.config/yarn/global/node_modules/.bin
  $path
)
# Hinweis: /opt und $HOME/anaconda3/bin entfernt.
#   - /opt direkt enthält keine Binaries, falsch eingehängt.
#   - anaconda3/bin wird unten von "conda initialize" gesetzt, doppelt war Quatsch.

ZSH_THEME="fino"

# Plugin-Reihenfolge korrigiert:
#   - zsh-autosuggestions vor zsh-syntax-highlighting
#   - history-substring-search MUSS nach zsh-syntax-highlighting kommen (offizielle Doku)
plugins=(
  git
  extract
  jump
  z
  vi-mode
  web-search
  history
  jira
  docker-compose
  ssh-agent
  zsh-autosuggestions
  zsh-syntax-highlighting
  history-substring-search
)

source $ZSH/oh-my-zsh.sh

# ---- User configuration ----

ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan"
bindkey '^f' vi-forward-blank-word

# Leere Zeile vor jedem Prompt
precmd() { print "" }

# zmv & friends
autoload -U zmv
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zsy='noglob zmv -Ls'

# ---- ox: ephemerer Docker-Container mit aktuellem User ----
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
# ---- Auto-tmux ----
# WICHTIG: $SHELL muss auf zsh zeigen, sonst startet tmux bash-Panes ohne oh-my-zsh.
# Falls deine Login-Shell noch bash ist:
#   chsh -s "$(command -v zsh)"
#   danach KOMPLETT aus- und einloggen (nicht nur Terminal-Tab schließen)
#
# `exec` ersetzt die äußere zsh durch tmux. Sonst hängt beim tmux-Exit eine
# tote zsh rum, die du nochmal beenden müsstest.
if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ -z "$VSCODE_IPC_HOOK_CLI" ] && [ -z "$SSH_CONNECTION" ]; then
    exec tmux new-session
fi

# ---- nvm (optimized lazy loading) ----
export NVM_DIR="$HOME/.nvm"

# Lazy loading function
_load_nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    # Use default version or latest LTS
    nvm use default >/dev/null 2>&1 || nvm use --lts >/dev/null 2>&1 || nvm install --lts >/dev/null 2>&1
}

# Create aliases that will trigger nvm loading
nvm()  { _load_nvm; nvm  "$@"; }
node() { _load_nvm; command node "$@"; }
npm()  { _load_nvm; command npm  "$@"; }
npx()  { _load_nvm; command npx  "$@"; }

# Set default node version to latest
alias nvm-set-default="nvm alias default node"
