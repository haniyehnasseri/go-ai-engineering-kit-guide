# Version Matrix

| Version | Purpose / notable change | Support guidance |
|---|---|---|
| `v1.0.0` | Initial generic Go microservice engineering-kit baseline | Historical. Upgrade unless pinned for a reason. |
| `v1.0.1` | Installation guide + safer installer hardening | Historical. |
| `v1.1.0` | Git repository lifecycle, SemVer, tags, CI/release packaging | Historical; concepts retained in later versions. |
| `v1.2.0` | Repository context, Git delivery evidence, stack specialists, observability design | Do not prefer this release; `v1.2.1` corrected semantics/completeness. |
| `v1.2.1` | Sayeh=Grafana correction, error-contract clarification, cross-stack honesty, risk scores, specialist package completeness | Minimum recommended in the 1.2 line. |
| `v1.3.0` | Senior Go implementation/code-quality/dependency skills; applicability-aware delivery-target DoD | Good stable pre-orchestration release. |
| `v1.4.0` | Vendor-neutral orchestration, machine task state/gate, KiloCode/OpenCode/Codex thin adapters | **Current recommended release.** |

## Default recommendation

Use `v1.4.0` for new installations unless a repository has a specific compatibility constraint.

## Important correction chain

`v1.2.0` → `v1.2.1` is not just feature growth. `v1.2.1` corrected/documented several semantics and fixed package completeness, so do not recommend staying on `v1.2.0` without a reason.

## Version-specific answering rule

When a user asks about a specific version:

1. answer using that version's exact files when available;
2. use this matrix only for high-level differences;
3. if exact command/schema behavior is unknown, ask for the archive/tag instead of projecting latest behavior backward.
