# Customizing Bette OS

## Step 1: Config Table

Edit `os/CLAUDE.md` and fill in every row of the Config table. Skills reference these values as `{variables}`.

| Key | What to put |
|-----|-------------|
| `{PM Name}` | Your name as you want Claude to use it |
| `{PM Role}` | Your title and company, e.g., "VP Product at Acme Corp" |
| `{Home Directory}` | Absolute path to the `os/` directory |
| `{Strategy Directory}` | Absolute path to the `strategy/` directory |
| `{Strategy Framework}` | Filename of your strategy doc (e.g., `how-acme-grows.md`) |
| `{People Directory}` | Absolute path to `os/people/` |
| `{Slack User ID}` | Your Slack member ID (profile > three dots > Copy member ID) |
| `{Notion Default Parent Page}` | Notion page ID for default saves |
| `{Notion WIP Page}` | Optional second save destination |
| `{Notion Meeting Notes DB}` | Optional meeting notes database ID |
| `{Transcript Backup Script}` | Path to your transcript sync script (optional) |
| `{Transcript Directory}` | Absolute path to `os/transcripts/` |

## Step 2: Reference Files

### people.md
One line per person. Structure is already in place — just fill it in.

Tips:
- Start with the 10-15 people you interact with most
- Include role and one sentence of context
- Add disambiguation notes for shared first names
- Update as you encounter new people (Claude will suggest additions)

### domains.md
Your product domains, acronyms, and architecture layers.

Tips:
- Copy your org's domain map if one exists
- Add every acronym your team uses — Claude can't guess these
- Include key customers if they affect product decisions

### company.md
Technical systems, methodology, meeting cadences, and compliance.

Tips:
- List internal system names and what they do (one line each)
- Document your development methodology (Scrum, Shape Up, etc.)
- List recurring meetings with frequency and purpose
- Add regulatory constraints if you work in a regulated industry

## Step 3: Strategic Framework (Optional)

Copy `strategy/initiatives/_strategy-template.md`, rename it to match your `{Strategy Framework}` config value, and fill it in.

The template provides a structure (value props, growth loops, prioritization filter, execution model) but the content is yours. Skills that reference the strategic framework will use whatever you write here.

If you skip this step, skills degrade gracefully — they'll note the framework wasn't found and proceed without strategic mapping.

## Step 4: The Filter

Customize the Filter section in both `os/CLAUDE.md` and `os/GOALS.md`. The default questions are generic:

1. Does this advance our primary strategic objective?
2. Does this strengthen a core growth loop?
3. Does this protect current revenue or stability?
4. Does this build the team or capabilities we need?

Replace these with questions that match your strategy. The Filter is how Claude prioritizes when you ask "what should I focus on?" or "should I do this?"

## Step 5: People Files

For each direct report or close collaborator, copy `os/people/_template.md` and rename it to `[firstname].md` (lowercase). Fill in what you know — the file grows over time as you log meetings and capture coaching notes.

## Step 6: Custom Skills

To add your own skills:

1. Create a directory under `skills/` with a `SKILL.md` file
2. Use YAML frontmatter: `name`, `description`, optional `context: fork` and `model: sonnet`
3. Reference `{variables}` from the Config table
4. For forked skills, include the Config Resolution preamble (copy from any existing forked skill)
5. Run `./setup.sh` to symlink the new skill

To install optional skills:
```bash
ln -s $(pwd)/skills/_optional/exec-update ~/.claude/skills/exec-update
```
