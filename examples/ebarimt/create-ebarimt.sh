#!/usr/bin/env bash
#
# QPay V2 - Create Ebarimt
# POST /v2/ebarimt_v3/create
#
# Creates an ebarimt (electronic tax receipt) for a completed payment.
#
# ebarimt_receiver_type:
#   - "83" = Individual (person)
#   - "84" = Organization (company, uses register number)
#
# Usage:
#   source helpers/auth.sh
#   PAYMENT_ID="your_payment_id" ./examples/ebarimt/create-ebarimt.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the payment ID to create ebarimt for
PAYMENT_ID="${PAYMENT_ID:-your_payment_id_here}"

curl -v -X POST "${QPAY_BASE_URL}/v2/ebarimt_v3/create" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -d '{
        "payment_id": "'"${PAYMENT_ID}"'",
        "ebarimt_receiver_type": "83",
        "ebarimt_receiver": "",
        "district_code": "34",
        "classification_code": ""
    }'

# For organization ebarimt, use:
# {
#     "payment_id": "your_payment_id",
#     "ebarimt_receiver_type": "84",
#     "ebarimt_receiver": "1234567",     <-- company register number
#     "district_code": "34",
#     "classification_code": ""
# }

# Response:
# {
#   "id": "...",
#   "ebarimt_by": "...",
#   "g_wallet_id": "...",
#   "g_wallet_customer_id": "...",
#   "ebarimt_receiver_type": "83",
#   "ebarimt_receiver": "",
#   "ebarimt_district_code": "34",
#   "ebarimt_bill_type": "...",
#   "g_merchant_id": "...",
#   "merchant_branch_code": "...",
#   "merchant_terminal_code": null,
#   "merchant_staff_code": null,
#   "merchant_register_no": "...",
#   "g_payment_id": "...",
#   "paid_by": "...",
#   "object_type": "INVOICE",
#   "object_id": "...",
#   "amount": "1000.00",
#   "vat_amount": "100.00",
#   "city_tax_amount": "0.00",
#   "ebarimt_qr_data": "...",
#   "ebarimt_lottery": "...",
#   "note": null,
#   "barimt_status": "CREATED",
#   "barimt_status_date": "2026-02-26T10:00:00",
#   "tax_type": "...",
#   "status": true,
#   "barimt_items": [...],
#   "barimt_transactions": [...],
#   "barimt_histories": [...]
# }
