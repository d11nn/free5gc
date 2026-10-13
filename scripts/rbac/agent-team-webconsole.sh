#!/usr/bin/env bash
# Real Codex team + existing RBAC; all installation tools produce plans only.
set -euo pipefail
rbac_repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
export FREE5GC_TEAM_MODE=codex
export FREE5GC_TEAM_RUNTIME="$rbac_repo/webconsole/tools/agent_team.py"
exec bash "$rbac_repo/scripts/rbac/mock-webconsole.sh" "$@"
