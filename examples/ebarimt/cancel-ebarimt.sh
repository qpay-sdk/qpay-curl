#!/usr/bin/env bash
#
# QPay V2 - Cancel Ebarimt
# DELETE /v2/ebarimt_v3/{id}
#
# Cancels an existing ebarimt (electronic tax receipt) by payment ID.
#
# Usage:
#   source helpers/auth.sh
#   PAYMENT_ID="your_payment_id" ./examples/ebarimt/cancel-ebarimt.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the payment ID whose ebarimt to cancel
PAYMENT_ID="${PAYMENT_ID:-your_payment_id_here}"

curl -v -X DELETE "${QPAY_BASE_URL}/v2/ebarimt_v3/${PAYMENT_ID}" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}"

# Response:
# {
#   "id": "...",
#   "ebarimt_by": "...",
#   "barimt_status": "CANCELLED",
#   "barimt_status_date": "2026-02-26T10:00:00",
#   "status": true,
#   ... (full ebarimt response fields)
# }
