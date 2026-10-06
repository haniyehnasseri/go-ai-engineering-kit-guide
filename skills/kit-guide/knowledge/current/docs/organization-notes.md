# Organization Integration Notes

These are organization-level defaults layered on top of the generic kit. Repository evidence/profile still decides whether a capability is relevant to a task.

1. **Per-role/subagent models** — when the coding platform supports it, Task Intake may ask the engineer for planner/explorer/implementer/tester/reviewer model overrides. If none are supplied, use configured platform defaults; do not block.
2. **Git delivery evidence** — when read-only GitLab access is configured, record exact-HEAD pipeline/check status, approvals when available, unresolved discussions and mergeability. Evidence never grants merge authority.
3. **Sayeh** — Sayeh is the organization's Grafana instance/name. Review metrics against Sayeh dashboards/alerts/SLOs when relevant. Do not model Sayeh as a separate checker unless an actual distinct API/command is introduced later.
4. **Stack specialists** — activate PostgreSQL/Kafka/Redis/Elasticsearch reviewers only when the service/task touches them.
5. **Cross-stack** — today the kit can analyze cross-stack consistency/failure semantics, but cannot generically prove cross-stack backward compatibility. Mark missing compatibility evidence as NOT VERIFIED/INSUFFICIENT EVIDENCE and request manual/integration evidence where needed.
6. **Environment compatibility** — env/config is backward compatible by default. When configured, inspect the deployment/config repository (e.g. `tw-applications`) for definitions/rollout compatibility.
7. **Client error contracts** — Dezhban endpoints use `https://git.simra.cloud/module/commons` / `git.simra.cloud/module/commons/errors` conventions. Hormuz endpoints should preserve existing response shape while returning readable safe client messages and correct HTTP status codes. Internal errors may be fully logged server-side, but raw internal details must not be returned to clients.
8. **Deployment constraints** — durable rollout/rollback constraints belong in repository docs/README and must be updated when a task changes them.
9. **Stable knowledge** — use provenance-backed repository facts and `ARCHITECTURE.md` to avoid full repo rescans. Refresh only invalidated sections; source code/config always wins.
10. **Architecture notes** — lead/team notes are human-owned. AI may add verified details or update affected sections, but must preserve human decisions and mark unknowns instead of inventing them.
