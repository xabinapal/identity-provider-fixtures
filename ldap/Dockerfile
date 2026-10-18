FROM debian:bookworm-slim

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ldap-utils \
      slapd \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/ldap/* /etc/ldap/slapd.d/* \
    && mkdir -p /etc/ldap/certs

COPY slapd.conf /etc/ldap/slapd.conf
COPY bootstrap.ldif /usr/local/share/identity-provider-fixtures/bootstrap.ldif
COPY --chmod=0444 certs/fixture.crt /etc/ldap/certs/fixture.crt
COPY --chown=openldap:openldap --chmod=0400 certs/fixture.key /etc/ldap/certs/fixture.key
COPY --chmod=0555 entrypoint.sh /usr/local/bin/identity-provider-fixtures-entrypoint

EXPOSE 389 636

ENTRYPOINT ["/usr/local/bin/identity-provider-fixtures-entrypoint"]
