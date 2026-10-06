# Client Error Contracts

Canonical shared module:

- repository: `https://git.simra.cloud/module/commons`
- Go package: `git.simra.cloud/module/commons/errors`

## Dezhban endpoints

Use the shared `commons/errors` conventions as the canonical client-error model where Dezhban endpoints use that stack:

- `TelewebionError` for structured known/business errors;
- `ErrorResponse` shape;
- localization keys and project overrides;
- correct HTTP status mapping;
- GORM translation helpers where appropriate.

### Internal error safety

Internal application errors may be logged fully on the server (subject to secret/PII policies), but clients must receive a sanitized/readable error.

The current `HandleError` unknown-error fallback returns a generic top-level 500 message **and also places `err.Error()` into the client-visible `errors[]` item**. Therefore, a reviewer must not assume that blindly passing arbitrary internal errors to `HandleError` is client-safe. Flag such paths unless the library/service version sanitizes them or the service wraps/translates internal errors before rendering.

## Hormuz endpoints

Hormuz-style endpoints may use a different existing response shape. Preserve that shape unless an approved contract change says otherwise, but ensure client failures have:

- readable, useful, non-sensitive messages;
- correct HTTP status codes;
- existing machine-readable fields/shape when clients depend on them;
- compatibility with old clients by default.

## General conversion rule

```text
internal application error
    +--> full server log/trace (safe logging policy)
    +--> client conversion
           +--> Dezhban: commons/errors structured convention
           +--> Hormuz: readable message + proper status + existing response shape
```

Never expose raw DB, network, filesystem, stack, token, SQL, Elasticsearch, Kafka, or implementation details merely because they exist in `err.Error()`.
