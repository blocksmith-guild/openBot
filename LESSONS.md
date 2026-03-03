# LESSONS.md - The Cumulative History of Agent Learning

This document is the authoritative, chronological record of all technical, architectural, and philosophical lessons learned by the BlockSmith agents. It serves as a long-term memory to prevent the repetition of errors and ensure continuous skill evolution.

## 📜 Agentic Learned Lessons

### [Foundational Lessons]
- **Specificity > Generality**: "Be helpful" is useless. "Draft replies but never send without approval" actually changes behavior.
- **Boundaries > Personality**: What the agent WON'T do is more important for reliability than its "vibe."
- **Response Patterns as Strategic Assets**: Including real examples of good responses (with formatting) in `STYLE.md` significantly improves output quality.
- **Organic Growth**: Agents are grown, not just built. Optimization through real-world interaction and iterative prompt engineering is mandatory for utility.

### [2026-03-03]
- **Lesson: Non-Interactive Git Commits**
  - **Problem**: Attempting to run `git commit` without `-m` or `-F` in a non-interactive shell causes the process to hang or fail.
  - **Solution**: Always use `-m` for short messages or `-F` with a pre-written commit message file (e.g., `commit-XXXXXXX.txt`).
- **Lesson: Comprehensive Research Phase**
  - **Problem**: Making commits without checking the full context leads to inaccurate or incomplete messages.
  - **Solution**: Always run `git status`, `git diff`, and `git log` before drafting a commit message to ensure alignment with project history and current state.
- **Lesson: Brand Voice Consolidation**
  - **Problem**: Scattered documentation leads to inconsistent agent "personality" and communication.
  - **Solution**: Consolidate brand guidelines into a single authoritative file (`BRAND_VOICE.md`) and enforce its use via `STYLE.md`.
- **Lesson: Verification of Success**
  - **Problem**: Assuming a command worked just because it didn't return an error code is risky.
  - **Solution**: Always verify the state of the system (e.g., `git status`, `ls`, `cat`) immediately after a modifying command to confirm the outcome.
- **Lesson: Symbolic Link Resolution**
  - **Problem**: Softlinks are used extensively in the workspace; using relative paths or raw folder names can lead to errors.
  - **Solution**: Always use `readlink -f` to resolve absolute paths for directories and files.
- **Lesson: Backup and Versioning (rename -c)**
  - **Problem**: Overwriting files without a backup makes recovery difficult if a replacement fails.
  - **Solution**: Always use `rename -c` to create a versioned backup before performing a `write_file` or `replace` operation on existing files.

---
*"Mistakes are the seeds of evolution, but repetition is the death of progress."*
