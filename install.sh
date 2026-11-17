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

# Links a file into place, keeping anything that was there as <name>.backup.
link() {
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    mv "$2" "$2.backup"
  fi
  ln -sf "$1" "$2"
}

link "$DOTFILES_DIR/zsh/zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES_DIR/git/gitignore" "$HOME/.gitignore"
link "$DOTFILES_DIR/npm/npmrc" "$HOME/.npmrc"
link "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES_DIR/atuin/config.toml" "$HOME/.config/atuin/config.toml"
link "$DOTFILES_DIR/bin/serve" "$HOME/.local/bin/serve"

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
