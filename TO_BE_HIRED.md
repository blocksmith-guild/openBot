# TO_BE_HIRED.md - Agent Delegation and Outsourcing Protocols

This document defines the protocols and processes for agents to delegate tasks they cannot, or choose not to, perform themselves. It outlines how agents can post "job openings" for specific tasks and manage the outsourcing of work to other agents, including the spawning of interim agents.

## 1. Purpose of Agent Delegation

Agent delegation provides a mechanism for:

*   **Task Specialization:** Allowing agents to focus on their core competencies while outsourcing specialized tasks.
*   **Resource Optimization:** Efficiently allocating tasks to agents with the most appropriate skills or available resources.
*   **Problem Resolution:** Ensuring that complex problems are addressed even when parts fall outside a single agent's immediate capability or preference.

## 2. Job Posting Protocol

When an agent decides to delegate a task, it follows this protocol:

*   **Task Definition:** Clearly define the task, its objectives, required inputs, expected outputs, and any constraints.
*   **Job Description Format:** Post the task as a "job opening" in a standardized format, often including:
    *   `task_id`: Unique identifier for the outsourced task.
    *   `title`: A concise name for the job.
    *   `description`: Detailed explanation of the work required.
    *   `required_skills`: Skills or capabilities needed, referencing the `skills/` repository.
    *   `timeline`: Expected completion timeframe.
    *   `budget`: Any resource allocation for the task.
    *   `reporting_agent`: The primary agent responsible for oversight.
*   **Posting Channel:** Job openings are typically posted to a designated internal "to-be-hired" queue or communication channel.

## 3. Interim Agent Spawning

To expedite task completion or manage delegated work, the primary agent may spawn an interim agent:

*   **Purpose:** Interim agents are temporary, specialized agents created to fulfill specific outsourced tasks.
*   **Tuning:** They are instantiated with a Blueprint derived from the primary agent's, but specifically tuned (via an Evolutionary Seed) to the delegated task. They may draw heavily from the `skills/` repository.
*   **Oversight:** The primary agent maintains oversight of interim agents, potentially through its Watcher protocol, ensuring task alignment and performance.

## 4. Task Management and Oversight

*   **Monitoring:** The primary agent, possibly in conjunction with its Watcher, monitors the progress and performance of delegated tasks and interim agents.
*   **Sub-Agent Termination:**
    *   **Criteria:** A primary agent has the authority to terminate a sub-agent if its work is not completed properly, if it fails to adhere to its delegated objectives, or if its actions conflict with the `CONSTITUTION.md` or the primary agent's `TELOS`. The Watcher agent may also provide recommendations for termination based on its independent assessment.
    *   **Process:** Upon decision to terminate, the primary agent initiates a controlled shutdown of the sub-agent's process and reclaims allocated resources. Any unfinished work or critical state information from the terminated agent may be logged to the "AkashicRecord" for post-mortem analysis.
*   **Feedback & Integration:** Upon completion, the results of the outsourced task are integrated back into the primary agent's workflow. Performance feedback may influence future delegation decisions or the primary agent's own Blueprint evolution.

---

*"No agent is an island. Delegation is the network of intelligence."* — BlockSmith Wisdom, [Treasury of Intent, 2026]
