#!/usr/bin/env bash
#
# QPay V2 - Get Payment Details
# GET /v2/payment/{id}
#
# Retrieves detailed information about a specific payment by its ID.
#
# Usage:
#   source helpers/auth.sh
#   PAYMENT_ID="your_payment_id" ./examples/payment/get-payment.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the payment ID to retrieve
PAYMENT_ID="${PAYMENT_ID:-your_payment_id_here}"

curl -v -X GET "${QPAY_BASE_URL}/v2/payment/${PAYMENT_ID}" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}"

# Response:
# {
#   "payment_id": "...",
#   "payment_status": "PAID",
#   "payment_fee": "0.00",
#   "payment_amount": "1000.00",
#   "payment_currency": "MNT",
#   "payment_date": "2026-02-26T10:00:00",
#   "payment_wallet": "qpay",
#   "transaction_type": "P2P",
#   "object_type": "INVOICE",
#   "object_id": "...",
#   "next_payment_date": null,
#   "next_payment_datetime": null,
#   "card_transactions": [],
#   "p2p_transactions": [
#     {
#       "transaction_bank_code": "050000",
#       "account_bank_code": "050000",
#       "account_bank_name": "Khan Bank",
#       "account_number": "1234567890",
#       "status": "SUCCESS",
#       "amount": "1000.00",
#       "currency": "MNT",
#       "settlement_status": "SETTLED"
#     }
#   ]
# }
