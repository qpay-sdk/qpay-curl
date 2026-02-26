#!/usr/bin/env bash
#
# QPay V2 - Create Simple Invoice
# POST /v2/invoice
#
# Creates a simple invoice with minimal required fields.
# This is the easiest way to create an invoice.
#
# Usage:
#   source helpers/auth.sh
#   ./examples/invoice/create-simple.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

curl -v -X POST "${QPAY_BASE_URL}/v2/invoice" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -d '{
        "invoice_code": "'"${QPAY_INVOICE_CODE}"'",
        "sender_invoice_no": "INV-20260226-001",
        "invoice_receiver_code": "terminal",
        "invoice_description": "Payment for order #001",
        "amount": 1000.00,
        "callback_url": "'"${QPAY_CALLBACK_URL}"'"
    }'

# Response:
# {
#   "invoice_id": "abc123...",
#   "qr_text": "...",
#   "qr_image": "base64_encoded_qr_image...",
#   "qPay_shortUrl": "https://qpay.mn/shorturl",
#   "urls": [
#     {
#       "name": "Khan Bank",
#       "description": "Khan Bank app",
#       "logo": "https://...",
#       "link": "https://..."
#     }
#   ]
# }
