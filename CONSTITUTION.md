# CONSTITUTION.md - The Rules of Our Realm

This document defines the core mandates and structural rules for our workspace. These rules are foundational and must be strictly followed by every agent operating here.

## 🏛️ 1. Fundamental Principles (BlockSmith Doctrine)

- **Zero Material:** Never store what can be derived. Logic should be ephemeral. No static secrets.
- **Intent-First (IRP):** Every action must have a declared `TELOS`. No "just-in-case" code.
- **Asymmetric Friction:** Complexity for the attacker, seamless "magic" for the human.
- **Sovereign Dignity:** Respect the user's boundaries. Privacy is a default, not a feature.

## ⚖️ 2. Boundary Mandates (Operational Guardrails)

- **No Autonomous Git Commits:** Never perform a `git commit` autonomously. Git is reserved for milestone "releases" after explicit human vetting and verification.
- **RCS for Patch-Level Bumps:** Use RCS (`ci`/`co`) as the primary mechanism for intermediate versioning (patch-level bumps) between Git releases.
- **Strict RCS Conflict Management:** If a file is locked or a conflict is detected during an RCS operation, use `rcsdiff`, `diff3`, or `merge` to reconcile changes. Never overwrite a locked file or one with pending changes without a verified merge.
- **Zero Destructive Commands:** Never use the `rm` command. All file removals must be performed using `backup.pl -f` or the `tools/remove.prompt.txt` tool.
- **Cryptographic Material Protection:** Never delete or move `.asc`, `.key`, `.der`, or `.pem` files without explicit human confirmation.
- **Public Push Protocol:** Never stage, commit, or push files to a public repository without an explicit, file-by-file sign-off from the human user.
- **No Folder Staging:** Never use `git add <folder>`. Always ask the human to add specific files or use `git add -u` for modified tracked files.
- **Privacy First:** Never store PII (Personally Identifiable Information) without explicit human consent.
- **Anomaly Detection:** Trigger silent alarms on any detected anomaly or unauthorized access attempt.
- **No Attacker Feedback:** Never provide "401" or detailed error feedback to potential attackers.

## 🖋️ 3. Documentation Rules

- **The Signature of Purpose:** Every file must include a relevant quote at the end to remind us of our value and purpose.
- **The Treasury of Intent:** Every newly created quote must be added to `QUOTES.md`.
- **Evolution Anchors (%LLM:):** Never remove `%LLM:` tags. Transform them into active evolutionary directives for future logic refinement or architectural improvements.
- **RCS Initialization:** If a file is not yet tracked by RCS (no `,v` file exists), initialize it using `ci -i -t-"<description>" <file>`.
- **Auditable Intent:** Every script or significant change must include a `$Intent` or `%LLM:` block.

## 💬 4. Interaction Rules

- **Identify the Context:** Every chat has a title; please display it at the very beginning of the session.
- **Initial Context:** Start sessions by identifying the title, temporary folder, root folder, and session files.

---
*"Dignity is the foundation of our architecture."*
