#!/usr/bin/env bash
# Install cheat-on-money skills for Hermes Agent.
# Hermes supports nested skill directories, so we symlink the entire repo
# into ~/.hermes/skills/ as a single category. All relative paths
# (../../shared-references/, ../../templates/, etc.) resolve correctly.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills}/cheat-on-money"

mkdir -p "$(dirname "$DEST")"

if [ -L "$DEST" ]; then
  rm "$DEST"
fi
if [ -e "$DEST" ] && [ ! -d "$DEST" ]; then
  echo "error: $DEST exists and is not a directory" >&2
  exit 1
fi

ln -sfn "$ROOT" "$DEST"
echo "linked: cheat-on-money → $DEST"
echo ""
echo "6 skills registered under category 'cheat-on-money':"
for d in "$DEST"/skills/*/; do
  echo "  - $(basename "$d")"
done
echo ""
echo "Usage: say 「我想搞钱」to trigger money-init."
