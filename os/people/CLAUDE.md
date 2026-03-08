# People Directory - Team Management System

This directory contains one file per person you work with closely. Each file is the single source of truth for that person: background, coaching notes, development areas, meeting notes, and performance tracking.

---

## File Structure

Each person file has these sections:

- **Header**: Role, first meeting date
- **Background**: Context on their history, experience
- **Current Work**: What they're focused on
- **How They're Feeling**: Energy, frustrations, engagement level
- **What They Want**: Career aspirations, preferences
- **Strengths**: What they do well
- **Development Areas**: Where they need to grow
- **1:1 Topics (Next Meeting)**: Checklist for upcoming conversation
- **Wins & Accomplishments**: For performance reviews
- **1:1 Notes**: Running log, newest first

---

## Workflows

### "Log meeting with [name]"

After a meeting, append notes to the person's file:

1. Read the person's file
2. Add a new entry under `## 1:1 Notes` with today's date
3. Capture: key topics discussed, commitments made, follow-ups needed
4. Update `## 1:1 Topics (Next Meeting)` - check off completed items, add new ones
5. If there's a win or accomplishment mentioned, add it to `## Wins & Accomplishments`
6. If something needs escalation, note it and surface in backlog

**Format for notes:**
```markdown
### YYYY-MM-DD
- Topic 1
- Topic 2
- Commitment: [person] will do X by [date]
- Follow-up: [PM Name] to check on Y
```

### "Prep [name]'s review"

When preparing a performance review:

1. Read the person's file completely
2. Query Linear for their shipped work in the review period
3. Query Notion meeting notes for context on their projects
4. Synthesize into:
   - **Key Accomplishments**: What they shipped, impact, growth
   - **Strengths Demonstrated**: Evidence from notes and work
   - **Development Progress**: What improved since last review
   - **Areas for Growth**: What to focus on next
   - **Overall Assessment**: Trajectory (upward, steady, concerning)
5. Flag any gaps - things that should have been documented but weren't
6. Output a draft that matches whatever review template your company uses

### "Surface to backlog"

Some things in people files should bubble up to the operating system:

- **Escalate**: Performance issues, exit decisions, headcount asks
- **Add to backlog**: Coaching decisions to make, conversations to have
- **Meeting prep**: The prep-meeting workflow reads from here

When processing, check: Does anything here need attention outside the regular meeting cadence?

---

## Principles

**One file per person.** All context in one place. Let Claude pattern match.

**Append, don't reorganize.** Notes are a running log. Don't clean up or restructure — the history is valuable.

**Capture wins as they happen.** Don't wait for review time. When someone ships something or demonstrates growth, add it immediately.

**Be direct.** These are private coaching notes. Capture honest assessments.

**Connect to outcomes.** When logging wins, tie to business impact where possible.
