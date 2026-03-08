# Bette — PM Operating System

Your operating system. Claude reads this context to help manage day-to-day operations while driving strategy.

---

## Config

Claude resolves these values when executing skills. Update the paths and IDs for your local setup.

| Key | Value | Notes |
|-----|-------|-------|
| `{PM Name}` | `[Your Name]` | Used in coaching, digest, and meeting prep |
| `{PM Role}` | `[Your Title]` | e.g., "VP Product at Acme Corp" |
| `{Home Directory}` | `[/absolute/path/to/os/]` | Where BACKLOG.md, GOALS.md, reference/, people/, etc. live |
| `{Strategy Directory}` | `[/absolute/path/to/strategy/]` | Where your strategic framework doc lives |
| `{Strategy Framework}` | `[Name of your strategy doc]` | e.g., "how-acme-grows.md" — referenced by skills |
| `{People Directory}` | `[/absolute/path/to/os/people/]` | Where person files live |
| `{Slack User ID}` | `[Your Slack user ID]` | Find at: your Slack profile > three dots > Copy member ID |
| `{Notion Default Parent Page}` | `[Notion page ID]` | Where Claude saves Notion pages. Pick any page you want as your default. |
| `{Notion WIP Page}` | `[Notion page ID]` | Optional — a second save destination if you say "save to WIP" |
| `{Notion Meeting Notes DB}` | `[collection://UUID]` | Meeting notes database data source URL (optional) |
| `{Transcript Backup Script}` | `[/path/to/backup/script]` | Script that syncs meeting transcripts (optional) |
| `{Transcript Directory}` | `[/absolute/path/to/transcripts/]` | Where meeting transcripts land |

---

## Core Principle

Don't over-structure. Capture raw context with minimal organization. Claude does the pattern matching, prioritization, and connection to strategic goals.

---

## Context to Load

**Always read:**
- `BACKLOG.md` — the inbox
- `GOALS.md` — what matters this quarter
- `reference/people.md` — who's who (roles, relationships, disambiguation)
- `reference/domains.md` — product domains, acronyms, architecture layers
- `reference/company.md` — technical systems, meeting cadences, methodology, compliance

**Read for strategic context:**
- `{Strategy Directory}/initiatives/{Strategy Framework}` — the strategic framework

**Query on demand:**
- Notion (via MCP) — meeting notes, company context
- Linear (via MCP) — what's shipping, cycle work, team capacity

---

## Skills

Workflows auto-invoke from natural language or via `/command`.

| Command | What it does |
|---------|-------------|
| `/catchup` | Catch up on all inbound — orchestrates email + Slack in one pass |
| `/email-inbox` | Process Gmail inbox — starred/unread, triage, draft replies, add to backlog |
| `/email-find` | Find a specific email by person, topic, or date |
| `/slack-inbox` | Process saved Slack items — triage, draft responses, add to backlog |
| `/slack-find` | Find a specific Slack message by person, topic, or date |
| `/slack-catchup [channel]` | Summarize what was missed in team/project channels |
| `/digest` | Process daily meeting digest from transcripts |
| `/backlog` | Process and prioritize backlog items |
| `/focus` | Surface today's top 3 priorities |
| `/weekly-review` | Run weekly review |
| `/prep-meeting [name]` | Prep talk track for a meeting with someone |
| `/log-meeting [name]` | Log meeting notes to person file |
| `/prep-review [name]` | Prep performance review draft for a direct report |
| `/synthesize` | Strategic analysis of transcripts |
| `/coach-me` | Coaching notes on recent meetings |
| `/sync-transcripts` | Sync transcripts and run digest |
| `/save-notion` | Save session content to Notion |
| `/pyramid` | Apply Pyramid Principle to any communication |
| `/analyze-video [url]` | Analyze video content (optional — requires Memorex + yt-dlp) |

Heavy workflows (`digest`, `prep-meeting`, `prep-review`, `coach-me`, `synthesize`, `slack-catchup`, `analyze-video`) fork to an isolated sub-agent to keep the main context clean. `/catchup` is an orchestrator — fans out email and Slack processing to parallel sub-agents.

### Transcript Routing Rules

- **Use `/sync-transcripts`** when asking about meetings from TODAY (runs backup first)
- **Use `/digest`** when asking about meetings from previous days (assumes transcripts exist)

---

## Context Hygiene

Main context is precious. Large reads bloat context and degrade session quality.

**Rule:** Read for editing, delegate for reference.

- **Transcripts:** Never read raw into main context. Delegate to a sub-agent with a specific extraction prompt.
- **Notion pages:** Default to delegating. Only fetch directly if updating the page or the page is known to be small.
- **Large files (> ~200 lines):** If referencing (not editing), delegate to a sub-agent for targeted summary.

**General test:** Before reading a file, ask: "Am I reading this to edit it, or to reference it?" If reference → delegate with an extraction prompt.

**Exceptions:** Sub-agents doing targeted extraction, explicit user request, files being edited line-by-line, small files (< ~200 lines).

---

## Directories

- `reference/` — persistent context files loaded every session
  - people.md — roles, relationships, name disambiguation
  - domains.md — product domains, acronyms, PM owners, architecture
  - company.md — technical systems, meetings, methodology, compliance
- `people/` — person files for meeting prep and 1:1 tracking
- `transcripts/` — meeting transcripts
- `sessions/` — session notes (YYYY-MM-DD-description.md)
- `drafts/` — working documents in progress
- `email/` — email tracking (.processed-inbox)
- `slack/` — Slack tracking (.processed-saved)

---

## Session Management

Each Claude session starts fresh. Files are the persistent memory.

- Don't rely on chat history across sessions
- Update files during the session so context persists
- If a session runs long (2-3 major tasks), suggest saving state and restarting
- **Persist state before ending workflows:** Any workflow that processes inputs (transcripts, meetings, backlog items) MUST update the relevant tracking file before the workflow ends.
- **Maintain reference files:** When daily digest or transcript processing surfaces new people, terms, or systems not in `reference/` files, flag them and suggest adding.

---

## Known Limitations

**Date calculations:** Claude is prone to off-by-one errors with calendar math. When calculating specific dates, anchor to a known date and step through day by day. Don't guess — show the work.

---

## The Filter

When asked about priorities, always filter through your strategic framework. Customize these questions to match your strategy:

1. Does this advance our primary strategic objective?
2. Does this strengthen a core growth loop?
3. Does this protect current revenue or stability?
4. Does this build the team or capabilities we need?

If none of the above: ask why this is being done.

_Customize this section by replacing the questions above with your own strategic filter. The filter should reflect whatever framework you define in `{Strategy Directory}/initiatives/{Strategy Framework}`._
