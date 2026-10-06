# Definition of Done

The kit separates **engineering evidence** from **human/product delivery evidence**. Not every task needs staging, manual acceptance testing, an MR approval, or a product demo. Applicability is driven by the repository profile, task type, delivery target, and the engineer/task owner.

## Delivery targets

- `code_complete` — implementation plus applicable local tests/review/documentation.
- `mr_ready` — `code_complete` plus current-HEAD CI/merge-request evidence required by policy.
- `staging_validated` — `mr_ready` plus staging deployment and applicable acceptance validation.
- `release_ready` — all repository-required release evidence, including any staging/product validation required by policy.

Task Intake should infer a target only when it is clear; otherwise include it in the same one-time workflow question to the engineer.

## Shared DoD items

### Engineering baseline

For applicable code changes:

- requested scope/acceptance criteria are implemented;
- new production Go logic/code segments and new APIs have unit tests; an exception must be explicit and narrowly justified (for example generated/pure-wiring code) with a stronger test layer where appropriate;
- bug fixes have regression tests when practical;
- applicable unit/integration/regression/E2E checks selected by repository policy pass;
- no unresolved `P0`/`P1` finding from the current change/review remains;
- documentation for API/config/environment/migration/deployment/architecture changes is updated when applicable.

### Merge-request readiness

When target is `mr_ready` or higher and an MR exists:

- CI/CD pipeline/checks for the **exact current HEAD SHA** pass;
- configured minimum approvals are satisfied (default: at least one);
- no blocking unresolved review discussions remain when the provider exposes that evidence;
- no merge conflict/mergeability blocker remains when available.

### Staging/product validation

Only when applicable to the task/delivery target:

- the exact intended revision is deployed to staging;
- acceptance criteria requiring human/product validation are manually tested against that staging revision;
- no known critical/high-priority bug attributable to the staged task remains;
- the feature/change is demonstrated to the product owner/requester only when they or repository policy require it.

Human validation must be recorded as human-provided evidence. An AI agent must never fabricate "manual test passed", "product owner approved", or "demo completed".

## Fast/applicability rule

A small internal refactor targeting `code_complete` does not need staging deployment, product demo, or MR approval. A user-visible feature requested as `staging_validated` may need all of them. A two-line DB/event/API contract change may still require a high-risk engineering workflow.

The DoD verifier returns `PASS`, `FAIL`, `N/A`, or `NOT VERIFIED` per item and calculates the highest assurance justified by available evidence.
