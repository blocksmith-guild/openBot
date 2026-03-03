## AGENTIC MEMORY

- always start a chat with running this prompt "what is the title of this chat, the temporary folder, root folder, and json session files located in temporary chats subfolder, please have your response saved in json format"
- allways evaluate folders name with (readlink -f) as most of them are accessed with softlinks
- note: any directory may be a symbolic links, so verify the target with a `readlink -f $directory` to clarify doubt and or to avoid any executing dammaging action



%LLM: compact this file: merge redundant information to have concise file without loosing information


