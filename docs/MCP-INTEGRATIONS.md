# MCP Integrations

Bette OS uses MCP (Model Context Protocol) servers to connect Claude Code to external services. Skills gracefully handle missing integrations — they'll report what's unavailable and proceed with what works.

## Required for Core Workflows

None. Bette OS works without any MCP integrations — backlog, focus, weekly-review, pyramid, and file-based workflows all run locally.

## Recommended

### Slack MCP
**Used by:** catchup, slack-inbox, slack-find, slack-catchup

Connect via Claude Code's built-in Slack integration or a third-party Slack MCP server.

**Key tools used:**
- `slack_search_public_and_private` — always use `detailed` format (concise crashes)
- `slack_read_thread` — for thread context
- `slack_send_message_draft` — drafts only, never sends directly
- `slack_search_channels`, `slack_search_users` — for channel/user lookup

**Config needed:** `{Slack User ID}` in the Config table.

### Gmail MCP
**Used by:** catchup, email-inbox, email-find

Connect via Claude Code's built-in Gmail integration.

**Key tools used:**
- `gmail_search_messages` — inbox triage searches
- `gmail_read_thread` — thread context
- `gmail_create_draft` — drafts only, never sends directly
- `gmail_get_profile` — account verification

### Notion MCP
**Used by:** save-notion, prep-meeting, prep-review

Connect via Claude Code's built-in Notion integration or the official Notion MCP server.

**Key tools used:**
- `notion-search` — finding pages and databases
- `notion-fetch` — reading page content
- `notion-create-pages` — creating new pages
- `notion-update-page` — updating existing pages

**Config needed:** `{Notion Default Parent Page}`, optionally `{Notion WIP Page}` and `{Notion Meeting Notes DB}`.

### Linear MCP
**Used by:** prep-review (shipped work queries)

Connect via a Linear MCP server.

**Key tools used:**
- `list_issues` — searching for shipped work by person
- `get_issue` — reading issue details

## Optional

### Google Calendar MCP
**Used by:** digest (calendar enrichment for transcripts)

Enriches transcript processing with attendee lists and meeting context. If unavailable, digest falls back to transcript-only detection.

### Granola MCP
**Used by:** sync-transcripts

Direct access to Granola meeting data. Alternative to file-based transcript backup.

## Setup

MCP servers are configured in Claude Code settings. Each integration requires authentication — follow the setup flow for each server when you first connect.

After connecting, add relevant tool permissions to `.claude/settings.local.json` under `permissions.allow` so Claude can use them without prompting each time.
