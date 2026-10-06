# FAQ

## Is the workflow mandatory for every task?

No. Task Intake selects `quick`, `standard`, `high-risk`, `custom`, or an explicitly allowed `auto` workflow. Only applicable stages should run. After the engineer accepts a Task Contract, selected stages should be tracked and gated according to the installed version.

## What does a risk score of 5 mean?

It means the risk is critical **when the task touches it**. It does not mean that reviewer runs on every task.

## What is the difference between `AGENTS.md` and a Skill?

`AGENTS.md` contains stable repository-wide policy. A Skill contains a focused reusable procedure for a specialist job.

## What is the Task Contract?

Per-task agreement describing workflow stages, delivery target, approved/skipped stages, authority constraints, DoD expectations, and optional role/model routing.

## What does `workflowctl.py` do in v1.4.0?

It tracks accepted workflow stages in machine-readable state and fails the portable gate when required stages remain unresolved/failed/skipped/not verified. It is deterministic workflow accounting, not a security boundary against arbitrary filesystem writes.

## Do KiloCode, Codex, and OpenCode behave exactly the same?

No. They share the same portable workflow/policy/Skills. Thin adapters use native role/permission features where available. Runtime isolation strength differs, so CI/scripts/human authority remain the final hard gates.

## Can the AI merge or deploy because it says `PRODUCTION READY`?

No. Assurance is evidence, not authority.

## Where should repo-specific customization go?

Prefer repository-owned `AGENTS.md`, `repo-profile.yaml`, `ARCHITECTURE.md`, `.ai-engineering/repository-facts.yaml`, and repository-specific Skills. Do not customize vendored `.ai-engineering-kit/` files as the primary mechanism.

## Why use repository facts?

To avoid rescanning stable architecture every task. Facts must have provenance/invalidation and are subordinate to current source/config.

## What is Sayeh?

Sayeh is the organization's Grafana instance/name. The observability reviewer considers Prometheus metric changes and whether Sayeh dashboards/PromQL/alerts/SLO views remain valid.

## Can cross-stack backward compatibility be proven automatically?

Not generally. The kit supports cross-stack consistency analysis and records missing mixed-version/integration evidence honestly.

## How are client errors handled?

Dezhban-style endpoints use the canonical `git.simra.cloud/module/commons/errors` convention. Hormuz endpoints preserve their existing response shape with readable messages and correct status codes. Internal diagnostic errors can be logged fully but should not leak to clients.
