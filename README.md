# Bette OS

A PM operating system built on Claude Code. Manages day-to-day operations — inbox triage, meeting prep, backlog prioritization, performance reviews, strategic synthesis — through natural language workflows.

## Philosophy

Don't over-structure. Capture raw context with minimal organization. Claude does the pattern matching, prioritization, and connection to strategic goals.

**Core patterns:**
- **Skills** — Claude Code workflows that auto-invoke from natural language or `/command`
- **Reference files** — persistent context loaded every session (people, domains, systems)
- **Context hygiene** — large reads delegated to sub-agents, main context stays clean
- **State tracking** — simple text files track what's been processed across sessions

## Prerequisites

- [Claude Code](https://claude.com/claude-code) installed
- MCP integrations connected (see `docs/MCP-INTEGRATIONS.md`)
- Optional: [Granola](https://granola.ai) for meeting transcripts, [Memorex](https://github.com/nicholasgasior/memorex) + [yt-dlp](https://github.com/yt-dlp/yt-dlp) for video analysis

## Quick Start

```bash
# Clone
git clone git@github.com:breethomas/bette-os.git ~/Work/my-os
cd ~/Work/my-os

# Run setup (symlinks skills, copies hooks, creates settings)
./setup.sh

# Fill in your config
# Edit os/CLAUDE.md — update the Config table with your name, paths, IDs

# Populate reference files
# Edit os/reference/people.md, domains.md, company.md

# Start using it
claude
# Try: "what should I focus on today" or "process my backlog"
```

## Skills

| Command | What it does | Type |
|---------|-------------|------|
| `/catchup` | Catch up on all inbound (email + Slack) | Orchestrator |
| `/email-inbox` | Triage Gmail inbox | Interactive |
| `/email-find` | Find a specific email | Interactive |
| `/slack-inbox` | Triage saved Slack items | Interactive |
| `/slack-find` | Find a specific Slack message | Interactive |
| `/slack-catchup [channel]` | Summarize missed Slack channel content | Forked |
| `/digest` | Process meeting transcripts into action items | Forked |
| `/backlog` | Process and prioritize backlog | Interactive |
| `/focus` | Surface today's top 3 priorities | Interactive |
| `/weekly-review` | Run weekly review | Interactive |
| `/prep-meeting [name]` | Prep talk track for a meeting | Forked |
| `/log-meeting [name]` | Log meeting notes to person file | Interactive |
| `/prep-review [name]` | Draft performance review | Forked |
| `/synthesize` | Strategic analysis of transcripts | Forked |
| `/coach-me` | Coaching notes on recent meetings | Forked |
| `/sync-transcripts` | Sync transcripts and run digest | Interactive |
| `/save-notion` | Save content to Notion | Interactive |
| `/pyramid` | Apply Pyramid Principle to communication | Interactive |
| `/analyze-video [url]` | Analyze video content | Forked |

**Forked** skills run in isolated sub-agents (heavy processing, writes to `os/drafts/`).
**Interactive** skills stay in main context for back-and-forth.
**Orchestrator** fans out to parallel sub-agents.

Optional skills in `skills/_optional/`: exec-update, monthly-report.

## Directory Structure

```
bette-os/
├── os/                    # The operating system
│   ├── CLAUDE.md          # Main config with Config table
│   ├── BACKLOG.md         # Brain dump inbox
│   ├── GOALS.md           # Quarterly goals
│   ├── reference/         # Persistent context (loaded every session)
│   ├── people/            # Person files for meeting prep
│   ├── transcripts/       # Meeting transcripts
│   ├── drafts/            # Working documents
│   └── sessions/          # Session notes
├── strategy/              # Optional strategic thinking module
├── skills/                # Claude Code skills (symlinked to ~/.claude/skills/)
├── hooks/                 # Context hygiene hooks
└── docs/                  # Documentation
```

## Customization

See `docs/CUSTOMIZING.md` for how to adapt for your business context.

## How It Works

Skills reference `{variables}` from the Config table in `os/CLAUDE.md`. Fill in the table once — your name, directory paths, Slack user ID, Notion page IDs — and all skills resolve automatically. Forked skills include a "Config Resolution" preamble that reads the Config table before executing.

Context hygiene hooks warn before reading large files or transcripts into main context. The rule: read for editing, delegate for reference. This keeps sessions clean and extends how long you can work before context degrades.

State tracking files (`.processed-inbox`, `.processed-saved`, `.processed`) record what's been actioned. Skills MUST update these before ending. This prevents re-processing across sessions.
