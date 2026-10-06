# Cross-Platform Orchestration and Enforcement

The engineering workflow is intentionally **not owned by KiloCode, Codex, OpenCode, or any model vendor**.

## Source of truth

Portable sources of truth:

1. repository `AGENTS.md` / equivalent stable policy;
2. `repo-profile.yaml`;
3. accepted Task Contract;
4. shared Skills;
5. `.ai-engineering/tasks/<task-id>/state.json` for standard/high-risk tasks when configured;
6. deterministic repository commands/CI;
7. authoritative Git/MR/human evidence.

Vendor agent files only provide stronger delegation/permissions.

## Enforcement layers

| Layer | Mechanism | Strength |
|---|---|---|
| Policy | AGENTS + Skills | guidance |
| Task selection | accepted Task Contract | explicit workflow agreement |
| Portable runtime | `workflowctl.py` task state/gate | deterministic selected-stage accounting |
| Native runtime | subagents + role permissions/sandbox | stronger isolation where supported |
| Verification | tests/lint/build/scripts | deterministic evidence |
| Delivery | CI, approvals, protected branches | hard organizational gate |
| Human authority | explicit engineer/owner action | final authority for breaking/merge/deploy decisions |

## Selected-stage invariant

After Task Intake and engineer acceptance:

- `off` => not applicable;
- `lightweight` / `full` => required;
- `auto` => unresolved and must be resolved before completion.

A required stage cannot be omitted just because the agent wants to finish early. If intentionally removed, the engineer revises the Task Contract/state and the assurance consequence is recorded.

## Portable workflow state

Example:

```bash
python3 .ai-engineering-kit/scripts/workflowctl.py init \
  --task-id SI-123 \
  --profile standard \
  --delivery-target mr_ready \
  --state .ai-engineering/tasks/SI-123/state.json \
  --repo .

# Task Intake resolves auto stages, then records engineer acceptance.
python3 .ai-engineering-kit/scripts/workflowctl.py configure \
  --state .ai-engineering/tasks/SI-123/state.json \
  --stage backward_compatibility --mode full

python3 .ai-engineering-kit/scripts/workflowctl.py accept \
  --state .ai-engineering/tasks/SI-123/state.json

# Each stage records real evidence.
python3 .ai-engineering-kit/scripts/workflowctl.py mark \
  --state .ai-engineering/tasks/SI-123/state.json \
  --stage production_testing --status pass \
  --evidence 'go test ./... passed at HEAD abc123'

# Final portable gate.
python3 .ai-engineering-kit/scripts/workflowctl.py gate \
  --state .ai-engineering/tasks/SI-123/state.json \
  --repo . --require-accepted --bind-current-head
```

The gate does not decide whether code is good; specialist agents and tests produce that evidence. It prevents selected stages from silently disappearing. The state file is deterministic workflow accounting, **not a tamper-proof security attestation**; CI, provider evidence and human authority remain the hard boundary.

## Platform behavior

### KiloCode

Use `.kilo/agents/` wrappers. Kilo supports primary/subagents, `allow`/`ask`/`deny` permissions and task delegation restrictions. The engineering orchestrator is read-only; reviewers are read-only; implementer gets edits.

Reference: https://github.com/Kilo-Org/kilocode/blob/main/packages/kilo-docs/pages/customize/custom-subagents.md

### OpenCode

Use `.opencode/agents/` wrappers. OpenCode supports primary/subagents and per-agent permission/task rules. The same portable roles are referenced; no model IDs are pinned.

Reference: https://opencode.ai/docs/agents/

### Codex

Use root `AGENTS.md`, shared `.agents/skills/`, and optional `.codex/agents/*.toml` wrappers. Codex supports custom agents/subagents, but fine-grained isolation semantics are not identical to Kilo/OpenCode; treat sandbox/defaults as strengthening controls rather than the only gate. The portable state/CI remain authoritative.

References:
- https://developers.openai.com/codex/subagents
- https://developers.openai.com/codex/skills

### Other agents

Use the portable adapter: Task Contract + workflow state + fresh independent review passes + deterministic verification + CI. Do not claim hard role isolation if the tool cannot provide it.

## Model routing

No shared role pins an exact model. If the platform supports per-role model selection, Task Intake may ask the engineer once. Unspecified roles inherit team/platform defaults.

## CI enforcement (optional)

By default, task state may remain local/untracked. Teams that want CI to enforce workflow completion can make the state available to the pipeline as a tracked file or trusted pipeline artifact and invoke `workflowctl.py gate`. This is optional because some teams do not want per-task workflow records committed.
