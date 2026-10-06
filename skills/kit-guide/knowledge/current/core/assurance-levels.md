# Assurance Levels

These are evidence labels, not action permissions.

1. `IMPLEMENTED` — requested code/change exists.
2. `LOCALLY VERIFIED` — targeted local checks were run.
3. `TESTED` — appropriate automated testing evidence exists.
4. `INDEPENDENTLY REVIEWED` — applicable independent review completed.
5. `SAFE TO COMMIT` — repository policy evidence supports committing; commit permission is separate.
6. `SAFE TO MERGE` — configured current-HEAD CI/approval/review evidence is satisfied; merge permission is separate.
7. `PRODUCTION READY` — all repository-required production evidence for the selected delivery target is satisfied.

## Delivery target interaction

- `code_complete` does not inherently require an MR, staging deployment, manual acceptance test or product demo.
- `mr_ready` can reach `SAFE TO MERGE` only when required merge-request evidence is authoritative for the exact current HEAD.
- `staging_validated` / `release_ready` require configured staging/human/product evidence when those items are applicable.

Skipped/unavailable mandatory evidence caps the maximum honest assurance. `NOT VERIFIED` must never be silently treated as `PASS`.

Human actions such as manual acceptance testing, feature demonstration or approval must come from human/provider evidence; agent-generated notes are not proof.
