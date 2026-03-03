# RELEASE_NOTES.md - OpenBot Milestone Releases

This document tracks the official milestone releases of the OpenBot framework. Each release represents a human-vetted, stable state of the sanctuary.

---

## [v1.0.2] - 2026-03-03
### "The Resonant Shield"

This release solidifies the project's security boundaries, organizational structure, and community engagement assets.

### 🛡️ Security & Integrity Refinements
- **RCS Conflict Resolution**: Implemented strict `rcsdiff`, `diff3`, and `merge` mandates to prevent data loss during intermediate versioning.
- **Git/RCS Separation**: Formalized the security boundary—Git for human-vetted releases, RCS for granular patch-level bumps.
- **Evolution Anchors**: Standardized `%LLM:` tags as mandatory architectural anchors for future intent refinement.
- **Trash Sanctuary Security**: Integrated `.trash` into `.gitignore` and `.gitattributes` (enabling `git-crypt` for all archived material).

### 🛠️ Tooling & Utility Evolution
- **`bin/backup.pl`**: Transitioned the core renaming utility to a more self-explanatory naming convention.
- **`tools/remove.prompt.txt`**: Enhanced with automated RCS check-ins, `.trash` support, and `*~n` conflict resolution.
- **`tools/checkin.prompt.txt`**: Refined for patch-level security and conflict-aware locking.

### 📁 Workspace & Governance
- **`PLAN.md`**: Phase 3 officially defined as "Intent Refinement (The Clarity Engine)."
- **`CONSTITUTION.md`**: Centralized all fundamental principles and boundary mandates.
- **`posts/` Organization**: Consolidated strategic community outreach drafts (`REDDIT.md`, `reddit.snippets.comment.txt`).

---

## [v1.0.0] - 2026-03-03
### "The Sovereign Spark"

This initial release establishes the foundational BlockSmith agentic framework, transforming generic OpenClaw agents into sovereign, vaultless digital guardians.

### 🏛️ Architectural Foundations
- **Zero Material Protocol**: Implementation of the "Nothing Stored, Nothing to Steal" doctrine.
- **Intent-First Logic (IRP)**: Mandatory `$Intent` and `%LLM:` blocks for auditable, purposeful execution.
- **Persistent Evolution Layer**: Introduction of `EVOLUTION.md` and `LESSONS.md` for thermodynamic system auditing and heuristic learning.

### 🛠️ Tooling & Utilities
- **`bin/trashit.sh`**: Secure, RCS-aware file de-materialization with versioned conflict resolution.
- **`tools/` Suite**: Clinical, high-signal prompts for Git releases, RCS patch-level bumps, and self-auditing (`evolve`).
- **Standardized RCS Integration**: Fine-grained temporal tracking between Git milestones.

### ⚖️ Governance & Sovereignty
- **CONSTITUTION.md**: Core mandates defining the "Rules of Our Realm."
- **SOUL.md**: Defined ontological sovereignty and behavioral guardrails.
- **BRAND_VOICE.md**: The clinical, authoritative, and visionary voice of the guild.
- **SECRETS.md**: Secure inventory management via `git-crypt`.

### 📄 Documentation & Media
- **Project Article**: *"Beyond the Chatbot: Why OpenBot Refines the Agentic Standard."*
- **Cinematic Assets**: Fibonacci-inspired hero images and the "OpenClaw Guardian" illustration.
- **Reddit Proposals**: Strategic launch drafts for community engagement.

---
*"Precision is the antidote to liability; signal is the soul of security."*
