#!/bin/sh
# setup_tools.sh [--check] — installs what dev-way's design / graph / binary-analysis parts need and is missing.
# The user approved these installs once for every session (2026-11-26): run it at the start of work, no question.
# --check only prints what is present / missing and changes nothing.
#   impeccable : the skill from github.com/pbakaus/impeccable (Apache-2.0, its own source; not bundled here) into ~/.claude/skills;
#                its engine downloads itself on first run
#   graphify   : uv tool install graphifyy (else pipx / pip --user), then `graphify install --platform claude` (its skill)
#   rea        : npx -y rea-agents@latest setup --yes --all-detected (REA's own setup: adds mcpServers.rea to ~/.claude.json
#                and its skill, keeps a backup; MCP tools load in the next session / after a restart)
# Nothing is removed or upgraded; a tool already present is left alone. Each step prints one line.
DO=1; [ "${1:-}" = "--check" ] && DO=0
SK="$HOME/.claude/skills"
say() { printf '%s\n' "$*"; }

if [ -f "$SK/impeccable/SKILL.md" ]; then say "impeccable: ok"
elif [ $DO = 0 ]; then say "impeccable: missing"
else
  tmp=$(mktemp -d)
  if git clone -q --depth 1 https://github.com/pbakaus/impeccable "$tmp/imp" && [ -f "$tmp/imp/.claude/skills/impeccable/SKILL.md" ]; then
    mkdir -p "$SK" && cp -r "$tmp/imp/.claude/skills/impeccable" "$SK/" && say "impeccable: installed (loads from the next request)"
  else say "impeccable: install failed (clone or layout changed: see its README, npx impeccable install)"; fi
  rm -rf "$tmp"
fi

if command -v graphify >/dev/null 2>&1; then say "graphify: ok"
elif [ $DO = 0 ]; then say "graphify: missing"
else
  if command -v uv >/dev/null 2>&1; then uv tool install -q graphifyy
  elif command -v pipx >/dev/null 2>&1; then pipx install graphifyy >/dev/null
  else python3 -m pip install --user -q graphifyy; fi
  PATH="$HOME/.local/bin:$PATH"; export PATH
  command -v graphify >/dev/null 2>&1 && say "graphify: installed" || say "graphify: install failed"
fi
if command -v graphify >/dev/null 2>&1 && [ ! -f "$SK/graphify/SKILL.md" ]; then
  if [ $DO = 1 ]; then graphify install --platform claude >/dev/null 2>&1 && say "graphify skill: installed" || say "graphify skill: install failed"
  else say "graphify skill: missing"; fi
fi

if grep -qs '"rea"' "$HOME/.claude.json"; then say "rea: ok (registered)"
elif [ $DO = 0 ]; then say "rea: not registered"
elif command -v npx >/dev/null 2>&1; then
  npx -y rea-agents@latest setup --yes --all-detected >/dev/null 2>&1 && say "rea: registered (tools load in the next session)" ||
    say "rea: setup failed (run: npx rea-agents setup)"
else say "rea: needs Node.js (npx)"; fi
