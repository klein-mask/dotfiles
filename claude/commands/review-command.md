---
description: カスタムコマンド（スキル/スラッシュコマンド）をClaude公式ベストプラクティスに基づいてレビュー
argument-hint: <command-name>
allowed-tools: Read, Glob, Grep
---

# Purpose

指定されたカスタムコマンドをClaude公式ベストプラクティスに基づいてレビューし、改善点を提案する。

# Input

- $ARGUMENTS: レビュー対象のコマンド名（例: fetch-html, slumpgraph:analyze）

# Process

## 1. コマンドファイルの特定

以下の順序でコマンドファイルを検索:

1. `.claude/commands/$ARGUMENTS/$ARGUMENTS.md`
2. `.claude/commands/$ARGUMENTS.md`
3. `~/.claude/commands/$ARGUMENTS/$ARGUMENTS.md`
4. `~/.claude/commands/$ARGUMENTS.md`

名前空間付きの場合（例: `foo:bar`）:
- `foo/bar.md` として検索

## 2. ファイル読み込みと解析

コマンドファイルを読み込み、以下を解析:
- Frontmatter（YAML部分）
- 本文（Markdown部分）
- 行数・語数のカウント

## 3. レビュー実行

### 3.1 Frontmatter検証

| 項目 | チェック内容 | 判定 |
|------|-------------|------|
| description | 存在するか | PASS/FAIL |
| description | 具体的で明確か（10文字以上） | PASS/WARN |
| argument-hint | 引数使用時に定義されているか | PASS/WARN |
| allowed-tools | 定義されているか | INFO |
| allowed-tools | 必要最小限か（全ツール許可でないか） | PASS/WARN |
| model | タスク複雑度に適切か | INFO |

### 3.2 構造・サイズ検証

| 項目 | 基準 | 判定 |
|------|------|------|
| 行数 | 500行以下 | PASS/WARN/FAIL |
| 語数 | 5000語以下 | PASS/WARN/FAIL |
| 見出し構造 | # セクションが存在 | PASS/WARN |
| Purpose/Input/Output | 基本セクション存在 | PASS/WARN |

**行数基準**:
- 300行以下: PASS
- 300-500行: WARN
- 500行超: FAIL

### 3.3 内容品質検証

| 項目 | チェック内容 | 判定 |
|------|-------------|------|
| 入力定義 | $1, $2, $ARGUMENTS の説明があるか | PASS/WARN |
| 出力定義 | 成功/失敗時の出力形式が定義されているか | PASS/WARN |
| エラーハンドリング | エラーケースの対処が記載されているか | PASS/WARN |
| 具体性 | 曖昧な表現（「適切に」「必要に応じて」等）が多用されていないか | PASS/WARN |

### 3.4 アンチパターン検出

以下のパターンを検出し警告:

| パターン | 検出方法 |
|----------|----------|
| 絶対パス | `/Users/`, `/home/`, `C:\` 等の検出 |
| 全ツール許可 | allowed-tools 未指定 |
| 過長ファイル | 500行超 |
| 曖昧表現 | 「適切に」「必要に応じて」「など」の多用（3回以上） |
| 未使用引数 | argument-hint 定義あり but $ARGUMENTS/$1/$2 未使用 |

### 3.5 ベストプラクティス適合

| 項目 | チェック内容 | 判定 |
|------|-------------|------|
| 動的コンテンツ | `!command` `@file` の使用（該当時） | INFO |
| Progressive Disclosure | 詳細の分離（補助ファイル参照等） | INFO |
| セクション構成 | 論理的な順序（Purpose→Input→Process→Output） | PASS/WARN |

## 4. スコア算出

**スコア基準**:
- **A**: FAIL=0, WARN<=2
- **B**: FAIL=0, WARN<=5
- **C**: FAIL<=1, WARN<=8
- **D**: FAIL>=2 または WARN>8

# Output

```markdown
# Command Review Report

## Summary
- **File**: [ファイルパス]
- **Score**: [A/B/C/D]
- **Issues**: [FAIL数]
- **Warnings**: [WARN数]

## Frontmatter
- [x] description: [内容] - PASS
- [ ] allowed-tools: 未定義 - WARN: セキュリティのため必要なツールのみ指定を推奨

## Structure
- Lines: [行数] - PASS/WARN/FAIL
- Words: [語数] - PASS/WARN/FAIL
- Sections: [セクション一覧]

## Content Quality
- [x] Input definition - PASS
- [ ] Error handling - WARN: エラーケースの記載なし

## Anti-patterns Detected
- [パターン名]: [該当箇所] - [改善案]

## Recommendations
1. [優先度高い改善提案]
2. [その他の改善提案]
```

# Important Notes

- レビューは読み取り専用で実行（ファイル変更なし）
- 改善提案は具体的なコード例を含める
- スコアは参考値であり、コンテキストに応じて判断が必要

# References

- [Slash commands - Claude Code Docs](https://code.claude.com/docs/en/slash-commands)
- [Agent Skills - Claude Code Docs](https://code.claude.com/docs/en/skills)
- [Claude Code: Best practices - Anthropic](https://www.anthropic.com/engineering/claude-code-best-practices)
