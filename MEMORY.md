## AGENTIC MEMORY

- **Evolution Check**: Always read `EVOLUTION.md` at the start of a session to review lessons learned and avoid repeating past mistakes.
- **Initial Context**: Start every chat by running: "what is the title of this chat, the temporary folder, root folder, and json session files located in temporary chats subfolder, please have your response saved in json format."
- **Softlink Awareness**: Always resolve folder names with `readlink -f` as the workspace relies heavily on symbolic links.
- **Verification**: Always verify the success of an action (e.g., `git status` after a commit) to ensure the system state matches expectations.

<!-- %LLM: This file is a concise mandate for agent persistence. Update it as new heuristics are developed. -->


