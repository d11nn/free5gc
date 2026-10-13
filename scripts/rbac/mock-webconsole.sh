#!/usr/bin/env bash
# Opt-in development launcher. No installs, sudo, systemd or OS changes.
set -euo pipefail
rbac_repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
export FREE5GC_DEPLOYMENT_MODE=mock
export FREE5GC_DEPLOYMENT_HOST=${FREE5GC_DEPLOYMENT_HOST:-$(hostname)}
export FREE5GC_DEPLOYMENT_COMMIT=$(git -C "$rbac_repo" rev-parse HEAD)
export FREE5GC_DEPLOYMENT_SCRIPT_HASH=$(sha256sum "$rbac_repo/quick-setup.sh" | cut -d ' ' -f 1)
cd "$rbac_repo/webconsole"
exec ./bin/webconsole "$@"
