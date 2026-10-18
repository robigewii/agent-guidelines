# agent-guidelines

One source of truth for the instruction blocks and skills I want every
coding agent to follow: Claude Code, Codex and GitHub Copilot.

## Layout

| Path | Role |
| --- | --- |
| `AGENTS.md` | Canonical blocks, each wrapped in `<!-- agent-guidelines:<name>:start/end -->` markers. Codex and Copilot read this file directly when working inside this repo. |
| `CLAUDE.md` | Imports `AGENTS.md` so Claude Code sees the same text inside this repo. |
| `skills/<name>/SKILL.md` | Skills in the shared Agent Skills format (YAML `name` + `description`, markdown body, optional `references/`). All three tools read the format. |
| `install.ps1` / `install.sh` | Idempotent installer. Links every skill and upserts every marked block into the three tools' global files. |

## What the installer touches

| Tool | Global instructions | Skills directory |
| --- | --- | --- |
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/<name>` |
| Codex | `~/.codex/AGENTS.md` | `~/.codex/skills/<name>` |
| Copilot CLI | `~/.copilot/copilot-instructions.md` | `~/.copilot/skills/<name>` |

Skill directories are linked (directory junction on Windows, symlink
elsewhere), so an edit in the repo is live in every tool at once. Instruction
blocks are copied between markers, so re-running the installer replaces the
old block instead of appending a second one. Anything outside the markers in
those files is left alone.

```powershell
.\install.ps1              # install or update
.\install.ps1 -Uninstall   # remove links and marked blocks
```

```bash
./install.sh
./install.sh --uninstall
```

Copilot in VS Code reads repository files only. For a project, copy the
block from `AGENTS.md` into that repo's `AGENTS.md` or
`.github/copilot-instructions.md`, and the skill into `.github/skills/`.

## Blocks

- **ambition-reframe**: raise altitude, depth and range on every non-trivial
  task without the user changing how they write prompts. Based on Felix
  Rieseberg, "How to be more ambitious: A tutorial for humans with models"
  (October 2026). Source notes in `skills/ambition-reframe/references/`.

## Adding a block or skill

1. Add a skill folder under `skills/`, or a marked block to `AGENTS.md`.
2. Run the installer.
3. Commit.
