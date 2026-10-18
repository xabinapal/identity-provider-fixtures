#!/bin/sh
set -eu

envsubst '${OIDC_ISSUER} ${OIDC_REDIRECT_URI}' \
  < /etc/dex/identity-provider-fixtures.yaml \
  > /tmp/identity-provider-fixtures.yaml

exec dex serve /tmp/identity-provider-fixtures.yaml
