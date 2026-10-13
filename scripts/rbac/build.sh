#!/usr/bin/env bash
# Build the reviewable opt-in components with already installed dependencies.
set -euo pipefail
rbac_repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
cd "$rbac_repo/webconsole"
mkdir -p bin
go build -o bin/rbac-bootstrap ./cmd/rbac-bootstrap
go build -o bin/rbac-demo ./cmd/rbac-demo
go build -o bin/webconsole ./server.go
cd frontend
yarn build
