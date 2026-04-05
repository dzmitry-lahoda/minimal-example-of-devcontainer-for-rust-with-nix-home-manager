#!/usr/bin/env bash
set -euo pipefail
/nix/var/nix/profiles/default/bin/nix-daemon >/tmp/nix-daemon.log 2>&1 &
exec "$@"