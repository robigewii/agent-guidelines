# Source notes: "How to be more ambitious: A tutorial for humans with models"

Felix Rieseberg, 13 October 2026.
https://felixrieseberg.com/how-to-be-more-ambitious-a-tutorial-for-humans-with-models/

Condensed, with the author's concrete prompts kept verbatim. Advice is
model-agnostic.

## Four types of ambition

| Type | Meaning | Status |
| --- | --- | --- |
| Speed | Same work in less time | Default; needs no creativity, skipped |
| Altitude | Go up in abstraction; consider the outcome, not the task | Core |
| Depth | Treat the task as a field-leading expert would; touch the underlying data, tools, problems | Core |
| Range | Draw on more fields than the task needs at the surface | Core, "where the most magic happens" |

## Altitude

Ask: what do you want to happen next? What is the goal beyond the goal?
Author's own move: from "fix this crash" to "keep our apps crash-free."

Worked example, Acme Inc quarterly business review, three rungs:

1. Give the model as much raw business data as possible, not the template
   numbers. "Tell me what changed this quarter, why, and what we should do
   about it."
2. "Work out which three decisions are most urgent in the face of
   everything you've learned, and start working on potential directions
   with for/against arguments."
3. "The review exists so leadership catches problems early and moves money
   and people to the right places. Design a better way to do that than a
   quarterly deck, show from our own history that it would have caught
   things sooner, and run it beside the current one for a quarter."

Notes:
- Works best when there is an ultimate outcome; less well for creative work.
- Tell-tale sign: you will hold meetings about the result.
- Payoff is durable workflows that take the human out of the loop. This
  usually means changing *your* workflow first: for crash-free apps the
  author had to give the model crash reports, a version-to-commit map, and
  Windows/macOS/Linux machines to reproduce and verify on.
- "Claude, go make money" does not work on its own in 2026; the ceiling
  rises with capability.

## Depth

Push the model to the tools, techniques, media and knowledge of the best
professionals, and keep pushing until those people might learn something.

- **Same instruments as the best.** Prompted to act like a professional,
  models switch vocabulary without switching methods. When it reaches for a
  markdown table, insist on a database and a statistical model. You need
  not know the expert's tools; the model usually does.
- **Unreasonable goals, framed as reasonable.** Need 10s to become 5s? Ask
  for 200ms. If it seems impossible to the model, reiterate it is solvable
  and to keep going.
- **Challenge what you know.** Give raw data; ask for adversarial checks.
  "We believe churn is an onboarding problem. Try to reproduce that from
  the raw data."
- **Produce new knowledge.** "Build a simulation of our customers that
  reproduces the last year from our logs. Then find the earliest signal of
  churn we don't know about yet, and show it predicts on data it has not
  seen."
- **Outside judge.** Do not let the model judge itself. Ideally a tool it
  can run for immediate feedback.

Author's rewrite prompt (verbatim):

> I want a deeper version of this task, not a bigger one. Before rewriting
> it: (1) say what a top professional in this field would do here that I'm
> not asking for; (2) name the rawest material they would start from instead
> of what has already been digested for me; (3) name the specific methods and
> tools they would use; (4) say what, other than you or me, would show the
> result is right. Then rewrite my prompt to ask for exactly that.

## Range

Consider the work from more fields than used to be economical. Multi-agent
setups (threads, orchestrators, subagents) make this practical.

- **Replace nouns with verbs** (from *The Art of Innovation*, Kelley and
  Littman). A quarterly review is not "a deck"; it is "getting busy people
  to believe a story about cause and effect, and to decide under
  uncertainty, in 30 minutes." Verbs reveal which fields can help.
- **Assemble the crew.** For production quality: analyst, journalist,
  editor; if presented, motion and audio designer; adversarial red team:
  short seller, forensic accountant.
- **Avoid role-play.** It makes the transcript weirder without improving
  the outcome. Use the crew to find fields and techniques. Do not ask the
  model to write like a short seller; ask it to do what a short seller does
  to research a position.
- Author's blind spot example: never considered 3D environments for his
  homepage until a colleague rendered interiors in Blender.

## Prerequisite

All three types need the model to have a computer where it can install
software and reach the relevant data (MCP connectors or otherwise).

## Why: self-efficacy

People are held back by what they believe possible, and trust themselves
only in narrow disciplines (Michelangelo refused the Sistine Chapel: "a
sculptor, not a painter"). Self-efficacy can be hacked:

- Locke and Latham, 35 years of goal-setting research: specific hard goals
  beat "do your best."
- Patrick Collison's "Fast" list: audacious goals plus tight deadlines.
- Believe it possible: George Dantzig, 1939, solved two open statistics
  problems thinking they were homework.
- Watch someone else do it: Bannister's four-minute mile stood alone for 46
  days; the first sub-two-hour marathon (Sabastian Sawe, London, April
  2026) saw the runner-up also break two hours.
- Permission to fail: *The Inner Game of Tennis* (trying too hard hurts);
  Linux announced as "just a hobby, won't be big and professional like gnu."
