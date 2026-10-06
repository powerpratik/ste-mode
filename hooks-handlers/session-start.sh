#!/usr/bin/env bash
# Print the STE rules as session context, unless the person turned the mode off.
# The off switch is the file ~/.claude/ste-mode.off, which /ste off creates.

ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
OFF="${HOME}/.claude/ste-mode.off"

[ -f "$OFF" ] && exit 0
[ -f "$ROOT/rules/ste.md" ] || exit 0

text=$(cat "$ROOT/rules/ste.md")
# escape for a JSON string: backslash, quote, newline, tab
text=${text//\\/\\\\}
text=${text//\"/\\\"}
text=${text//$'\n'/\\n}
text=${text//$'\t'/\\t}

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$text"
exit 0
