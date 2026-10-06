#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: sync-kit-knowledge.sh --kit-dir /path/to/go-ai-engineering-kit

Copies a safe documentation snapshot from a kit checkout into knowledge/current/.
It does not modify the engineering kit.
USAGE
}

KIT_DIR=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --kit-dir) KIT_DIR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

[[ -n "$KIT_DIR" ]] || { echo "--kit-dir is required" >&2; exit 2; }
[[ -f "$KIT_DIR/VERSION" ]] || { echo "Not a kit checkout: missing VERSION" >&2; exit 1; }

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)
DEST="$ROOT/knowledge/current"
rm -rf "$DEST"
mkdir -p "$DEST/docs" "$DEST/core"

copy_if_present() {
  local src="$1" dst="$2"
  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
  fi
}

for f in VERSION README.md INSTALLATION.md CHANGELOG.md RELEASING.md MASTER-BOOTSTRAP-PROMPT.md; do
  copy_if_present "$KIT_DIR/$f" "$DEST/$f"
done

for f in \
  docs/orchestration-enforcement.md \
  docs/platform-support.md \
  docs/definition-of-done.md \
  docs/risk-scores.md \
  docs/error-contracts.md \
  docs/organization-notes.md \
  docs/go-engineering-guidance.md \
  core/repo-profile.schema.yaml \
  core/workflow-profiles.yaml \
  core/task-contract.template.md \
  core/assurance-levels.md \
  core/orchestration-policy.yaml; do
  copy_if_present "$KIT_DIR/$f" "$DEST/$f"
done

{
  echo "kit_version=$(tr -d '[:space:]' < "$KIT_DIR/VERSION")"
  if git -C "$KIT_DIR" rev-parse HEAD >/dev/null 2>&1; then
    echo "git_commit=$(git -C "$KIT_DIR" rev-parse HEAD)"
  else
    echo "git_commit=unavailable"
  fi
  echo "synced_at_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
} > "$DEST/MANIFEST.txt"

echo "Synced kit knowledge into: $DEST"
cat "$DEST/MANIFEST.txt"
