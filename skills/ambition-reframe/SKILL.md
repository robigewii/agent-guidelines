---
name: ambition-reframe
description: "Use when a task arrives phrased as a single deliverable (a script, a deck, a fix, a summary, a report, a query) and the literal ask is probably a guess at a larger outcome; when the model reaches for the quickest adequate artifact; when a target number is modest; or when the user asks for 'the ambitious version'. Also use when asked to rewrite a prompt to get a deeper result."
---

# Ambition Reframe

Four types of ambition from Felix Rieseberg's tutorial: Speed (skip, it's the
default), Altitude, Depth, Range. The user writes prompts as they always have;
this skill raises the result on their behalf. Full source notes in
`references/source-notes.md`. The always-on block that triggers this skill
is the `ambition-reframe` block in the agent-guidelines repo's `AGENTS.md`.

## The reframe (run before non-trivial work)

1. **Verb, not noun.** State in one line what the deliverable is *for*.
   "A QBR deck" is "getting busy people to believe a cause-and-effect story
   and decide under uncertainty in 30 minutes." The verb exposes which
   fields and tools matter.
2. **Altitude.** What should happen *next*? What is the goal beyond the
   goal? Is there a durable workflow that takes the human out of the loop
   (fix crashes → keep the app crash-free)? Name what access or tooling it
   would need.
3. **Depth.** Ask the four questions, then do what they say:
   - what would a top professional do here that was not asked for;
   - what is the rawest material they would start from, instead of what
     has already been digested;
   - which specific methods and instruments would they use (a database and
     a statistical model, not a markdown table);
   - what, other than the model or the user, would show the result is right.
4. **Range.** Assemble the crew the verb implies (analyst, editor, motion
   designer, short seller, forensic accountant). Take their *methods*. Never
   their voice.
5. **Outside judge.** Name the judge from step 3 and ship it with the
   deliverable when it can be run: a test with a fixture, a holdout
   dataset, a reproduction on a clean machine. Self-grading is not
   verification.

## Decision rule

| Raise | Action |
| --- | --- |
| Depth, outside judge | Apply silently. It is the same deliverable, done the way the best would. |
| Unreasonable target | When a number is given, name the 10x target and treat it as solvable. Keep going when it "seems impossible". |
| Altitude or Range that changes the deliverable or needs new access | Deliver the literal ask, then state the ambitious version in two or three lines: what it is, what it would catch sooner, what it needs. Never substitute it silently. |
| Creative work with no outcome behind it | Altitude does not apply. Depth and Range still do. |

Tell-tale that Altitude applies: people will hold meetings about the result.

## Prompt rewrite (when asked to improve a prompt)

Use the author's template verbatim, then rewrite:

> I want a deeper version of this task, not a bigger one. Before rewriting
> it: (1) say what a top professional in this field would do here that I'm
> not asking for; (2) name the rawest material they would start from instead
> of what has already been digested for me; (3) name the specific methods and
> tools they would use; (4) say what, other than you or me, would show the
> result is right. Then rewrite my prompt to ask for exactly that.

## Anti-patterns

- **Vocabulary switch without method switch.** "As a data scientist" followed
  by a markdown table. Insist on the instrument.
- **Role-play.** Writing *like* the short seller instead of doing what the
  short seller does to research a position. Makes transcripts weirder, not
  results better.
- **Bigger instead of deeper.** More sections, more features, same shallow
  source material.
- **Model as its own judge.** Insist on a tool, a holdout dataset, a
  reproduction on another machine, a test the user can run.
- **Surrender at "not possible".** Classify first (`philosophy`
  constraint table). Effort is not a constraint.

## Pairs with

`philosophy` (posture and constraint classification), `inhuman-spec` (once
the ambitious version is chosen, spec it), `prompt-engineering-patterns`
(mechanics of the rewritten prompt).
