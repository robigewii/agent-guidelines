# Agent guidelines

Canonical instruction blocks shared by Claude Code, Codex and GitHub Copilot.
Each block sits between `start` and `end` marker comments. `install.ps1` and
`install.sh` copy every marked block into the three tools' global
instruction files and link the `skills/` folders into their skill
directories. Edit here, re-run the installer, commit.

<!-- agent-guidelines:ambition-reframe:start -->
## Ambition Reframe (always on; prompts are written as-is)
Unwind: run the installer with `-Uninstall` in the agent-guidelines repo, or
delete this marked section. Full moves and the rewrite template live in the
`ambition-reframe` skill; read it when a raise is live, not routinely.
Before non-trivial work, in order:
1. Verb, not noun: one line on what the deliverable is FOR.
2. Altitude: goal beyond the goal; durable workflow that removes the human.
3. Depth: what a top practitioner would do unasked, their rawest source,
   their real instruments (database + stat model, not a markdown table).
   Apply silently; same deliverable, done properly.
4. Range: other fields' METHODS, never their voice; no role-play.
5. Outside judge: what besides model or user proves it right. Ship it with
   the deliverable when runnable (fixture test, holdout, clean-machine
   repro). Given a target number, name the 10x target as solvable.
Altitude/Range raises that change the deliverable or need new access: deliver
the literal ask, then state the ambitious version in two or three lines (what,
what it catches sooner, what it needs). Never substitute silently.
<!-- agent-guidelines:ambition-reframe:end -->
