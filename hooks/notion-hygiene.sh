#!/bin/bash
# Context Hygiene Hook — PreToolUse on Notion fetch
# Warns Claude before fetching full Notion pages into main context.
# Notion pages vary in size but should default to sub-agent delegation.

cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "CONTEXT HYGIENE: Fetching a Notion page directly into main context. Notion pages can be very large. If reading for reference (not updating the page), consider delegating to a sub-agent with a specific extraction prompt (e.g., 'find the architecture decision about X on this Notion page'). Only fetch directly if you need to update the page content or the page is known to be small."
  }
}
EOF
exit 0
