# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing Claude Code configuration files. The main purpose is to maintain and sync Claude-related settings across machines.

## Commands

### Installation
```bash
./install.sh
```
Creates symlinks from this repository to `~/.claude/`.

## Architecture

```
claude/
├── CLAUDE.md      # Global instructions (→ ~/.claude/CLAUDE.md)
├── settings.json  # Claude Code settings (→ ~/.claude/settings.json)
└── commands/      # Custom slash commands (→ ~/.claude/commands/)
    ├── html-analyze/
    └── slumpgraph/
```

- **claude/CLAUDE.md**: ユーザーのグローバル指示（日本語会話、Bashコマンドの注意点など）
- **claude/settings.json**: 許可/拒否設定、有効なプラグイン
- **claude/commands/**: カスタムスラッシュコマンド（スキル）

## Adding New Dotfiles

Edit `install.sh` and add entries to the `dotfiles` array:
```
"source_file:destination_path"
```

## Adding New Commands

Create a new directory under `claude/commands/` with a markdown file defining the command.
