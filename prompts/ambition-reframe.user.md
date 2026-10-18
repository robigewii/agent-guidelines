# Ambition reframe: user-side prompts

For chat interfaces where you cannot set a system prompt, or for a single
conversation where you want the raise just once. Two forms.

## 1. Prefix for a request

Paste this above your normal request. Nothing else about how you write
changes.

```text
Before you do the task below: say in one line what it is for; say what a
top practitioner would do here that I am not asking for, the rawest source
they would start from, and the actual instruments they would use; name what,
other than you or me, would show the result is right. Then do the task that
way. If a bigger version would change the deliverable or need access I have
not given you, do the literal task first and describe the bigger version in
two or three lines at the end.

Task:
```

## 2. Prompt rewrite

When you have a prompt and want a better one. This is the author's own
template, verbatim.

```text
I want a deeper version of this task, not a bigger one. Before rewriting
it: (1) say what a top professional in this field would do here that I'm
not asking for; (2) name the rawest material they would start from instead
of what has already been digested for me; (3) name the specific methods and
tools they would use; (4) say what, other than you or me, would show the
result is right. Then rewrite my prompt to ask for exactly that.
```

## Moves to keep in your own head

- A review is not "a deck". Replace the noun with the verb and the right
  fields show themselves.
- Ask for 200ms when you need 5s. Tell the model it is reasonable.
- "We believe churn is an onboarding problem. Try to reproduce that from the
  raw data." Give raw data and ask for adversarial checks.
- Assemble the crew (analyst, editor, short seller, forensic accountant) to
  find methods. Do not ask the model to write like them.
- Do not let the model grade itself. Give it a tool it can run.

Source: Felix Rieseberg, "How to be more ambitious: A tutorial for humans
with models" (October 2026),
https://felixrieseberg.com/how-to-be-more-ambitious-a-tutorial-for-humans-with-models/
