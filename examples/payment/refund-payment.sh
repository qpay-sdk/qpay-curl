#!/usr/bin/env bash
#
# QPay V2 - Refund Payment
# DELETE /v2/payment/refund/{id}
#
# Refunds a payment by its payment ID.
# Only applicable to card transactions.
# Optionally include a callback URL and note.
#
# Usage:
#   source helpers/auth.sh
#   PAYMENT_ID="your_payment_id" ./examples/payment/refund-payment.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the payment ID to refund
PAYMENT_ID="${PAYMENT_ID:-your_payment_id_here}"

curl -v -X DELETE "${QPAY_BASE_URL}/v2/payment/refund/${PAYMENT_ID}" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -d '{
        "callback_url": "'"${QPAY_CALLBACK_URL}"'",
        "note": "Payment refunded by merchant"
    }'

# Response: HTTP 200 on success (empty body)
