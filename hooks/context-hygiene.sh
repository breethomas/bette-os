#!/bin/bash
# Context Hygiene Hook — PreToolUse on Read
# Warns Claude before reading large files, transcripts, or PDFs into main context.
# These should be delegated to sub-agents with specific extraction prompts.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Exit silently if no file path
[[ -z "$FILE_PATH" ]] && exit 0

# --- Rule 1: Transcripts — always warn ---
if [[ "$FILE_PATH" == *"/transcripts/"* && "$FILE_PATH" == *.md ]]; then
  cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "CONTEXT HYGIENE: This is a meeting transcript. Do NOT read into main context — delegate to a sub-agent (Task tool) with a specific extraction prompt. Example: 'extract pricing discussion and action items from this transcript'. See BETTE/CLAUDE.md Context Hygiene rules."
  }
}
EOF
  exit 0
fi

# --- Rule 2: PDFs — always warn ---
if [[ "$FILE_PATH" == *.pdf || "$FILE_PATH" == *.PDF ]]; then
  cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "CONTEXT HYGIENE: This is a PDF. Do NOT read into main context — delegate to a sub-agent (Task tool) with a specific extraction prompt. Example: 'extract the key findings and recommendations from this PDF'. See BETTE/CLAUDE.md Context Hygiene rules."
  }
}
EOF
  exit 0
fi

# --- Rule 3: Large files — warn ---
if [[ -f "$FILE_PATH" ]]; then
  LINE_COUNT=$(wc -l < "$FILE_PATH" 2>/dev/null || echo "0")
  LINE_COUNT=$(echo "$LINE_COUNT" | tr -d ' ')

  if [[ "$LINE_COUNT" -gt 200 ]]; then
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "CONTEXT HYGIENE: This file is ${LINE_COUNT} lines. If reading for reference (not editing), delegate to a sub-agent with a specific extraction prompt. See BETTE/CLAUDE.md Context Hygiene rules."
  }
}
EOF
    exit 0
  fi
fi

# --- Default: allow silently ---
exit 0
