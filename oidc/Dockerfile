FROM ghcr.io/dexidp/dex:v2.46.0-alpine

COPY config.yaml /etc/dex/identity-provider-fixtures.yaml
COPY --chmod=0555 entrypoint.sh /usr/local/bin/identity-provider-fixtures-entrypoint

USER root
RUN apk add --no-cache gettext-envsubst
USER dex

ENV OIDC_ISSUER=http://127.0.0.1:55556/dex \
    OIDC_REDIRECT_URI=http://127.0.0.1:5173/callback

EXPOSE 5556

ENTRYPOINT ["/usr/local/bin/identity-provider-fixtures-entrypoint"]
