# ste-mode

A writing mode for Claude Code. It makes Claude write in a **Simplified Technical English style**:
short active sentences, plain words, one meaning per word. Replies are easier to read, to translate, and to
listen to with a text-to-speech voice.

> **Not official.** This is a style guide inspired by Simplified Technical English. It is **not** the ASD-STE100
> specification, it has no approved-word dictionary, and its output is **not certified**. This project is not
> affiliated with or endorsed by ASD. The official specification is at [asd-ste100.org](https://www.asd-ste100.org/).

## Background

In October 2026, Andrej Karpathy wrote on X that we will spend more time trying to understand the outputs of
language models. His first tip was about writing:

> Something I've had success with: Ask your LLM to explain something in ASD-STE100, it's a controlled language
> specification originally developed for aerospace maintenance documentation. LLMs well-versed in this language
> and it comes with heavy constraints on clean writing style that I often find a lot more readable. Sometimes
> I've tried to soften it a bit e.g. ask for "80% of the way to ASD-STE100" because the spec is quite stringent.
>
> (Andrej Karpathy, post on X, October 2026. Excerpt.)

`ste-mode` turns that habit into a switch you can leave on. It is in the spirit of his softer request: it keeps the
short active sentences and plain words, and it leaves out the approved-word dictionary and most of the full rule
set. It does not measure how close a reply is to the specification. Karpathy did not write, review or endorse
this plugin.

## Install

```
/plugin install ste-mode --marketplace powerpratik/ste-mode
```

Answer `y` to "Add marketplace?" and press Enter on the user scope. The mode is active in new sessions.

## Use

| Command | Effect |
| --- | --- |
| `/ste` or `/ste status` | Show whether the mode is on |
| `/ste on` | Turn it on now, and for new sessions |
| `/ste off` | Turn it off for this session and new sessions |

The mode is **on by default** after install. `/ste off` creates the file `~/.claude/ste-mode.off`; `/ste on`
removes it.

## What it changes

A `SessionStart` hook adds the rules in [`rules/ste.md`](rules/ste.md) to each new session, the same way Anthropic's
own style plugins work. The rules ask for:

- sentences of 20 words or fewer for instructions, 25 for descriptions, one idea each
- the active voice, commands for instructions, and only the simple tenses
- articles (the, a, an) and no contractions
- plain words with one meaning, used the same way every time; no idioms, slang or phrasal verbs
- prose only: code, commands, paths, URLs and error messages stay exactly as they are

You can edit `rules/ste.md` to fit your own needs.

## Check

```
bash tests/test-hook.sh
claude plugin validate .
```

## License

MIT. See [LICENSE](LICENSE).
