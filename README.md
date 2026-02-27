# qpay-curl

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

QPay V2 API cURL examples. Ready-to-use shell scripts for authentication, invoice creation, payment operations, and ebarimt (electronic tax receipt) support.

## Prerequisites

- [cURL](https://curl.se/)
- [jq](https://jqlang.github.io/jq/) (for the auth helper)
- QPay merchant credentials

## Setup

1. Clone the repository:

```bash
git clone https://github.com/qpay-sdk/qpay-curl.git
cd qpay-curl
```

2. Create a `.env` file with your credentials:

```bash
QPAY_BASE_URL=https://merchant.qpay.mn
QPAY_USERNAME=your_username
QPAY_PASSWORD=your_password
QPAY_INVOICE_CODE=your_invoice_code
QPAY_CALLBACK_URL=https://example.com/callback
```

3. Authenticate:

```bash
source helpers/auth.sh
```

This exports `ACCESS_TOKEN` and `REFRESH_TOKEN` to your shell session.

## Examples

### Authentication

```bash
# Get access token (Basic Auth)
./examples/auth/get-token.sh

# Refresh token
source helpers/auth.sh   # sets REFRESH_TOKEN
./examples/auth/refresh-token.sh
```

### Invoice

```bash
# Create a simple invoice (minimal fields)
source helpers/auth.sh
./examples/invoice/create-simple.sh

# Create a full invoice (all options, line items, transactions)
./examples/invoice/create-invoice.sh

# Cancel an invoice
INVOICE_ID="your_invoice_id" ./examples/invoice/cancel-invoice.sh
```

### Payment

```bash
# Check payment status for an invoice
INVOICE_ID="your_invoice_id" ./examples/payment/check-payment.sh

# Get payment details
PAYMENT_ID="your_payment_id" ./examples/payment/get-payment.sh

# List payments with date range
./examples/payment/list-payments.sh

# Cancel a payment (card only)
PAYMENT_ID="your_payment_id" ./examples/payment/cancel-payment.sh

# Refund a payment (card only)
PAYMENT_ID="your_payment_id" ./examples/payment/refund-payment.sh
```

### Ebarimt (Electronic Tax Receipt)

```bash
# Create ebarimt for a payment
PAYMENT_ID="your_payment_id" ./examples/ebarimt/create-ebarimt.sh

# Cancel ebarimt
PAYMENT_ID="your_payment_id" ./examples/ebarimt/cancel-ebarimt.sh
```

## Project Structure

```
qpay-curl/
├── .env.example
├── helpers/
│   └── auth.sh              # Auth helper (exports ACCESS_TOKEN)
└── examples/
    ├── auth/
    │   ├── get-token.sh      # POST /v2/auth/token
    │   └── refresh-token.sh  # POST /v2/auth/refresh
    ├── invoice/
    │   ├── create-simple.sh  # POST /v2/invoice (minimal)
    │   ├── create-invoice.sh # POST /v2/invoice (full)
    │   └── cancel-invoice.sh # DELETE /v2/invoice/{id}
    ├── payment/
    │   ├── check-payment.sh  # POST /v2/payment/check
    │   ├── get-payment.sh    # GET /v2/payment/{id}
    │   ├── list-payments.sh  # POST /v2/payment/list
    │   ├── cancel-payment.sh # DELETE /v2/payment/cancel/{id}
    │   └── refund-payment.sh # DELETE /v2/payment/refund/{id}
    └── ebarimt/
        ├── create-ebarimt.sh # POST /v2/ebarimt_v3/create
        └── cancel-ebarimt.sh # DELETE /v2/ebarimt_v3/{id}
```

## API Endpoints

| Method | Endpoint | Script |
|--------|----------|--------|
| `POST` | `/v2/auth/token` | `auth/get-token.sh` |
| `POST` | `/v2/auth/refresh` | `auth/refresh-token.sh` |
| `POST` | `/v2/invoice` | `invoice/create-simple.sh`, `invoice/create-invoice.sh` |
| `DELETE` | `/v2/invoice/{id}` | `invoice/cancel-invoice.sh` |
| `POST` | `/v2/payment/check` | `payment/check-payment.sh` |
| `GET` | `/v2/payment/{id}` | `payment/get-payment.sh` |
| `POST` | `/v2/payment/list` | `payment/list-payments.sh` |
| `DELETE` | `/v2/payment/cancel/{id}` | `payment/cancel-payment.sh` |
| `DELETE` | `/v2/payment/refund/{id}` | `payment/refund-payment.sh` |
| `POST` | `/v2/ebarimt_v3/create` | `ebarimt/create-ebarimt.sh` |
| `DELETE` | `/v2/ebarimt_v3/{id}` | `ebarimt/cancel-ebarimt.sh` |

## Related

- [QPay Docs](https://qpay-sdk.github.io/qpay-docs/) — Full documentation
- [qpay-js](https://github.com/qpay-sdk/qpay-js) — JavaScript SDK
- [qpay-py](https://github.com/qpay-sdk/qpay-py) — Python SDK
- [qpay-go](https://github.com/qpay-sdk/qpay-go) — Go SDK

## License

MIT
