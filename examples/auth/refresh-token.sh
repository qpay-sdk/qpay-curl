#!/usr/bin/env bash
#
# QPay V2 - Refresh Auth Token
# POST /v2/auth/refresh
#
# Uses a refresh token (Bearer) to obtain a new access token.
# The refresh token is sent in the Authorization header.
#
# Usage:
#   source helpers/auth.sh   # to get REFRESH_TOKEN
#   ./examples/auth/refresh-token.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

# REFRESH_TOKEN should be set from a previous /v2/auth/token call.
# You can source helpers/auth.sh first, or set it manually:
# export REFRESH_TOKEN="your_refresh_token_here"

if [ -z "${REFRESH_TOKEN:-}" ]; then
    echo "Error: REFRESH_TOKEN is not set."
    echo "Run 'source helpers/auth.sh' first or set REFRESH_TOKEN manually."
    exit 1
fi

curl -v -X POST "${QPAY_BASE_URL}/v2/auth/refresh" \
    -H "Authorization: Bearer ${REFRESH_TOKEN}"

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
