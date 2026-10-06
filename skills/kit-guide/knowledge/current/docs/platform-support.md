# Platform Support

The core is vendor-neutral. Current adapters are thin wrappers around canonical roles.

| Capability | Portable core | KiloCode | OpenCode | Codex |
|---|---:|---:|---:|---:|
| AGENTS/repo policy | yes | yes | via repo instructions | yes |
| Shared Agent Skills | yes where supported | yes | yes | yes (`.agents/skills`) |
| Task Contract | yes | yes | yes | yes |
| Machine workflow state/gate | yes | yes | yes | yes |
| Primary + independent subagents | fallback fresh passes | yes | yes | yes where runtime exposes subagents |
| Per-role edit/tool restrictions | no | yes | yes | partial/different sandbox semantics |
| Deterministic tests/scripts | yes | yes | yes | yes |
| CI/MR hard gates | yes | yes | yes | yes |

Do not weaken the core workflow because one runtime has fewer agent controls. Use the portable fallback and state the limitation.
