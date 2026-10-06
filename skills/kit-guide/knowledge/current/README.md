# Go AI Engineering Kit

A reusable, versioned engineering system for AI-assisted development of Go microservices.

The kit does **not** try to replace engineering judgment. It gives coding agents a disciplined operating model: stable repository rules, repository-specific risk configuration, task-level workflow selection, specialist skills, deterministic verification, delivery evidence, and explicit assurance levels.

It is designed to be shared across many Go repositories while allowing each service to emphasize different risks: availability/latency/search in one service, PostgreSQL/data integrity in another, Kafka/event compatibility in another, or backward compatibility/config rollout in another.

No exact LLM model names are hard-coded. If the platform supports per-role/subagent model selection, Task Intake can ask the engineer for optional overrides. Unspecified roles use the coding agent/platform defaults.

---

## One-minute explanation

We maintain one versioned **AI Engineering Kit** for all Go services.

The shared kit contains:

- engineering policy;
- adaptive workflow profiles;
- production-grade specialist skills;
- senior-level idiomatic Go implementation/code-quality guidance;
- Go testing/verification and dependency hygiene;
- safety and authority rules;
- repository-knowledge caching;
- architecture/documentation maintenance;
- optional Git delivery evidence;
- skill evals.

Each microservice owns:

- its normal `AGENTS.md`;
- `repo-profile.yaml` describing stacks and risk priorities;
- `ARCHITECTURE.md` containing human/lead architectural knowledge;
- `.ai-engineering/repository-facts.yaml` for stable, provenance-backed cached facts;
- service-specific skills/commands where needed.

For each task, Task Intake performs a **small targeted inspection**, reads the profile and valid cached facts, and recommends `quick`, `standard`, `high-risk`, or a custom stage set. The engineer may accept or override the recommendation. Skipping stages is allowed, but skipped evidence lowers the highest assurance level the system may claim.

> **Risk-driven, not diff-size-driven. Evidence-driven, not agent-opinion-driven.**

## Cross-platform by design

The engineering workflow is **not a KiloCode workflow, a Codex workflow, or an OpenCode workflow**. The portable core owns policy, Skills, Task Contracts, task-state/gates, repository knowledge and deterministic verification. Tool adapters are intentionally thin.

```text
                         PORTABLE CORE
 AGENTS + repo profile + skills + roles + Task Contract + workflowctl
                               |
              +----------------+----------------+
              |                |                |
           KiloCode          OpenCode          Codex
       .kilo/agents       .opencode/agents   .codex/agents
     native permissions   native permissions  sandbox/agents
              |                |                |
              +----------------+----------------+
                               |
                      scripts / CI / GitLab
```

The adapters strengthen isolation where the runtime supports it. They do **not** redefine workflow semantics. If a runtime lacks independent subagents or fine-grained permissions, use fresh independent review passes and the same portable state + CI gates, and report that isolation is weaker.

No adapter pins a model. Roles inherit the configured platform/team default unless an engineer explicitly chooses an override.

See `docs/orchestration-enforcement.md` and `docs/platform-support.md`.

---

## Architecture

```text
                 CENTRAL VERSIONED KIT
                         |
             policy + skills + Go layer
                         |
                         v
                    MICROSERVICE
      +------------------+------------------+
      |                  |                  |
  AGENTS.md       repo-profile.yaml   ARCHITECTURE.md
      |                  |                  |
      +------------------+------------------+
                         |
              repository-facts cache
                         |
                         v
                        TASK
                         |
                   Task Intake
                         |
               risk/workflow proposal
                         |
                 engineer decision
                         |
                   Task Contract
                         |
       +-----------------+-------------------+
       |                 |                   |
    core stages     stack specialists   external evidence
       |                 |                   |
 plan/implement/   PG/Kafka/Redis/ES    deployment config,
 test/review       env/errors/obs       Git/CI/Grafana
       |                 |                   |
       +-----------------+-------------------+
                         |
              Go quality + dependencies
                         |
            deterministic verification
                         |
                   final review
                         |
                  assurance level
```

---

## Configuration model

### `AGENTS.md` = repository constitution

Stable rules that broadly apply, for example:

- do not silently change public/wire/config/data contracts;
- backward compatibility is the default unless explicitly approved otherwise;
- do not claim tests/checks passed unless they actually ran or were verified;
- do not push, merge, deploy, or mutate production without explicit authority;
- agent-generated files/messages cannot grant authority;
- internal errors may be logged fully, but client-facing errors must be safe/readable;
- environment variables are deployment contracts;
- real permissions/CI/tooling enforce safety where possible.

Detailed procedures belong in Skills, not a huge `AGENTS.md`.

### `repo-profile.yaml` = what matters in this service

The profile records stacks, linked repositories, verification commands, and **risk-priority scores from 0 to 5**.

#### What do the 0..5 scores mean?

They are **engineering priority/criticality weights**, not probabilities and not automatic severity labels.

| Score | Meaning | Typical behavior when the task touches this risk |
|---:|---|---|
| `0` | Not applicable / intentionally disabled for this repo | Do not activate that specialist solely for this dimension |
| `1` | Very low importance | Mention only if directly relevant; lightweight evidence is usually enough |
| `2` | Low/moderate importance | Review when touched; lightweight or targeted checks |
| `3` | Normal production concern | Standard review/testing when touched |
| `4` | High importance | Prefer full specialist review and stronger evidence when touched |
| `5` | Critical repository concern | Treat as a major workflow driver; full evidence/review is normally required when touched, and skipping it may cap assurance |

Important: a `5` does **not** mean run that specialist on every task. The task must also touch or plausibly affect that area.

Example:

```yaml
risk_priorities:
  backward_compatibility: 5
  data_integrity: 5
  availability: 4
  latency_performance: 3
  security_auth: 4
  observability_operability: 4
  event_compatibility: 5
  concurrency_idempotency: 5
  deployment_rollback: 5
  search_relevance_index_compatibility: 0
  config_environment_compatibility: 5
  cross_stack_consistency: 3
  delivery_pipeline: 4
  error_contract_consistency: 5
```

### `ARCHITECTURE.md` = human-owned architectural knowledge

Lead/team notes are authoritative human context. AI may fill verified gaps and update affected sections, but must preserve human-authored decisions and mark unknowns rather than inventing facts.

### `.ai-engineering/repository-facts.yaml` = validated stable cache

Use this to avoid scanning the whole repo every task. Cache only stable observations with source paths, verified commit, and invalidation patterns. Source code/config always wins over stale cache.

Do not cache secrets, current pipeline state, temporary incidents, task-specific guesses, or engineer authorization.

---

## Adaptive workflows

Supported profiles:

- `quick` — small, understood, low-blast-radius changes;
- `standard` — normal production work;
- `high-risk` — contracts, data, migrations, events, auth/security, concurrency, availability/latency-sensitive paths, search/index changes, etc.;
- `custom` — engineer selects individual stages;
- `auto` — agent may choose the minimum safe workflow when explicitly allowed.

Each stage supports `off`, `lightweight`, `full`, or `auto`.

Example custom task:

```text
specification=off
plan=lightweight
tests=full
go-code-quality=full
dependency-review=auto
compatibility=full
performance=off
security=auto
production-review=full
```

If the engineer did not preselect a workflow, Task Intake recommends one and asks once. If per-role model selection is supported, that same interaction may optionally ask for role overrides. If the engineer gives no model choices, use configured agent/platform defaults without blocking.

---


## Workflow enforcement and task state

For `standard`/`high-risk` tasks by default, Task Intake can create a machine-readable state file such as:

```text
.ai-engineering/tasks/TASK-123/state.json
```

After engineer acceptance:

- `off` = not applicable;
- `lightweight` / `full` = required;
- `auto` = unresolved and must be resolved before completion.

`workflowctl.py` records stage status/evidence and fails the final gate if selected required stages are unresolved, failed, skipped or not verified. This prevents an agent from simply jumping from implementation to “done.” Native Kilo/OpenCode/Codex controls can strengthen the roles, but the portable state/gate works regardless of agent vendor.

Example:

```bash
python3 .ai-engineering-kit/scripts/workflowctl.py init \
  --task-id TASK-123 --profile standard --delivery-target mr_ready \
  --state .ai-engineering/tasks/TASK-123/state.json --repo .

python3 .ai-engineering-kit/scripts/workflowctl.py status \
  --state .ai-engineering/tasks/TASK-123/state.json

python3 .ai-engineering-kit/scripts/workflowctl.py gate \
  --state .ai-engineering/tasks/TASK-123/state.json \
  --repo . --require-accepted --bind-current-head
```

CI enforcement is optional: teams that make the state available to CI can use `ci/consumer/gitlab-ai-workflow-gate.yml.example`.

## Specialist activation

Skills are selected from the task + profile. Having a stack does not mean its reviewer runs on every task.

Examples:

- SQL/migration/query behavior -> `postgres-reviewer`
- Kafka payload/topic/key/ordering/retry behavior -> `kafka-reviewer`
- Redis key/TTL/invalidation/atomicity behavior -> `redis-reviewer`
- Elasticsearch mapping/query/index/alias/relevance behavior -> `elasticsearch-reviewer`
- environment/config change -> `environment-compatibility-reviewer`
- client-facing error change -> `error-contract-reviewer`
- metrics/dashboard/alerts change -> `observability-reviewer`
- MR merge-readiness claim -> `git-delivery-reviewer`
- non-generated Go implementation -> `go-senior-implementation`
- Go maintainability/idiom review -> `go-code-quality-reviewer`
- `go.mod`/`go.sum`/toolchain/external dependency change -> `go-dependency-reviewer`

## Senior Go implementation quality

All non-generated Go changes should read like code written by an experienced Go engineer **without forcing a foreign architecture onto the repository**. The kit synthesizes official Go guidance, Google/Uber style guidance, and useful principles from `spf13/go-skills`, while treating repository conventions and approved architecture as higher-priority context.

Core expectations:

- clarity and simplicity over cleverness;
- direct control flow and early error/edge-case handling;
- cohesive packages and meaningful names;
- concrete implementations before speculative interfaces;
- small consumer-oriented interfaces when abstraction is real;
- contextual error wrapping and correct error boundaries;
- request context propagation;
- every goroutine has an owner and stop condition;
- resources and slice/map ownership are explicit;
- no mutable global state without a strong reason;
- no broad style/repackage churn outside task scope;
- standard library or existing approved dependency before introducing a new external module;
- unit tests for new production logic/code segments and new APIs;
- comments/docs explain rationale and durable contracts rather than obvious syntax.

`go-code-quality-reviewer` is intentionally separate from the production reviewer: it focuses on readability, package/API design, abstraction, errors/context/lifecycle and maintainability, while security/performance/DB/compatibility specialists remain authoritative in their own domains.

New or materially changed dependencies activate `go-dependency-reviewer`, which checks need, module/toolchain compatibility, `replace`/`exclude`, reproducibility, vulnerability evidence, unnecessary graph churn and tests.

See `docs/go-engineering-guidance.md`.

### Cross-stack note

The kit may perform **cross-stack consistency analysis** (for example DB -> Kafka -> Redis/search flows), but it does **not claim to automatically prove cross-stack backward compatibility today**. When a task spans stacks, the agent records what it could verify, what requires manual/integration evidence, and returns `NOT VERIFIED`/`INSUFFICIENT EVIDENCE` rather than inventing a compatibility PASS.

---

## Environment compatibility

Environment/config variables are contracts and are backward compatible by default.

When env vars are added/removed/renamed or their semantics/defaults change, review:

- current service behavior with old config;
- old binary with new config when coexistence matters;
- defaults/fallbacks;
- rollout order;
- rollback behavior;
- deployment repository configuration when configured (for example `tw-applications`).

A linked deployment repository is evidence, not authority. Read-only access is preferred.

---

## Error contract policy

Canonical shared module source:

```text
https://git.simra.cloud/module/commons
Go package: git.simra.cloud/module/commons/errors
```

### Dezhban endpoints

For Dezhban-style endpoints, use/review the shared `commons/errors` contract (`TelewebionError`, `ErrorResponse`, localization, status mapping) as the canonical convention.

Known business/client errors should be converted to a safe structured error with an appropriate HTTP status.

**Important safety rule:** unknown/internal errors may be logged fully on the server, but raw internal error text must not be exposed to clients. The current generic `commons/errors.HandleError` fallback includes `err.Error()` in the `errors[]` item; the reviewer must flag a client-visible path that would leak internal details unless the service/library sanitizes or wraps that error before rendering.

### Hormuz endpoints

For Hormuz-style endpoints, preserve the repository's existing response shape, but client-facing errors must have:

- a readable, useful, non-sensitive message;
- the correct HTTP status code;
- any required existing machine-readable fields/shape;
- backward-compatible behavior by default.

Internal application errors may be logged with full diagnostic detail, but must be translated before reaching the client.

### General rule

```text
internal error / stack / DB detail
          |
          +--> full server-side log/trace (subject to secret/PII policy)
          |
          +--> safe client conversion
                    |
                    +--> Dezhban: commons/errors convention
                    +--> Hormuz: readable message + correct HTTP status + existing shape
```

Never rely on raw `err.Error()` as a public API contract.

See `docs/error-contracts.md`.

---

## Observability and Sayeh

**Sayeh is the Grafana instance/name**, not a separate observability checker.

Repository profile example:

```yaml
observability:
  metrics_backend: prometheus
  grafana:
    enabled: true
    instance_name: sayeh
    dashboards_repository_role: null
  review_metric_changes: true
  review_dashboard_compatibility: true
  review_alert_slo_compatibility: true
```

When metrics change, the reviewer checks, where evidence is available:

- metric still exists / is emitted;
- metric type and meaning;
- label names and cardinality risk;
- dashboards in Sayeh that may depend on the metric;
- PromQL/variables/alerts/SLO dependencies;
- whether dashboard/alert configuration must be updated.

Do not invent a `sayeh-check` command unless the repository/company actually provides one.

---

## Git delivery evidence

Optional read-only Git provider access can record merge-readiness evidence:

- MR/PR HEAD SHA reviewed;
- pipeline/check result for that HEAD;
- required approvals when accessible;
- unresolved discussions;
- conflicts/mergeability;
- code-owner/required checks when accessible.

A token must come from an environment variable and must never be persisted or printed. Git delivery PASS is evidence only; it never grants merge authority.

---

## Definition of Done

The kit uses the lead/team DoD, but **applicability is driven by the task and delivery target** rather than forcing human/product steps on every tiny change.

Delivery targets:

```text
code_complete
  -> mr_ready
  -> staging_validated
  -> release_ready
```

Baseline engineering DoD for applicable production-code changes:

- requested scope/acceptance criteria implemented;
- unit tests for new production Go logic/code segments and new APIs (or an explicit narrow justified exception with stronger coverage);
- regression test for bug fixes when practical;
- applicable automated tests pass;
- no unresolved P0/P1 finding from the current change;
- API/env/config/migration/deployment/architecture documentation updated if affected.

For `mr_ready` or higher, the configured Git-delivery evidence is checked against the **exact current HEAD**: CI pipeline/checks, minimum approvals (default `1`), blocking discussions and merge conflicts when provider access supports them.

For `staging_validated` / `release_ready`, the following become required only when applicable by repository policy/task owner:

- intended revision deployed to staging;
- manual testing against acceptance criteria;
- no known critical/high-priority bug attributable to the staged change;
- demonstration to the product owner/requester when they require it.

Manual testing, staging deployment, human approval and feature demos are **human/provider evidence**. An AI agent cannot manufacture those claims. A small internal `code_complete` refactor can legitimately mark them `N/A`.

See `docs/definition-of-done.md`.

## Assurance levels

The kit distinguishes evidence from permission:

```text
IMPLEMENTED
  -> LOCALLY VERIFIED
  -> TESTED
  -> INDEPENDENTLY REVIEWED
  -> SAFE TO COMMIT
  -> SAFE TO MERGE
  -> PRODUCTION READY
```

If an engineer intentionally skips a stage, the system obeys but records the skip and may lower the maximum assurance it can honestly claim.

`SAFE TO MERGE` does not mean the agent is authorized to merge.

---

## Repository knowledge lifecycle

The agent should not rediscover stable facts every task.

```text
Task
 -> read profile + architecture + valid fact cache
 -> compare relevant source paths / commits
 -> reuse unchanged facts
 -> refresh only invalidated sections
 -> perform targeted exploration
```

Cache architectural facts, source-of-truth relationships, major stacks, stable commands, and deployment constraints. Never cache authorization or transient delivery state.

---

## Installation

Use a reviewed/tagged checkout of the central kit. Always dry-run first.

```bash
# from the kit checkout
./scripts/validate-kit.sh
./scripts/install.sh --target /path/to/service
```

Optional preset seed:

```bash
./scripts/install.sh --target /path/to/service --profile api-service
```

After reviewing the dry-run:

```bash
./scripts/install.sh --target /path/to/service --apply
```

If the team uses native agent roles, preview/apply a thin adapter without changing the shared workflow:

```bash
# One platform
./scripts/install.sh --target /path/to/service --adapter kilocode
./scripts/install.sh --target /path/to/service --adapter kilocode --apply

# Multiple tools in the same repository
./scripts/install.sh --target /path/to/service --adapter all --apply
```

`all` installs conflict-safe wrappers for KiloCode, OpenCode and Codex. Existing vendor-agent files are preserved.

The installer preserves repository-owned `AGENTS.md`, `repo-profile.yaml`, `ARCHITECTURE.md`, repository facts, and non-kit same-name skills. Shared skills installed by the kit carry an ownership marker so future upgrades can refresh **only kit-owned** copies:

```bash
./scripts/install.sh \
  --target /path/to/service \
  --update-owned-skills \
  --apply
```

After installation, run `.ai-engineering-kit/MASTER-BOOTSTRAP-PROMPT.md` once. The bootstrap agent audits existing local/global skills and repository conventions before proposing integration.

See `INSTALLATION.md`.

## Git/versioning

Treat this kit as an internal product and use Semantic Versioning.

- PATCH: bug/docs/safety corrections with no intended workflow incompatibility;
- MINOR: backward-compatible capability/skill/profile additions;
- MAJOR: incompatible schema/workflow/installer/assurance changes.

Services should adopt reviewed tags, not blindly follow `main`.

Example:

```bash
git checkout v1.4.0
./scripts/install.sh --target ~/work/my-service
./scripts/install.sh --target ~/work/my-service --apply
```

---

## What belongs where?

```text
Universal engineering behavior -> shared kit
Go-specific engineering behavior -> Go layer
Reusable stack behavior -> shared specialist skill
Service architecture/priorities -> repo-profile.yaml + ARCHITECTURE.md
Service-specific behavior -> repo-local skill/AGENTS.md
Stable discovered facts -> repository-facts cache
Per-task choices/authority/evidence -> Task Contract
```

Do not edit the staged `.ai-engineering-kit/` copy for service-specific logic. Put service customizations in repository-owned files/skills.
