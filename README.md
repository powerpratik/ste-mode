# ste-mode

A writing mode for Claude Code. It makes Claude write in a **Simplified Technical English style**:
short active sentences, plain words, one meaning per word. Replies are easier to read, to translate, and to
listen to with a text-to-speech voice.

> **Not official.** This is a style guide inspired by Simplified Technical English. It is **not** the ASD-STE100
> specification, it has no approved-word dictionary, and its output is **not certified**. This project is not
> affiliated with or endorsed by ASD. The official specification is at [asd-ste100.org](https://www.asd-ste100.org/).

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
