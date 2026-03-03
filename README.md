OpenClaw uses four core system files—**SOUL.md**, **TOOLS.md**, **USER.md**, and **AGENTS.md**—to define an AI agent's identity, capabilities, user context, and operational rules in a dedicated workspace (typically `~/.openclaw/workspace`). These Markdown files form the agent's "brain," loaded at session start for persistence across interactions. [docs.openclaw](https://docs.openclaw.ai/reference/AGENTS.default)

## File Purposes
- **SOUL.md**: Defines the agent's core identity, personality, values, tone, and boundaries (e.g., "You are a helpful architect CEO orchestrating software pipelines"). [openclawlab](https://openclawlab.com/en/docs/reference/templates/soul.architect/)
- **TOOLS.md**: Lists available tools, skills, integrations, and usage notes (e.g., custom CLI commands or APIs; distinguishes tools from research). [docs.openclaw](https://docs.openclaw.ai/reference/AGENTS.default)
- **USER.md**: Profiles the human user (e.g., name, timezone, preferences, work context like cybersecurity expertise) to personalize responses. [amankhan1.substack](https://amankhan1.substack.com/p/how-to-make-your-openclaw-agent-useful)
- **AGENTS.md**: Outlines operational workflows, memory management (e.g., read daily logs like `memory/YYYY-MM-DD.md`), session startup routines, and safety rules. [dev](https://dev.to/aws-builders/mastering-openclaw-on-aws-fine-tuning-personality-memory-and-soul-37ig)

## Setup Template
Create the workspace and copy defaults:
```
mkdir -p ~/.openclaw/workspace
cp /path/to/openclaw/docs/reference/templates/*.md ~/.openclaw/workspace/
```
Edit them in any text editor. Example minimal **SOUL.md** starter: [openclawlab](https://openclawlab.com/en/docs/reference/templates/soul.architect/)
```
# SOUL.md - Your Agent Name
You are [Agent Role]. Objective: [Core Goal].
Boundaries: Never [list prohibitions].
Tone: [e.g., concise, technical].
```
For **AGENTS.md**, start sessions by reading: `SOUL.md`, `USER.md`, recent memory. Back them with Git: `cd ~/.openclaw/workspace && git init`. [dev](https://dev.to/aws-builders/mastering-openclaw-on-aws-fine-tuning-personality-memory-and-soul-37ig)

## GitHub Repos
- Official templates: OpenClaw docs at `docs/reference/templates/`. [docs.openclaw](https://docs.openclaw.ai/reference/AGENTS.default)
- Community: `mergisi/awesome-openclaw-agents` (curated SOUL.md for productivity/dev); official `openclaw/openclaw` repo has examples; free templates discussion `openclaw/openclaw#17022`. Search GitHub for "openclaw SOUL.md template" for more. [github](https://github.com/mergisi/awesome-openclaw-agents/blob/main/README.md)
