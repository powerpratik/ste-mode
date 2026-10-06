---
description: Turn STE mode on or off, or show its state
argument-hint: "[on|off|status]"
allowed-tools: Bash(rm -f ~/.claude/ste-mode.off), Bash(mkdir -p ~/.claude), Bash(touch ~/.claude/ste-mode.off), Bash(test -f ~/.claude/ste-mode.off), Bash(cat ${CLAUDE_PLUGIN_ROOT}/rules/ste.md)
---

The argument is: $ARGUMENTS

Do exactly one of these, then answer in one short sentence.

- **on**: run `rm -f ~/.claude/ste-mode.off`. Then run `cat ${CLAUDE_PLUGIN_ROOT}/rules/ste.md` and follow those rules in every reply from now on. Say that STE mode is on for this session and for new sessions.
- **off**: run `mkdir -p ~/.claude` and then `touch ~/.claude/ste-mode.off`. Stop following the STE rules in your replies from now on. Say that STE mode is off.
- **status**, or no argument: run `test -f ~/.claude/ste-mode.off`. If the file exists, say that STE mode is off for new sessions. If it does not exist, say that STE mode is on for new sessions.

Any other argument: say that the choices are on, off and status.
