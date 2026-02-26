#!/usr/bin/env bash
#
# QPay V2 - Get Auth Token
# POST /v2/auth/token
#
# Authenticates using Basic Auth (username:password) and returns
# an access token and refresh token.
#
# Usage:
#   ./examples/auth/get-token.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

curl -v -X POST "${QPAY_BASE_URL}/v2/auth/token" \
    -u "${QPAY_USERNAME}:${QPAY_PASSWORD}"

# Response:
# {
#   "token_type": "Bearer",
#   "refresh_expires_in": 3600,
#   "refresh_token": "eyJ...",
#   "access_token": "eyJ...",
#   "expires_in": 600,
#   "scope": "...",
#   "not-before-policy": "...",
#   "session_state": "..."
# }
