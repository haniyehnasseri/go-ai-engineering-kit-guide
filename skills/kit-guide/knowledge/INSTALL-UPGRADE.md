# Installation and Upgrade Cheatsheet

## New v1.4.0 installation

```bash
unzip go-ai-engineering-kit-v1.4.0.zip
cd go-ai-engineering-kit-v1.4.0
make validate
make test

# Preview only
./scripts/install.sh --target /path/to/service --adapter all

# Apply after review
./scripts/install.sh --target /path/to/service --adapter all --apply
```

Optional profile seed:

```bash
./scripts/install.sh \
  --target /path/to/service \
  --profile data-service \
  --adapter all \
  --apply
```

Presets: `api-service`, `data-service`, `event-service`, `latency-critical-service`, `search-service`.

## One adapter only

Use the adapter name supported by the installer instead of `all`, e.g. KiloCode, Codex, or OpenCode according to the installed release documentation.

## First bootstrap after installation

Open the repository in the chosen agent and ask it to execute:

```text
.ai-engineering-kit/MASTER-BOOTSTRAP-PROMPT.md
```

For the first repository, stop after its audit/integration proposal and review the plan before structural integration.

## Upgrade from v1.3.0 to v1.4.0

From a v1.4.0 kit checkout/archive:

```bash
./scripts/install.sh --target /path/to/service --adapter all
```

Review dry-run, then:

```bash
./scripts/install.sh \
  --target /path/to/service \
  --update-owned-skills \
  --adapter all \
  --apply
```

Repository-owned files/custom Skills should remain preserved by default. Rerun the bootstrap/audit to reconcile v1.4.0 orchestration/task-state additions.

## General upgrade rule

Never blindly overwrite repo-owned files. Dry-run, inspect conflicts, refresh only kit-owned components, reconcile schema/policy changes, validate, then commit deliberately.
