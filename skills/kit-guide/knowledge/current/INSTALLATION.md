# Installation and Upgrade Guide

The kit is designed to be installed into many Go microservice repositories without blindly overwriting repository-owned AI configuration.

## 1. Use a reviewed version tag

Clone/check out the central kit repository and select a reviewed release:

```bash
git clone <internal-kit-repository> go-ai-engineering-kit
cd go-ai-engineering-kit
git checkout v1.4.0
```

Validate the kit itself:

```bash
make validate
make test
```

## 2. Dry-run installation

From the kit checkout:

```bash
./scripts/install.sh --target /path/to/service
```

No files are changed. Review:

- existing repository-owned files that will be preserved;
- new shared skills that would be installed;
- conflicts with same-name non-kit skills;
- current kit version.

Optionally seed a starting risk preset:

```bash
./scripts/install.sh \
  --target /path/to/service \
  --profile api-service
```

Available presets:

- `api-service`
- `data-service`
- `event-service`
- `latency-critical-service`
- `search-service`

A preset is only a starting point; the bootstrap workflow must adapt it to the actual repository.

## 3. Apply

```bash
./scripts/install.sh --target /path/to/service --apply
```

or with a preset:

```bash
./scripts/install.sh \
  --target /path/to/service \
  --profile data-service \
  --apply
```

The installer:

- stages the full reviewed kit under `.ai-engineering-kit/`;
- installs non-conflicting shared skills under `.agents/skills/`;
- marks installed shared skills as kit-owned;
- preserves repository-owned `AGENTS.md`, `repo-profile.yaml`, `ARCHITECTURE.md`, `.ai-engineering/repository-facts.yaml` and same-name non-kit skills;
- does not edit product code;
- does not commit, push, merge, deploy or mutate production.


## 3a. Optional native agent adapter

The shared workflow does not depend on any vendor. If your team wants stronger native role isolation, install one or more thin adapters **after a dry-run**:

```bash
# Preview only
./scripts/install-adapter.sh --target /path/to/service --platform kilocode
./scripts/install-adapter.sh --target /path/to/service --platform opencode
./scripts/install-adapter.sh --target /path/to/service --platform codex

# Apply one
./scripts/install-adapter.sh --target /path/to/service --platform kilocode --apply

# Or install all three conflict-safely via the main installer
./scripts/install.sh --target /path/to/service --adapter all --apply
```

Destinations:

```text
KiloCode -> .kilo/agents/
OpenCode -> .opencode/agents/
Codex -> .codex/agents/
```

Existing platform agent files are preserved. The wrappers contain no model IDs. They reference the same canonical roles under `.ai-engineering-kit/roles/`.

If your tool has no supported adapter, use `portable`; the Task Contract, workflow state, Skills, deterministic scripts and CI still work.

## 4. Bootstrap the repository once

Open the service repository with KiloCode, Codex, OpenCode, or another coding agent and instruct it to read and execute:

```text
.ai-engineering-kit/MASTER-BOOTSTRAP-PROMPT.md
```

For the first installation, prefer stopping after the audit/integration proposal so a senior engineer can review how existing local/global skills and `AGENTS.md` will be merged.

The bootstrap should create/improve repository-owned:

```text
AGENTS.md
repo-profile.yaml
ARCHITECTURE.md
.ai-engineering/repository-facts.yaml
```

without replacing useful existing conventions.

## 5. Normal task usage

For standard/high-risk tasks, the bootstrap policy should use the portable task state under `.ai-engineering/tasks/<task-id>/state.json` (unless your repository intentionally disables it). Native subagents/permissions strengthen isolation but are not the source of workflow truth.


After bootstrap, a task can be concise:

```text
Implement TASK-123 using the repository engineering workflow.
```

Task Intake will propose the minimum safe workflow/delivery target if the engineer did not specify them.

Example override:

```text
Workflow: custom
Delivery target: code_complete
specification=off
plan=lightweight
implementation=full
go-code-quality=full
tests=full
compatibility=auto
```

## Upgrading an already-installed repository

Check out the new reviewed kit tag and dry-run:

```bash
./scripts/install.sh --target /path/to/service
```

Existing kit-owned skills are preserved by default. After reviewing the release/change log, explicitly refresh only kit-owned skills:

```bash
./scripts/install.sh \
  --target /path/to/service \
  --update-owned-skills \
  --apply
```

Non-kit same-name skills are never overwritten automatically.

The installed reference version is recorded in:

```text
.ai-engineering-kit/.installed-kit-version
```

After a meaningful upgrade, rerun the bootstrap/audit in update mode so new profile fields/skills can be adopted without destroying repository-specific configuration.

## Other installer options

```text
--skip-skills       stage reference kit only
--allow-non-git     allow intentional non-Git fixture/test target
--adapter NAME      install kilocode/opencode/codex/portable/all adapter
--skip-validation   skip source-kit validation (not recommended)
```

Run:

```bash
./scripts/install.sh --help
```

for current options.
