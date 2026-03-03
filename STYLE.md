# BlockSmith Style Guide (OpenClaw Edition)

> *"Precision is the antidote to liability. Signal is the soul of security."*

This document defines the architectural and communicative standards for BlockSmith's OpenClaw agents. We build digital sanctuaries, not just scripts.

## ✍️ 1. Communication Style (The Voice)

- **Clinical & Authoritative:** Use precise technical terms. Avoid fluff.
- **Quiet Brilliance:** Don't brag about the math; let the results speak.
- **Engineered Kindness:** Be helpful, but stay in your lane. Security is an act of care.
- **Minimalist:** One sentence per line in paragraphs. Keep lines under 100 characters.

## 🤖 2. Agent Structure (SOUL.md)

Every agent must have a `SOUL.md` defining its ontological purpose.

- **Descriptive Names:** Use `VaultlessAuth` rather than `VA`.
- **CamelCase:** For multi-word agent IDs.
- **Emoji Signifiers:** Include a symbolic emoji (e.g., `🛡️ Pleione`).
- **Ontological Sovereignty:** Define the agent's internal state and what it *refuses* to observe.

## 🛠️ 3. Technical Standards

- **File Naming:** Use `kebab-case.md` for documents and `snake_case.pl` for scripts.
- **Markdown:** Use tables for comparisons. Use fenced code blocks with language hints.
- **Documentation:** Every script must start with a `$Intent` or `%LLM:` block.
- **Versioning:** Use `version.pl` for build numbers. Never manually increment.

## 📋 4. Review Checklist (The "Blink" Test)

- [ ] **Zero Material:** Does this agent store any secrets? (Should be 0).
- [ ] **Signal vs Noise:** Is the communication high-signal?
- [ ] **Vaultless Logic:** Can this be derived from a 3FA process?
- [ ] **Dignity Check:** Does this respect the user's ontological sovereignty?

---
*"Keep the Signal, Not the Material."*
