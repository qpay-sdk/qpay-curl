#!/usr/bin/env bash
#
# QPay V2 - Cancel Invoice
# DELETE /v2/invoice/{id}
#
# Cancels an existing invoice by its invoice ID.
#
# Usage:
#   source helpers/auth.sh
#   INVOICE_ID="your_invoice_id" ./examples/invoice/cancel-invoice.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source .env
source "$PROJECT_DIR/.env"

if [ -z "${ACCESS_TOKEN:-}" ]; then
    echo "Error: ACCESS_TOKEN is not set. Run 'source helpers/auth.sh' first."
    exit 1
fi

# Set the invoice ID to cancel
INVOICE_ID="${INVOICE_ID:-your_invoice_id_here}"

curl -v -X DELETE "${QPAY_BASE_URL}/v2/invoice/${INVOICE_ID}" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}"

# Response: HTTP 200 on success (empty body)
