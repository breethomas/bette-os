#!/bin/bash
# Bette OS — Setup Script
# Creates symlinks for skills, copies hooks, and prints next steps.

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$REPO_DIR/skills"
HOOKS_DIR="$REPO_DIR/hooks"
CLAUDE_SKILLS="$HOME/.claude/skills"
PROJECT_HOOKS="$REPO_DIR/.claude/hooks"

echo ""
echo "=== Bette OS Setup ==="
echo ""
echo "Repo: $REPO_DIR"
echo ""

# --- Skills ---
echo "--- Setting up skills ---"
mkdir -p "$CLAUDE_SKILLS"

LINKED=0
SKIPPED=0

for skill_dir in "$SKILLS_DIR"/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name="$(basename "$skill_dir")"

  # Skip _optional directory — user installs those manually
  [ "$skill_name" = "_optional" ] && continue

  target="$CLAUDE_SKILLS/$skill_name"

  if [ -L "$target" ]; then
    # Already a symlink — check if it points to us
    current="$(readlink "$target")"
    if [ "$current" = "$skill_dir" ]; then
      SKIPPED=$((SKIPPED + 1))
      continue
    else
      echo "  WARNING: $skill_name -> $current (points elsewhere, skipping)"
      SKIPPED=$((SKIPPED + 1))
      continue
    fi
  elif [ -d "$target" ]; then
    echo "  WARNING: $skill_name already exists as a directory (skipping)"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  ln -s "$skill_dir" "$target"
  LINKED=$((LINKED + 1))
  echo "  Linked: $skill_name"
done

echo "  $LINKED linked, $SKIPPED skipped"
echo ""

# --- Optional skills ---
echo "--- Optional skills available ---"
for skill_dir in "$SKILLS_DIR"/_optional/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name="$(basename "$skill_dir")"
  echo "  $skill_name (install with: ln -s $skill_dir $CLAUDE_SKILLS/$skill_name)"
done
echo ""

# --- Hooks ---
echo "--- Setting up hooks ---"
mkdir -p "$PROJECT_HOOKS"

for hook_file in "$HOOKS_DIR"/*.sh; do
  [ -f "$hook_file" ] || continue
  hook_name="$(basename "$hook_file")"
  cp "$hook_file" "$PROJECT_HOOKS/$hook_name"
  chmod +x "$PROJECT_HOOKS/$hook_name"
  echo "  Copied: $hook_name"
done
echo ""

# --- Settings template ---
SETTINGS_FILE="$REPO_DIR/.claude/settings.local.json"
if [ ! -f "$SETTINGS_FILE" ]; then
  echo "--- Creating settings.local.json ---"
  cat > "$SETTINGS_FILE" << 'SETTINGS'
{
  "permissions": {
    "allow": [
      "WebSearch"
    ]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/context-hygiene.sh"
          }
        ]
      },
      {
        "matcher": "mcp__.*notion.*fetch",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/notion-hygiene.sh"
          }
        ]
      }
    ]
  }
}
SETTINGS
  echo "  Created .claude/settings.local.json"
else
  echo "--- settings.local.json already exists (skipping) ---"
fi
echo ""

# --- Next steps ---
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo ""
echo "  1. Fill in the Config table in os/CLAUDE.md"
echo "     - Set your name, role, directory paths, Slack user ID, Notion page IDs"
echo ""
echo "  2. Populate your reference files:"
echo "     - os/reference/people.md   — who's who at your company"
echo "     - os/reference/domains.md  — your product domains and acronyms"
echo "     - os/reference/company.md  — your technical systems and meeting cadences"
echo ""
echo "  3. (Optional) Write your strategic framework:"
echo "     - Copy strategy/initiatives/_strategy-template.md"
echo "     - Rename to match your {Strategy Framework} config value"
echo ""
echo "  4. (Optional) Install optional skills:"
echo "     - See skills/_optional/ for templates"
echo ""
echo "  5. Connect MCP integrations:"
echo "     - See docs/MCP-INTEGRATIONS.md for which servers to connect"
echo ""
echo "  6. Start using it:"
echo "     - cd $(pwd) && claude"
echo "     - Try: 'what should I focus on today' or 'process my backlog'"
echo ""
