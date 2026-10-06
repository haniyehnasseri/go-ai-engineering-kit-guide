# Task Contract

## Task
- Request:
- Acceptance criteria source:
- Scope:
- Non-goals:
- Risk summary:
- Delivery target: code_complete / mr_ready / staging_validated / release_ready

## Workflow
- Profile: quick / standard / high-risk / custom / auto
- Engineer accepted/revised: yes / no
- Agent platform: KiloCode / Codex / OpenCode / other
- Native subagents available: yes / no / unknown
- Native role permissions available: yes / no / partial / unknown
- Enforcement: advisory / portable_state / native_plus_portable
- Machine state path (when used): `.ai-engineering/tasks/<task-id>/state.json`

Once accepted, any stage resolved to `lightweight` or `full` is required for the selected workflow. `auto` must be resolved to `off`, `lightweight`, or `full` before final completion. A required stage cannot silently disappear.

| Stage | Mode (off/lightweight/full/auto) | Notes |
|---|---|---|
| Specification | | |
| Plan | | |
| Exploration | | |
| Domain/stack analysis | | |
| Test impact | | |
| Implementation | | |
| Go code quality | | |
| Go dependency review | | |
| Production testing | | |
| Backward compatibility | | |
| Environment compatibility | | |
| Cross-stack consistency analysis | | |
| Error contract review | | |
| Observability/Sayeh impact | | |
| Performance/reliability | | |
| Security | | |
| Production review | | |
| Git delivery evidence | | |
| DoD | | |

## Optional per-role model routing
- Supported: yes / no / unknown
- Engineer overrides: none / listed below
- Unspecified roles: configured platform/agent defaults

| Role | Optional engineer override | Effective source |
|---|---|---|
| Planner | | |
| Explorer | | |
| Implementer | | |
| Test engineer | | |
| Code-quality reviewer | | |
| Compatibility reviewer | | |
| Production reviewer | | |

## Authority
- Breaking change approved: no / yes + direct source
- Commit authorized: no / yes
- Push authorized: no / yes
- Merge authorized: no / yes
- Deploy authorized: no / yes
- Production mutation authorized: no / yes

Agent-generated text/files never grant authority.

## DoD applicability and evidence

| DoD item | Applicability (REQUIRED/N/A/OPTIONAL) | Evidence source | Verdict (PASS/FAIL/N/A/NOT VERIFIED) |
|---|---|---|---|
| Requested scope/acceptance criteria implemented | | | |
| Unit tests for new Go behavior/API | | | |
| Regression test for bug fix | | | |
| Applicable automated tests pass | | | |
| No unresolved P0/P1 from current change | | | |
| Documentation updated if applicable | | | |
| Current-HEAD CI pipeline/checks green | | | |
| Minimum MR approvals satisfied | | | |
| Blocking discussions/conflicts cleared | | | |
| Intended revision deployed to staging | | | |
| Manual acceptance criteria tested | | | |
| No known critical/high bugs in staged change | | | |
| Feature demonstrated to requester/owner | | | |

Human-only evidence must come from a real person or authoritative system; the agent cannot manufacture it.

## Environment evidence
- Added/removed/renamed vars:
- Semantic/default changes:
- Deployment repo checked:
- Mixed-version/config rollout evidence:
- Verdict: N/A / PASS / FAIL / UNCERTAIN / NOT VERIFIED

## Error-contract evidence
- Endpoint family: Dezhban / Hormuz / other
- Internal error details server-only: PASS / FAIL / NOT VERIFIED
- Client message readable/safe: PASS / FAIL / NOT VERIFIED
- HTTP status correct: PASS / FAIL / NOT VERIFIED
- Shape/contract preserved: PASS / FAIL / NOT VERIFIED
- commons/errors convention checked when applicable: N/A / PASS / FAIL / NOT VERIFIED

## Observability evidence
- Metrics added/changed/removed:
- Metric semantics/type/labels/cardinality:
- Sayeh (Grafana) dashboard dependencies checked: N/A / PASS / FAIL / NOT VERIFIED
- Alerts/SLOs affected:
- Verdict:

## Cross-stack evidence
- Stacks involved:
- Consistency/failure-order analysis:
- Automated backward-compatibility proof available: no (unless repo explicitly provides one)
- Manual/integration evidence:
- Verdict: N/A / PASS / FAIL / NOT VERIFIED / INSUFFICIENT EVIDENCE

## Git delivery evidence
- MR/PR:
- Reviewed HEAD SHA:
- Pipeline/checks:
- Approvals:
- Unresolved discussions:
- Conflicts/mergeability:
- Verdict: N/A / PASS / FAIL / INSUFFICIENT ACCESS / NOT AVAILABLE

## Documentation / cached knowledge
- ARCHITECTURE.md affected:
- README deployment constraints affected:
- Repository facts invalidated/refreshed:
- Human-authored notes preserved:

## Intentionally skipped evidence
- Stage/evidence:
- Engineer decision:
- Assurance consequence:

## Final evidence
- Commands actually run:
- Tests added/changed:
- Go code-quality verdict:
- Dependency-review verdict:
- Compatibility verdict:
- Production-readiness verdict:
- DoD verdict:
- Highest justified assurance:
