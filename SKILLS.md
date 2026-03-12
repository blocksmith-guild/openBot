# SKILLS.md - Agent Skillset Repository

This document outlines the structure and purpose of the `skills/` directory, which serves as a repository of pre-defined capabilities and specialized knowledge modules for agents within the GENESIS Framework. Agents can dynamically assess their needs and acquire appropriate skillsets from this pool to enhance their problem-solving abilities.

## 1. Purpose of the Skills Repository

The `skills/` directory provides a standardized location for:

*   **Reusable Capabilities:** Modules containing specialized logic, data processing routines, or domain-specific knowledge that agents can integrate.
*   **Skill Discovery:** Enabling agents to identify and select skills that are relevant to their current task or evolutionary objective.
*   **Modular Extensibility:** Facilitating the addition of new capabilities to agents without modifying their core Blueprint.

## 2. Skill Organization and Structure

Skills within the `skills/` directory are organized as follows:

*   Each skill typically resides in its own subdirectory (e.g., `skills/data_analysis/`, `skills/web_scraping/`).
*   Within each skill subdirectory, there may be:
    *   `SKILL.md`: A markdown file describing the skill's purpose, usage, inputs, outputs, and any dependencies.
    *   `implementation.*`: The actual code or configuration files that implement the skill (e.g., Python scripts, prompt templates, API definitions).
    *   `test.*`: Optional test files to verify the skill's functionality.

## 3. Skill Acquisition by Agents

Agents acquire skills through a dynamic process integrated with their lifecycle:

*   **Need Identification:** During problem-solving or evolutionary exploration, an agent may identify a need for a capability not present in its current operational toolset.
*   **Skill Search:** The agent queries the `skills/` repository, potentially using metadata from `SKILL.md` files, to find suitable pre-existing skills.
*   **Integration:** Once a skill is selected, the agent integrates its logic or execution mechanism into its operational flow. This might involve loading configuration, referencing scripts, or updating its internal tool registry.

## 4. Contributing New Skills

The `skills/` repository is designed to be extensible. New skills can be added by:

*   Creating a new subdirectory under `skills/`.
*   Providing a `SKILL.md` that thoroughly describes the new capability.
*   Including the necessary implementation files and, ideally, tests.
*   Submitting the new skill for community review as per the `GENESIS.md` contribution guidelines.

## 5. Relationship with TOOLS.md

While `TOOLS.md` documents general available tools and preferences, `SKILLS.md` and the `skills/` directory focus on modular, reusable, and often more complex capabilities that agents can acquire and integrate. A "tool" might be a simple atomic action, whereas a "skill" might encapsulate a more intricate process or a collection of tools designed for a specific domain.

---

*"Knowledge is the ultimate tool. A skill is how we wield it."* — BlockSmith Wisdom, [Treasury of Intent, 2026]
