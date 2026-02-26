#!/usr/bin/env bash
#
# QPay Auth Helper
# Sources .env credentials and obtains an access token.
# Usage:
#   source helpers/auth.sh
#   echo "$ACCESS_TOKEN"
#
# Requires: jq

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source .env file
if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo "Error: .env file not found at $PROJECT_DIR/.env"
    echo "Copy .env.example to .env and fill in your credentials."
    exit 1
fi

source "$PROJECT_DIR/.env"

# Validate required variables
if [ -z "${QPAY_BASE_URL:-}" ] || [ -z "${QPAY_USERNAME:-}" ] || [ -z "${QPAY_PASSWORD:-}" ]; then
    echo "Error: QPAY_BASE_URL, QPAY_USERNAME, and QPAY_PASSWORD must be set in .env"
    exit 1
fi

# Check for jq
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install it with: brew install jq (macOS) or apt-get install jq (Linux)"
    exit 1
fi

echo "Authenticating with QPay API..."

RESPONSE=$(curl -s -X POST "${QPAY_BASE_URL}/v2/auth/token" \
    -u "${QPAY_USERNAME}:${QPAY_PASSWORD}")

# Parse access_token from response
ACCESS_TOKEN=$(echo "$RESPONSE" | jq -r '.access_token // empty')
REFRESH_TOKEN=$(echo "$RESPONSE" | jq -r '.refresh_token // empty')

if [ -z "$ACCESS_TOKEN" ]; then
    echo "Error: Failed to obtain access token."
    echo "Response: $RESPONSE"
    exit 1
fi

export ACCESS_TOKEN
export REFRESH_TOKEN

echo "Authentication successful. ACCESS_TOKEN and REFRESH_TOKEN exported."
