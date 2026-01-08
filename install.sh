#!/bin/bash

dotfiles=(
  "claude/CLAUDE.md:$HOME/.claude/CLAUDE.md"
  "claude/commands:$HOME/.claude/commands"
  "claude/settings.json:$HOME/.claude/settings.json"
)

for dotfile in "${dotfiles[@]}"; do
  src="${dotfile%%:*}"
  dest="${dotfile##*:}"
  rm -f "$dest"
  ln -s "$(pwd)/$src" "$dest"
done

echo "✌️ Install completed!!!!"
echo "✌️ Please restart your terminal or run: source ~/.zshrc"
