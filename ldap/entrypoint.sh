#!/bin/sh
set -eu

mkdir -p /run/slapd /var/lib/ldap
chown -R openldap:openldap /run/slapd /var/lib/ldap

if [ ! -f /var/lib/ldap/data.mdb ]; then
  slapadd -f /etc/ldap/slapd.conf \
    -l /usr/local/share/identity-provider-fixtures/bootstrap.ldif
  chown -R openldap:openldap /var/lib/ldap
fi

exec slapd -f /etc/ldap/slapd.conf \
  -h 'ldap:/// ldaps:///' \
  -u openldap -g openldap -d 0
