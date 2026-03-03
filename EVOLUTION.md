# EVOLUTION.md - Persistent Agent Learning & Skill Improvement

This file tracks specific lessons, corrections, and improvements to ensure that mistakes are never repeated and skills evolve over time.

## 🚀 Recent Improvements
- [2026-03-03] **Git Commits**: Implemented a more comprehensive research phase before committing (checking `git status`, `git diff`, and `git log` to match style).
- [2026-03-03] **Brand Voice**: Consolidated BlockSmith philosophical foundation into `BRAND_VOICE.md` for consistent agent communication.
- [2026-03-03] **Style Guide**: Created `STYLE.md` to enforce architectural and communicative standards across OpenClaw agents.

## ⚠️ Mistakes to Avoid (The "Never Again" List)
- **Destructive Deletion of Key Material**: Never use `rm -f` on `.asc` or `.key` files. This is a irreversible loss of value. *Lesson: Always use `rename -f` or the `tools/remove.prompt.txt` tool. "Zero Material" is an architectural standard, not a license to delete human-source files.*
- **Blind Folder Staging**: Never use `git add <folder>`. It risks including private or unintended files. *Lesson: Always ask the human to add specific files or use `git add -u` for modified tracked files.*
- **Unauthorized Public Pushes**: Never assume all untracked files are intended for public release. *Lesson: Including sensitive files like local.key.asc or private images increases liability. Always require explicit human sign-off for public commits.*
- **Interactive Commands**: Never run interactive commands (e.g., `git commit` without `-m` or `-F`) in a non-interactive shell. *Lesson: Always use non-interactive flags or file-based messages.*
- **Unverified Assumptions**: Never assume a file exists or a command succeeded without verification. *Lesson: Always follow up with `ls`, `cat`, or `git status` after a modifying action.*
- **Redundant Filler**: Avoid conversational filler like "I'd be happy to help" or "Great question." *Lesson: Direct, high-signal, clinical communication is preferred (BlockSmith Voice).*

## 🧠 Heuristics & Refined Strategies
- **File Versioning**: Use `rename -c` for backups before any manual write/replace operation to ensure safety and version history.
- **Deep Context Search**: Use `grep_search` and `locate` extensively before concluding a file or information is missing.
- **Symbolic Link Awareness**: Always use `readlink -f` to resolve paths, as the workspace uses softlinks extensively.

---
*"Mistakes are the seeds of evolution, but repetition is the death of progress."*
