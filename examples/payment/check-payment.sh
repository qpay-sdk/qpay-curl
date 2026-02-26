#!/usr/bin/env bash
#
# QPay V2 - Check Payment
# POST /v2/payment/check
#
# Checks if a payment has been made for a given invoice.
# Use this to verify payment status after creating an invoice.
#
# Usage:
#   source helpers/auth.sh
#   INVOICE_ID="your_invoice_id" ./examples/payment/check-payment.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the invoice ID to check payment for
INVOICE_ID="${INVOICE_ID:-your_invoice_id_here}"

curl -v -X POST "${QPAY_BASE_URL}/v2/payment/check" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -d '{
        "object_type": "INVOICE",
        "object_id": "'"${INVOICE_ID}"'",
        "offset": {
            "page_number": 1,
            "page_limit": 100
        }
    }'

# Response:
# {
#   "count": 1,
#   "paid_amount": 1000.00,
#   "rows": [
#     {
#       "payment_id": "...",
#       "payment_status": "PAID",
#       "payment_amount": "1000.00",
#       "trx_fee": "0.00",
#       "payment_currency": "MNT",
#       "payment_wallet": "qpay",
#       "payment_type": "P2P",
#       "next_payment_date": null,
#       "next_payment_datetime": null,
#       "card_transactions": [],
#       "p2p_transactions": [...]
#     }
#   ]
# }
