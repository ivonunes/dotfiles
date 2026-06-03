#!/bin/sh

set -eu

PROFILE="${1:-personal}"
DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

cd "$DOTFILES_DIR"

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file=brew/Brewfile

if [ -f "brew/Brewfile.$PROFILE" ]; then
  brew bundle --file="brew/Brewfile.$PROFILE"
fi

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/mise"
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/.local/bin"

ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/gitignore" "$HOME/.gitignore"
ln -sf "$DOTFILES_DIR/npm/npmrc" "$HOME/.npmrc"
ln -sf "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
ln -sf "$DOTFILES_DIR/bin/serve" "$HOME/.local/bin/serve"

if command -v mise >/dev/null 2>&1; then
  mise trust "$DOTFILES_DIR/mise/config.toml"
fi

if [ ! -f "$HOME/.zshrc.local" ]; then
  : > "$HOME/.zshrc.local"
fi

if [ ! -f "$HOME/.hushlogin" ]; then
  : > "$HOME/.hushlogin"
fi

if [ ! -f "$HOME/.gitconfig.local" ]; then
  printf "Git name: "
  read -r GIT_NAME

  printf "Git email: "
  read -r GIT_EMAIL

  {
    printf "[user]\n"
    printf "\tname = %s\n" "$GIT_NAME"
    printf "\temail = %s\n" "$GIT_EMAIL"
  } > "$HOME/.gitconfig.local"
fi
