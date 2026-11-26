#!/bin/sh
# setup_tools.sh [--install] — the programs dev-way's design / graph / binary-analysis parts use.
# Without --install it only checks and prints the plan (changes nothing). With --install it installs what is missing:
#   impeccable  : checked only (install it from its own source; its engine downloads itself on first run)
#   graphify    : uv tool install graphifyy (else pipx / pip --user), then `graphify install --platform claude` (adds its skill)
#   rea         : npx -y rea-agents@latest setup (REA's own setup: it shows its plan and asks before writing config)
#   craft-anything : only if craft-anything-cli is already on this PC (doctor, then setup --dry-run); otherwise rea covers the same job
# Nothing here is removed or upgraded; a tool already present is left alone.
DO=0; [ "$1" = "--install" ] && DO=1
HERE=$(cd "$(dirname "$0")/.." && pwd)
SK="$HOME/.claude/skills"
say() { printf '%s\n' "$*"; }
run() { say "  \$ $*"; [ $DO = 1 ] && sh -c "$*"; }

say "== impeccable (design)"
if [ -f "$SK/impeccable/SKILL.md" ]; then say "  present: $SK/impeccable"
elif [ -d "$HERE/vendor/impeccable" ]; then say "  missing -> copy vendor/impeccable"; run "mkdir -p '$SK' && cp -r '$HERE/vendor/impeccable' '$SK/impeccable' && mv '$SK/impeccable/SKILL.impeccable.md' '$SK/impeccable/SKILL.md'"
else say "  missing -> install the impeccable skill from its own source into $SK/impeccable (not bundled here)"; fi

say "== graphify (knowledge graph)"
if command -v graphify >/dev/null 2>&1; then say "  present: $(command -v graphify)"
else
  if command -v uv >/dev/null 2>&1; then run "uv tool install graphifyy"
  elif command -v pipx >/dev/null 2>&1; then run "pipx install graphifyy"
  else run "python3 -m pip install --user graphifyy"; fi
fi
if [ ! -f "$SK/graphify/SKILL.md" ]; then say "  skill missing"; run "graphify install --platform claude"; else say "  skill present"; fi

say "== rea (reverse engineering MCP)"
if grep -qs '"rea' "$HOME/.claude.json" 2>/dev/null; then say "  registered in ~/.claude.json"
elif command -v npx >/dev/null 2>&1; then say "  not registered -> REA's own setup (it asks before writing)"; run "npx -y rea-agents@latest setup"
else say "  needs Node.js (npx) first"; fi

say "== craft-anything (binary analysis MCP)"
if command -v craft-anything-cli >/dev/null 2>&1; then say "  present: $(craft-anything-cli --version 2>/dev/null)"; run "craft-anything-cli doctor"; say "  (setup: craft-anything-cli setup --dry-run first, then apply what it shows)"
else say "  not on this PC (no public installer known here) - use rea instead"; fi

[ $DO = 1 ] || say "
Plan only. Run again with --install to install what is missing. Restart Claude Code afterwards so new skills / MCP servers load."
