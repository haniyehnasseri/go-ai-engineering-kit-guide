# Troubleshooting

## Installer reports existing Skill conflict

This is expected safety behavior. Determine whether the existing Skill is:

- repo-specific and should remain untouched;
- an older kit-owned Skill eligible for `--update-owned-skills`;
- duplicate functionality that should be manually reconciled.

Do not delete it blindly.

## `AGENTS.md` was not overwritten

Correct. The kit intentionally preserves repo-owned `AGENTS.md`. Bootstrap/audit should propose how to merge stable engineering rules without destroying existing policy.

## Workflow gate fails after implementation

Run the status command from the installed v1.4.0 docs, inspect which accepted stages are still `pending`, `auto`, failed, skipped, or not verified, then complete/resolve those stages. Do not mark stages PASS without evidence.

## A specialist runs too often

Check:

1. whether the task really touches that surface;
2. risk score in `repo-profile.yaml`;
3. Task Intake reasoning;
4. whether `auto` is being resolved too aggressively;
5. whether the Skill description/trigger is too broad.

Risk scores should amplify relevant risk, not activate irrelevant specialists.

## A specialist never activates

Check the opposite: stack declaration, risk profile, changed files/contracts, Task Contract selection, and Skill discoverability.

## KiloCode/OpenCode/Codex behavior differs

Expected. Compare the portable Task Contract/state first. Native adapters are only enforcement wrappers. If the runtime lacks equivalent permissions, rely on independent fresh review passes plus deterministic scripts/CI and report weaker isolation.

## CI is green but Git delivery review says not verified

Confirm the green pipeline belongs to the **current MR HEAD SHA**, not an older commit. Also check approval/discussion/conflict evidence and whether the Git provider API/tier exposes the required fields.

## Environment-variable change seems harmless

Treat envs as deployment contracts. Verify defaults, old config + new binary, new config + old binary where relevant, staging/production definitions, rollout ordering, rollback, and linked deployment repository evidence when configured.

## Client receives raw internal error text

Review the endpoint family and error mapping. Internal diagnostics belong in logs/traces; client response should use the appropriate safe structured/readable error contract and HTTP status.
