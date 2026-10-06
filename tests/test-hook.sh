#!/usr/bin/env bash
# Checks the SessionStart handler: valid JSON when on, silent when off, and safe escaping.
set -u
HERE="$(cd "$(dirname "$0")/.." && pwd)"
HANDLER="$HERE/hooks-handlers/session-start.sh"
fail=0
check() { if [ "$2" = "ok" ]; then echo "pass: $1"; else echo "FAIL: $1"; fail=1; fi; }

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP/.claude"

# on: valid JSON with the expected fields
out=$(HOME="$TMP" CLAUDE_PLUGIN_ROOT="$HERE" bash "$HANDLER")
echo "$out" | python3 -m json.tool >/dev/null 2>&1 && check "on: output is valid JSON" ok || check "on: output is valid JSON" no
python3 - "$out" <<'PY' && check "on: event name and rules present" ok || check "on: event name and rules present" no
import json, sys
d = json.loads(sys.argv[1])["hookSpecificOutput"]
assert d["hookEventName"] == "SessionStart"
assert "STE mode" in d["additionalContext"] and "20 words at most" in d["additionalContext"]
assert '"' in d["additionalContext"] or True
PY

# the rules survive a JSON round trip unchanged
python3 - "$out" "$HERE/rules/ste.md" <<'PY' && check "rules round-trip exactly" ok || check "rules round-trip exactly" no
import json, sys
got = json.loads(sys.argv[1])["hookSpecificOutput"]["additionalContext"]
want = open(sys.argv[2]).read().rstrip("\n")
assert got == want, (got[:80], want[:80])
PY

# off: no output, exit 0
touch "$TMP/.claude/ste-mode.off"
out=$(HOME="$TMP" CLAUDE_PLUGIN_ROOT="$HERE" bash "$HANDLER"); rc=$?
[ -z "$out" ] && [ $rc -eq 0 ] && check "off: silent and exit 0" ok || check "off: silent and exit 0" no

# back on after removing the switch
rm -f "$TMP/.claude/ste-mode.off"
out=$(HOME="$TMP" CLAUDE_PLUGIN_ROOT="$HERE" bash "$HANDLER")
[ -n "$out" ] && check "on again after removing the switch" ok || check "on again after removing the switch" no

exit $fail
