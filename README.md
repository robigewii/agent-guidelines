# agent-guidelines

Instruction blocks and skills that make coding agents more ambitious on your
behalf, so you can keep writing prompts the way you already do. One source
of truth, installed into Claude Code, Codex, GitHub Copilot and Cursor, with
plain-text prompts for every other model.

The first block, **ambition-reframe**, turns Felix Rieseberg's
["How to be more ambitious: A tutorial for humans with models"](https://felixrieseberg.com/how-to-be-more-ambitious-a-tutorial-for-humans-with-models/)
into standing instructions. Before any non-trivial task the agent names
what the deliverable is for, looks for the goal beyond the goal
(altitude), does the task the way a top practitioner would with their real
instruments and rawest sources (depth), borrows methods from other fields
without role-play (range), and ships an outside judge instead of grading
itself. Raises that would change the deliverable are stated beside the
literal result, never substituted silently.

## Pick your tool

| You use | Do this |
| --- | --- |
| Claude Code, Codex CLI, Copilot CLI | Clone, run the installer. Done. |
| Cursor | Run the installer (Cursor reads the Claude and Codex skill folders). Paste `prompts/ambition-reframe.system.md` into Settings > Rules > User Rules, or drop `templates/cursor/ambition-reframe.mdc` into a project's `.cursor/rules/`. |
| ChatGPT, Grok, Gemini, Claude.ai, a local model | Paste `prompts/ambition-reframe.system.md` into custom instructions or the system prompt. |
| A chat where you cannot set a system prompt | Use the prefix or the rewrite template in `prompts/ambition-reframe.user.md`. |
| Any repo, for every agent that opens it | Copy the marked block from `AGENTS.md` into that repo's `AGENTS.md`, and `skills/ambition-reframe/` into `.github/skills/`, `.claude/skills/` or `.agents/skills/`. |

## Install

```powershell
git clone https://github.com/robigewii/agent-guidelines
cd agent-guidelines
.\install.ps1              # install or update
.\install.ps1 -Uninstall   # remove links and marked blocks
```

```bash
git clone https://github.com/robigewii/agent-guidelines
cd agent-guidelines
./install.sh
./install.sh --uninstall
```

The installer is idempotent and touches only these locations:

| Tool | Global instructions (block upserted between markers) | Skills (linked) |
| --- | --- | --- |
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/<name>` |
| Codex | `~/.codex/AGENTS.md` | `~/.codex/skills/<name>` |
| Copilot CLI | `~/.copilot/copilot-instructions.md` | `~/.copilot/skills/<name>` |
| Cursor | no global file; see the table above | reads the Claude and Codex links |

Skills are linked (directory junction on Windows, symlink elsewhere), so an
edit in the clone is live in every tool at once. Blocks are copied between
`<!-- agent-guidelines:<name>:start -->` and `:end -->` markers, so
re-running replaces the old block instead of appending a second one. Text
outside the markers is never touched. Re-run after `git pull`.

## Turning it off where scope is deliberately tight

The block is global once installed. In a repo where you set scope tightly
on purpose, one line in that repo's `AGENTS.md` or `CLAUDE.md` overrides
it, because repo instructions rank above user-level ones in every tool
listed here:

```markdown
## Ambition Reframe: off in this repo
Scope here is set deliberately. Do the literal ask at full depth; do not propose altitude or range raises.
```

## Layout

| Path | Role |
| --- | --- |
| `AGENTS.md` | Canonical blocks between markers. Read directly by Codex, Copilot and Cursor inside this repo. |
| `CLAUDE.md` | Imports `AGENTS.md` for Claude Code. |
| `skills/<name>/` | Agent Skills (`SKILL.md` with YAML `name` and `description`, plus `references/`). The format is shared by Claude Code, Codex, Copilot and Cursor. |
| `prompts/` | The same guidance as plain text for models and apps without a file convention. |
| `templates/cursor/` | A `.mdc` rule with `alwaysApply: true` for Cursor projects. |
| `install.ps1`, `install.sh` | Installer and uninstaller. |

## Adding a block or skill

1. Add a skill folder under `skills/`, or a marked block to `AGENTS.md`.
2. If the block should reach non-file tools, add a matching entry under
   `prompts/` and `templates/`. CI fails if the key sentence of the block
   is missing from any of them.
3. Run the installer, open a pull request. CI runs both installers through
   install, reinstall, verify and uninstall on Ubuntu and Windows.

## Credits and license

The ambition-reframe moves are Felix Rieseberg's; the source notes under
`skills/ambition-reframe/references/` condense his article and keep his
prompt template verbatim. Everything here is MIT licensed, see `LICENSE`.
