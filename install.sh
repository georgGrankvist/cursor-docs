#!/usr/bin/env bash
set -e

TARGET=${1:-}

usage() {
  echo "Usage: $0 [cursor|claude]"
  echo ""
  echo "  cursor  Install to ~/.cursor/agents/ and ~/.cursor/commands/"
  echo "  claude  Install to ~/.claude/agents/ and ~/.claude/commands/"
  exit 1
}

if [[ -z "$TARGET" ]]; then
  usage
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$TARGET" in
  cursor)
    mkdir -p ~/.cursor/agents ~/.cursor/commands
    cp "$SCRIPT_DIR/cursor/agents/"*.md ~/.cursor/agents/
    cp "$SCRIPT_DIR/cursor/commands/"*.md ~/.cursor/commands/
    echo "Installed to ~/.cursor/"
    echo "  agents:   $(ls "$SCRIPT_DIR/cursor/agents/"*.md | wc -l | tr -d ' ') files"
    echo "  commands: $(ls "$SCRIPT_DIR/cursor/commands/"*.md | wc -l | tr -d ' ') files"
    ;;
  claude)
    mkdir -p ~/.claude/agents ~/.claude/commands
    cp "$SCRIPT_DIR/claude/agents/"*.md ~/.claude/agents/
    cp "$SCRIPT_DIR/claude/commands/"*.md ~/.claude/commands/
    echo "Installed to ~/.claude/"
    echo "  agents:   $(ls "$SCRIPT_DIR/claude/agents/"*.md | wc -l | tr -d ' ') files"
    echo "  commands: $(ls "$SCRIPT_DIR/claude/commands/"*.md | wc -l | tr -d ' ') files"
    echo ""
    echo "Tip: Set AI_DOCS_DIR in your shell profile to point to this repo:"
    echo "  export AI_DOCS_DIR=\"$SCRIPT_DIR\""
    ;;
  *)
    usage
    ;;
esac
