# Cursor Docs

Centralized documentation, research, and planning outputs for Cursor AI-assisted development.

## Directory Structure

```
cursor-docs/
├── research/           # Research outputs from /research-codebase command
├── planning/           # Implementation plans from /create-plan command
├── commands/           # Backup of custom slash commands (installed in ~/.cursor/commands/)
└── agents/             # Backup of custom sub-agents (installed in ~/.cursor/agents/)
```

## Installation

Commands and agents need to be installed in your user `.cursor` directory to be available across all projects:

```bash
# Create directories if they don't exist
mkdir -p ~/.cursor/commands
mkdir -p ~/.cursor/agents

# Install commands
cp cursor-docs/commands/*.md ~/.cursor/commands/

# Install agents
cp cursor-docs/agents/*.md ~/.cursor/agents/
```

## Commands

These slash commands implement a **Research → Plan → Implement** workflow:

### `/research-codebase`
Conducts comprehensive codebase research using parallel sub-agents.

- **Output**: `cursor-docs/research/YYYY-MM-DD-TICKET-description.md`
- **Usage**: `/research-codebase` then describe what you want to research
- **Sub-agents used**: codebase-locator, codebase-analyzer, codebase-pattern-finder, research-locator

### `/create-plan`
Creates detailed implementation plans through interactive research and iteration.

- **Output**: `cursor-docs/planning/YYYY-MM-DD-TICKET-description.md`
- **Usage**: `/create-plan` or `/create-plan @path/to/ticket.md`
- **Sub-agents used**: codebase-locator, codebase-analyzer, codebase-pattern-finder, research-locator, research-analyzer

### `/implement-plan`
Implements approved technical plans with verification checkpoints.

- **Usage**: `/implement-plan @cursor-docs/planning/YYYY-MM-DD-plan.md`
- **Sub-agents used**: codebase-analyzer, codebase-pattern-finder (sparingly)

## Sub-agents

Custom sub-agents extend Cursor's capabilities with specialized research tasks:

### Codebase Research

| Agent | Description |
|-------|-------------|
| `codebase-locator` | Finds WHERE files and components live. Super Grep/Glob/LS tool. |
| `codebase-analyzer` | Understands HOW specific code works with file:line references. |
| `codebase-pattern-finder` | Finds similar implementations and patterns to follow. |

### Historical Context

| Agent | Description |
|-------|-------------|
| `research-locator` | Discovers existing research/plans in `cursor-docs/` |
| `research-analyzer` | Extracts key insights from prior research/plans |

### Verification

| Agent | Description |
|-------|-------------|
| `verifier` | Independently validates completed work. Skeptical - tests everything. |

### External Research

| Agent | Description |
|-------|-------------|
| `web-search-researcher` | Searches web for documentation and best practices |

## Invoking Sub-agents

Sub-agents can be invoked in several ways:

```bash
# Direct invocation
/codebase-locator find all files related to authentication

# Natural language
Use the codebase-analyzer to understand how the service works

# In chat
Delegate to /codebase-pattern-finder to find similar REST endpoints
```

## Workflow Example

```
1. Research the codebase
   > /research-codebase
   > How does user authentication work in the mono repo?
   
   Output: cursor-docs/research/2025-01-26-authentication-flow.md

2. Create implementation plan
   > /create-plan @cursor-docs/research/2025-01-26-authentication-flow.md
   > Add OAuth2 support for external providers
   
   Output: cursor-docs/planning/2025-01-26-TEC-1234-oauth2-support.md

3. Implement the plan
   > /implement-plan @cursor-docs/planning/2025-01-26-TEC-1234-oauth2-support.md
```

## Configuration

All agents use Cursor-compatible frontmatter:

```yaml
---
name: agent-name
description: When to use this agent (Cursor uses this for auto-delegation)
model: fast          # Options: fast, inherit, or model ID
readonly: true       # Restricts write operations
---
```

## File Naming Convention

Research and planning documents follow the format:
```
YYYY-MM-DD-TICKET-description.md
```

Examples:
- `2025-01-26-TEC-1234-add-oauth2-support.md`
- `2025-01-26-authentication-flow.md` (no ticket)
