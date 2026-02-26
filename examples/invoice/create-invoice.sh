#!/usr/bin/env bash
#
# QPay V2 - Create Invoice (Full)
# POST /v2/invoice
#
# Creates an invoice with full options including sender/receiver data,
# transactions, line items, and optional settings.
#
# Usage:
#   source helpers/auth.sh
#   ./examples/invoice/create-invoice.sh

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
        "sender_branch_code": "BRANCH01",
        "sender_branch_data": {
            "register": "AA12345678",
            "name": "Sender Company",
            "email": "sender@example.com",
            "phone": "99001122",
            "address": {
                "city": "Ulaanbaatar",
                "district": "Sukhbaatar",
                "street": "Peace Avenue",
                "building": "Building 1",
                "address": "Suite 100",
                "zipcode": "14200",
                "longitude": "106.9057",
                "latitude": "47.9221"
            }
        },
        "sender_staff_data": {
            "name": "Staff Name",
            "email": "staff@example.com",
            "phone": "99112233"
        },
        "sender_staff_code": "STAFF01",
        "invoice_receiver_code": "terminal",
        "invoice_receiver_data": {
            "register": "BB87654321",
            "name": "Receiver Company",
            "email": "receiver@example.com",
            "phone": "88001122",
            "address": {
                "city": "Ulaanbaatar",
                "district": "Bayangol"
            }
        },
        "invoice_description": "Payment for services - full invoice",
        "enable_expiry": "false",
        "allow_partial": false,
        "minimum_amount": null,
        "allow_exceed": false,
        "maximum_amount": null,
        "amount": 1000.00,
        "callback_url": "'"${QPAY_CALLBACK_URL}"'",
        "sender_terminal_code": null,
        "allow_subscribe": false,
        "note": "Full invoice example with all fields",
        "transactions": [
            {
                "description": "Service payment",
                "amount": "1000.00",
                "accounts": [
                    {
                        "account_bank_code": "050000",
                        "account_number": "1234567890",
                        "iban_number": "",
                        "account_name": "Account Name",
                        "account_currency": "MNT",
                        "is_default": true
                    }
                ]
            }
        ],
        "lines": [
            {
                "tax_product_code": "1234567",
                "line_description": "Service Item 1",
                "line_quantity": "1.00",
                "line_unit_price": "1000.00",
                "note": "Line item note",
                "discounts": [],
                "surcharges": [],
                "taxes": [
                    {
                        "tax_code": "VAT",
                        "description": "Value Added Tax",
                        "amount": 100.00,
                        "note": "10% VAT"
                    }
                ]
            }
        ]
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
