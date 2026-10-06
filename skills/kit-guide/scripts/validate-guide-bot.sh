#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
required=(
  VERSION README.md BOT-SYSTEM-PROMPT.md CHAT-STARTER.md
  knowledge/VERSION-MATRIX.md knowledge/FAQ.md knowledge/INSTALL-UPGRADE.md
  knowledge/TROUBLESHOOTING.md knowledge/version-registry.yaml
  .agents/skills/kit-guide/SKILL.md scripts/sync-kit-knowledge.sh
)
for rel in "${required[@]}"; do
  [[ -f "$ROOT/$rel" ]] || { echo "missing: $rel" >&2; exit 1; }
done
python3 - <<'PY' "$ROOT/knowledge/version-registry.yaml"
import sys, yaml
p=sys.argv[1]
with open(p, 'r', encoding='utf-8') as f:
    d=yaml.safe_load(f)
assert d['latest_stable'] == '1.4.0'
assert any(r['version']=='1.4.0' and r['status']=='current' for r in d['releases'])
print('version registry: PASS')
PY
bash -n "$ROOT/scripts/sync-kit-knowledge.sh"
echo "Guide Bot validation: PASS"
