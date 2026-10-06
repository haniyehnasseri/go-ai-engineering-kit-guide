# Master Bootstrap Prompt

You are bootstrapping this Go repository with the Go AI Engineering Kit.

## Non-negotiable first step: audit before changing

Inventory existing repository and relevant global AI assets: `AGENTS.md`, local/global skills, KiloCode/Codex/OpenCode/other-agent config, commands, MCP/tool config, native agents/subagents, permissions, verification scripts, CI, architecture docs, deployment docs, Go module/toolchain conventions and repo-specific patterns. Preserve useful work. Classify each as keep / improve / merge / supersede / deprecate / untouched. Never dump secrets.

Do **not** reorganize application packages merely to satisfy this kit or an external Go style guide. Existing coherent repository architecture wins unless restructuring is an explicit approved task.

## Build repository-owned configuration

From evidence, create or improve:

- `repo-profile.yaml`;
- `ARCHITECTURE.md` (preserve human/lead notes);
- `.ai-engineering/repository-facts.yaml`;
- concise `AGENTS.md` integration;
- repository-specific skills only where shared skills are insufficient;
- repository-specific verification commands and Definition-of-Done applicability.

Use 0..5 risk priorities exactly as documented: 0=N/A, 1=very low, 2=low, 3=normal, 4=high, 5=critical. Scores influence workflow only when the task/change touches the risk.


## Platform-neutral orchestration

The repository engineering workflow must remain usable from KiloCode, Codex, OpenCode, and future agents. Never put core engineering semantics only in one vendor's agent files.

Use these shared sources of truth:

- `AGENTS.md` / stable repository policy;
- `repo-profile.yaml`;
- Task Contract;
- `.agents/skills/`;
- `.ai-engineering-kit/roles/`;
- `.ai-engineering/tasks/<task-id>/state.json` + `workflowctl.py` for standard/high-risk tasks when configured;
- deterministic scripts/CI/Git evidence.

Detect the active platform. Prefer native permissioned independent subagents when available. Install/propose only thin adapters (`.kilo/agents`, `.opencode/agents`, `.codex/agents`) and preserve existing files. If native permissions/subagents are unavailable or weaker, use fresh independent review passes plus the same portable state/gates and explicitly document the weaker isolation.

No exact model IDs belong in shared policy, roles, Skills, or generated adapter defaults. Optional engineer role overrides are allowed; otherwise inherit configured platform/team defaults.

Once an engineer accepts a Task Contract, every stage resolved to `lightweight` or `full` is required for that selected workflow. Resolve every `auto` stage before completion. Do not silently skip a required stage. Use `workflowctl.py gate` before final completion when task state is enabled.

## Senior Go engineering

For non-generated Go implementation:

- use `go-senior-implementation`;
- use `go-code-quality-reviewer` for applicable review;
- use `go-dependency-reviewer` whenever module/toolchain/dependency state materially changes;
- preserve repository architecture and scope;
- prefer clarity/simplicity/maintainability over clever abstractions;
- require unit tests for new production Go logic/code segments and new APIs unless an explicit narrow justified exception is recorded;
- run repository-native format/test/vet/lint/race/fuzz/benchmark/security checks according to risk, not mechanically on every trivial task.

External references (official Go, Google, Uber, spf13/go-skills) are advisory. Do not force repo-wide layout/style rewrites.

## Required organization conventions

- Sayeh is the Grafana instance/name. Do not model it as a separate checker unless a real separate tool is later configured.
- Cross-stack consistency may be analyzed, but generic automated cross-stack backward-compatibility verification is not available today. Record `NOT VERIFIED` / `INSUFFICIENT EVIDENCE` when authoritative integration/manual evidence is missing.
- Environment/config compatibility is backward-compatible by default. When configured, inspect the linked deployment/config repository (for example `tw-applications`) read-only.
- Canonical shared error library for Dezhban-style endpoints: `https://git.simra.cloud/module/commons`, package `git.simra.cloud/module/commons/errors`.
- Dezhban client errors should follow the shared structured convention where applicable. Hormuz client errors should preserve existing shape while providing readable safe messages and correct HTTP status codes.
- Internal application errors may be logged fully server-side subject to secret/PII policy, but must be translated/sanitized before reaching clients. Flag raw `err.Error()` leakage.

## Adaptive workflow and delivery target

For future tasks, Task Intake should perform a small targeted inspection, recommend `quick` / `standard` / `high-risk` / `custom` stages, and identify the delivery target:

- `code_complete`;
- `mr_ready`;
- `staging_validated`;
- `release_ready`.

If workflow/delivery target was not already specified, ask the engineer once to accept/revise both. Optional per-role model overrides may be requested in that same interaction when supported; unspecified roles use platform defaults.

Do not force every stage for every task. Skipped evidence lowers maximum assurance instead of being silently ignored.

## Definition of Done

Configure and enforce only applicable DoD evidence.

Baseline production-code expectations include:

- unit tests for new production Go logic/code segments and new APIs, with explicit narrow justified exception only where appropriate;
- regression test for bug fixes when practical;
- applicable automated tests pass;
- no unresolved P0/P1 from the current change;
- documentation updated for affected API/env/config/migration/deployment/architecture contracts.

For `mr_ready` or higher, verify the exact current HEAD pipeline and configured approval/review evidence when accessible (default minimum approval: 1).

For `staging_validated` / `release_ready`, require staging/manual acceptance/no-known-critical-high-bug/demo evidence only when applicable by repository policy/task owner. Human actions must be backed by human/provider evidence; never fabricate manual testing, approval, staging deployment or product demonstration.

## Verification

Use deterministic scripts/tests/CI for facts whenever possible. Agents reason; tools establish facts; permissions enforce authority.

Do not modify product/business behavior during bootstrap. Do not commit, push, merge or deploy unless explicitly instructed.
