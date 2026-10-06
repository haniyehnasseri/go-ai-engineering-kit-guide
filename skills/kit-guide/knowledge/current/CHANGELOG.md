# Changelog

## 1.4.0

Final cross-platform orchestration consolidation release (for current adoption).

- made the engineering workflow vendor-neutral across KiloCode, Codex, OpenCode and other coding agents;
- added canonical platform-neutral role prompts under `roles/`;
- added deterministic `workflowctl.py` task-state/gate so accepted required stages cannot silently disappear;
- added orchestration policy and machine-readable task-state template;
- added KiloCode, OpenCode and Codex thin agent adapters with no model IDs and least-privilege/read-only reviewer defaults where supported;
- added conflict-safe `install-adapter.sh` plus `--adapter` support in the main installer;
- added explicit fallback to fresh independent review passes when native subagents/permissions are unavailable;
- documented portable vs native vs CI enforcement and current platform capability differences;
- added optional GitLab consumer CI workflow-state gate example;
- updated Task Intake, DoD, profile schema, bootstrap prompt and repository policy to resolve `auto` stages and enforce the accepted Task Contract;
- extended validation/smoke tests for workflow state, adapters, model neutrality and cross-platform package completeness.

## 1.3.0

Senior Go implementation + Definition-of-Done enrichment release.

- added `go-senior-implementation`, synthesizing durable idiomatic Go guidance from official Go sources, Google/Uber guidance and `spf13/go-skills` while preserving repository architecture over generic layout opinions;
- added focused `go-code-quality-reviewer` for maintainability/idioms without duplicating production-risk specialists;
- added `go-dependency-reviewer` for `go.mod`/`go.sum`, toolchain, new modules, `replace`/`exclude`, vulnerability and reproducibility changes;
- added Go engineering source/precedence documentation and reviewer eval cases;
- expanded production-test guidance and DoD to require unit tests for new non-trivial Go behavior/new APIs unless a justified exception is recorded;
- modeled delivery targets (`code_complete`, `mr_ready`, `staging_validated`, `release_ready`) so staging/manual/product-owner steps apply only when needed;
- added configurable DoD for exact-HEAD CI, minimum one MR approval by default, no unresolved P0/P1, documentation updates, staging/manual acceptance and optional feature demo;
- made human-only DoD evidence non-fabricable by agents;
- restored safe installer upgrade semantics from earlier releases (`--profile`, kit-owned skill markers, `--update-owned-skills`, strict Git-root checks, dry-run-first behavior);
- restored installer/release smoke tests and reproducible Git-based release packaging;
- strengthened kit validation to check shell syntax, YAML, required skills/docs and package completeness.

## 1.2.1

Correction/completeness release.

- clarified Sayeh as the Grafana instance/name rather than an independent observability checker;
- replaced claimed automated cross-stack backward-compatibility review with cross-stack consistency analysis plus explicit manual/integration evidence states;
- documented canonical Dezhban shared error source `https://git.simra.cloud/module/commons` / `git.simra.cloud/module/commons/errors`;
- split client-error review between Dezhban shared structured errors and Hormuz readable-message + correct-HTTP-status + existing-shape behavior;
- added explicit rule that internal errors may be logged fully server-side but must be sanitized/translated before client responses;
- flagged current `commons/errors.HandleError` unknown-error fallback as potentially exposing raw `err.Error()` in client `errors[]`;
- documented exact meaning of repo-profile risk scores 0..5;
- restored/added the specialist SKILL.md files and supporting scripts/docs promised by the 1.2 release documentation.

## 1.2.0

Repository-context, delivery-evidence and stack-specialist design release.

## 1.1.0

Git/versioning release.
