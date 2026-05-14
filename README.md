# Dotfiles

Dev environment config for Linux/X11. Zsh, tmux, vim, git.

## Setup

```bash
make install
```

Check what's linked:

```bash
make status
```

Remove symlinks:

```bash
make uninstall
```

### Manual (no Make)

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/xprofile ~/.xprofile
```

## Dependencies

- **Oh-My-Zsh**: `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- **zsh-syntax-highlighting**: `git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- **zsh-autosuggestions**: `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- **TPM** (tmux plugin manager): `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` then `Ctrl+b I` to install plugins
- **vim-plug**: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim` then `:PlugInstall` in Vim
- **coc.nvim extensions**: `:CocInstall coc-json coc-tsserver coc-html coc-css` in Vim
- **delta** (git pager): `sudo apt install git-delta` or `cargo install git-delta`
- **xclip** / **wl-copy**: clipboard support for tmux mouse selection

## OpenCode

Commands in `opencode/commands/` are symlinked to `~/.config/opencode/commands/` by `make install`.

## Notes

- **xprofile**: hardwired for Lenovo laptop (eDP-1) + external monitor (DP-1). Adjust monitor names for your hardware.
- **tmux auto-start**: each terminal gets its own fresh tmux session. Auto-disabled in VS Code terminals and SSH sessions.
- **nvm**: lazy-loaded on first use of `node`, `npm`, `npx`, or `nvm` for fast shell startup.

### tmux session management

- `Ctrl+b d` — detach from session (session keeps running)
- `tmux ls` — list running sessions
- `tmux attach -t N` — re-attach to session number N
