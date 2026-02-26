#!/usr/bin/env bash
#
# QPay V2 - List Payments
# POST /v2/payment/list
#
# Returns a paginated list of payments matching the given criteria.
# You can filter by object type, object ID, and date range.
#
# Usage:
#   source helpers/auth.sh
#   ./examples/payment/list-payments.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the invoice ID to list payments for
INVOICE_ID="${INVOICE_ID:-your_invoice_id_here}"

curl -v -X POST "${QPAY_BASE_URL}/v2/payment/list" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -d '{
        "object_type": "INVOICE",
        "object_id": "'"${INVOICE_ID}"'",
        "start_date": "2026-01-01",
        "end_date": "2026-12-31",
        "offset": {
            "page_number": 1,
            "page_limit": 20
        }
    }'

# Response:
# {
#   "count": 1,
#   "rows": [
#     {
#       "payment_id": "...",
#       "payment_date": "2026-02-26T10:00:00",
#       "payment_status": "PAID",
#       "payment_fee": "0.00",
#       "payment_amount": "1000.00",
#       "payment_currency": "MNT",
#       "payment_wallet": "qpay",
#       "payment_name": "...",
#       "payment_description": "...",
#       "qr_code": "...",
#       "paid_by": "...",
#       "object_type": "INVOICE",
#       "object_id": "..."
#     }
#   ]
# }
