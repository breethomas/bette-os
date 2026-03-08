# Skills Reference

## Core Skills (22)

### Communication & Inbox

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **catchup** | Orchestrator | "catch me up", "what did I miss", "morning catchup" |
| **email-inbox** | Interactive | "process my email", "email inbox", "check my email" |
| **email-find** | Interactive | "find the email about", "find the email from [name]" |
| **slack-inbox** | Interactive | "process my saved Slack items", "Slack inbox" |
| **slack-find** | Interactive | "find the Slack message about", "what did [name] say about" |
| **slack-catchup** | Forked | "catch me up on [channel]", "what did I miss in [channel]" |

### Planning & Prioritization

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **backlog** | Interactive | "process my backlog", "clean up my backlog" |
| **focus** | Interactive | "what should I focus on today", "what's my priority" |
| **weekly-review** | Interactive | "weekly review", "how did this week go" |

### People & Meetings

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **prep-meeting** | Forked | "prep for 1:1 with [name]", "prep my meeting with [name]" |
| **log-meeting** | Interactive | "log 1:1 with [name]", "capture notes from [name]" |
| **prep-review** | Forked | "prep [name]'s review", "performance review for [name]" |
| **remember-person** | Interactive | "remember that [name] is...", "add [name] to people" |
| **coach-me** | Forked | "coach me on my meetings", "give me feedback" |

### Transcripts & Synthesis

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **digest** | Forked | "daily digest", "process yesterday's meetings" |
| **synthesize** | Forked | "synthesize", "what decisions came out of", "analyze this transcript" |
| **sync-transcripts** | Interactive | "sync my transcripts", "process today's meetings" |
| **save-transcript** | Interactive | "save this transcript", "save transcript from [meeting]" |
| **analyze-video** | Forked | "analyze this video", "watch this video" |

### Communication Quality

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **pyramid** | Interactive | "structure this", "pyramid this", "make this executive-ready" |

### Integration

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **save-notion** | Interactive | "save to Notion", "put this in Notion" |

## Optional Skills (2)

Located in `skills/_optional/`. Install manually via symlink.

| Skill | Type | Trigger phrases |
|-------|------|----------------|
| **exec-update** | Interactive | "draft exec update", "weekly leadership update" |
| **monthly-report** | Interactive | "draft monthly report", "prep stakeholder update" |

## Skill Types

- **Interactive**: Stays in main context. Back-and-forth conversation with the user.
- **Forked**: Runs in an isolated sub-agent (`context: fork`). Writes output to `os/drafts/`. Main agent reads the file back to present results. Use for heavy processing (transcript reads, large searches).
- **Orchestrator**: Coordinates multiple sub-agents in parallel. Currently only `catchup`.

## Adding Custom Skills

See `docs/CUSTOMIZING.md` for instructions on creating and installing custom skills.
