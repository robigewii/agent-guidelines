#!/usr/bin/env bash
# Install or remove the agent-guidelines blocks and skills for Claude Code,
# Codex and GitHub Copilot CLI. Idempotent. Same behaviour as install.ps1:
# skills are symlinked, marked blocks from AGENTS.md are upserted, text
# outside the markers is never touched.
#
#   ./install.sh              install or update
#   ./install.sh --uninstall  remove symlinks and marked blocks
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
agents="$repo/AGENTS.md"
mode="${1:-install}"
[[ "$mode" == "--uninstall" ]] && mode=uninstall

targets=(
  "Claude Code|$HOME/.claude/CLAUDE.md|$HOME/.claude/skills"
  "Codex|$HOME/.codex/AGENTS.md|$HOME/.codex/skills"
  "Copilot CLI|$HOME/.copilot/copilot-instructions.md|$HOME/.copilot/skills"
)

block_names() {
  grep -oE '<!-- agent-guidelines:[a-z0-9-]+:start -->' "$agents" | sed -E 's/.*:([a-z0-9-]+):start.*/\1/'
}

block_text() { # name -> block including markers
  awk -v s="<!-- agent-guidelines:$1:start -->" -v e="<!-- agent-guidelines:$1:end -->" \
    '$0==s{p=1} p{print} $0==e{exit}' "$agents"
}

# strip the named block (and one blank line before it) from stdin
strip_block() {
  awk -v s="<!-- agent-guidelines:$1:start -->" -v e="<!-- agent-guidelines:$1:end -->" '
    $0==s{p=1; if(n>0 && buf[n]=="") n--; next}
    p && $0==e{p=0; next}
    p{next}
    {buf[++n]=$0}
    END{for(i=1;i<=n;i++) print buf[i]}'
}

set_block() { # file name
  local file="$1" name="$2" tmp
  mkdir -p "$(dirname "$file")"
  touch "$file"
  tmp="$(mktemp)"
  if grep -q "agent-guidelines:$name:start" "$file"; then
    { strip_block "$name" <"$file"; echo; block_text "$name"; } >"$tmp"
    echo updated
  else
    { cat "$file"; [[ -s "$file" ]] && echo; block_text "$name"; } >"$tmp"
    echo added
  fi
  mv "$tmp" "$file"
}

remove_block() { # file name
  local file="$1" name="$2" tmp
  [[ -f "$file" ]] || { echo absent; return; }
  grep -q "agent-guidelines:$name:start" "$file" || { echo absent; return; }
  tmp="$(mktemp)"
  strip_block "$name" <"$file" >"$tmp"
  mv "$tmp" "$file"
  echo removed
}

# Git Bash / MSYS: `ln -s` on a directory silently COPIES it. Use a junction.
case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) on_windows=1 ;; *) on_windows=0 ;; esac

make_link() { # link target
  if (( on_windows )); then
    # MSYS_NO_PATHCONV stops Git Bash rewriting /c and /J into paths.
    MSYS_NO_PATHCONV=1 cmd /c mklink /J "$(cygpath -w "$1")" "$(cygpath -w "$2")" >/dev/null \
      || { echo "  error: mklink /J failed for $1" >&2; return 1; }
  else
    ln -s "$2" "$1"
  fi
}

set_link() { # skillsdir skillpath
  local link
  link="$1/$(basename "$2")"
  mkdir -p "$1"
  if [[ -L "$link" ]]; then
    [[ "$(readlink -f "$link")" == "$(readlink -f "$2")" ]] && { echo linked; return; }
    rm "$link"
  elif [[ -d "$link" ]]; then
    mv "$link" "$link.bak-$(date +%Y%m%d-%H%M%S)"
    echo "  warning: $link was a real directory; moved aside" >&2
  fi
  make_link "$link" "$2"
  echo linked
}

remove_link() {
  local link
  link="$1/$(basename "$2")"
  [[ -e "$link" || -L "$link" ]] || { echo absent; return; }
  [[ -L "$link" ]] || { echo "kept (real directory, not ours)"; return; }
  rm "$link"
  echo removed
}

mapfile -t names < <(block_names)
[[ ${#names[@]} -gt 0 ]] || { echo "No marked blocks in $agents" >&2; exit 1; }
mapfile -t skills < <(find "$repo/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -printf '%h\n' | sort)

for t in "${targets[@]}"; do
  IFS='|' read -r tname instr sdir <<<"$t"
  echo "== $tname"
  for n in "${names[@]}"; do
    if [[ $mode == uninstall ]]; then r=$(remove_block "$instr" "$n"); else r=$(set_block "$instr" "$n"); fi
    printf '  block %-24s %-8s %s\n' "$n" "$r" "$instr"
  done
  for s in "${skills[@]}"; do
    if [[ $mode == uninstall ]]; then r=$(remove_link "$sdir" "$s"); else r=$(set_link "$sdir" "$s"); fi
    printf '  skill %-24s %-8s %s\n' "$(basename "$s")" "$r" "$sdir/$(basename "$s")"
  done
done
