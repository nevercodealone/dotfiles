# Dotfiles

Dev environment config. Zsh, tmux, vim, git.

## Setup

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/xprofile ~/.xprofile
```

## Dependencies

- Oh-My-Zsh
- TPM + tmux-resurrect/continuum
- vim-plug

## OpenCode

Commands in `opencode/commands/` → symlinked to `~/.config/opencode/commands/`
