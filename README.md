# Identity provider fixtures

Small, disposable OIDC and LDAP servers with preloaded fake users and groups.
The images are for local development and tests only.

## Start

```sh
docker run --rm -d --name idpf-oidc -p 55556:5556 \
  ghcr.io/xabinapal/identity-provider-fixtures/oidc:latest

docker run --rm -d --name idpf-ldap -p 51389:389 -p 51636:636 \
  ghcr.io/xabinapal/identity-provider-fixtures/ldap:latest
```

Stop either server with `docker stop idpf-oidc` or `docker stop idpf-ldap`.
Removing and recreating a container resets its data.

## OIDC

- Issuer: `http://127.0.0.1:55556/dex`
- Client ID: `example-fixture`
- Client secret: `example-fixture-secret`
- Redirect URI: `http://127.0.0.1:5173/callback`
- Scopes: `openid profile email groups`
- Login: user's email address
- Password for all users: `password`

Set `OIDC_ISSUER` and `OIDC_REDIRECT_URI` when starting the container to use
different addresses. The issuer URL must be the same address used by the app
and the browser.

To open Dex's login page directly, visit:

```text
http://127.0.0.1:55556/dex/auth?client_id=example-fixture&redirect_uri=http%3A%2F%2F127.0.0.1%3A5173%2Fcallback&response_type=code&scope=openid%20profile%20email%20groups&state=fixture&nonce=fixture
```

After login, Dex redirects to the configured callback URL.

| Username | Name | Email | Groups |
| --- | --- | --- | --- |
| `avery.blythe` | Avery Blythe | avery.blythe@example.test | engineering, support |
| `bruno.keene` | Bruno Keene | bruno.keene@example.test | engineering |
| `calla.rowan` | Calla Rowan | calla.rowan@example.test | people-ops |
| `dashiell.morrow` | Dashiell Morrow | dashiell.morrow@example.test | finance |
| `elowen.pike` | Elowen Pike | elowen.pike@example.test | directory-admins, engineering |
| `felix.arden` | Felix Arden | felix.arden@example.test | support |
| `greer.lowell` | Greer Lowell | greer.lowell@example.test | finance |
| `holden.voss` | Holden Voss | holden.voss@example.test | directory-admins |
| `indra.welles` | Indra Welles | indra.welles@example.test | people-ops, support |
| `jory.fenn` | Jory Fenn | jory.fenn@example.test | engineering |
| `kellan.sable` | Kellan Sable | kellan.sable@example.test | finance, support |
| `livia.marlowe` | Livia Marlowe | livia.marlowe@example.test | directory-admins, engineering |

Groups: `directory-admins`, `engineering`, `finance`, `people-ops`, `support`.

## LDAP

- LDAPS: `localhost:51636` (StartTLS: `localhost:51389`)
- Base DN: `dc=example,dc=test`
- Bind DN: `cn=admin,dc=example,dc=test`
- Bind password: `fixture-admin-password`
- User search: base `ou=people,dc=example,dc=test`, username attribute `uid`
- Group search: base `ou=groups,dc=example,dc=test`, membership attribute `member`
- Password for all users: `password`
- TLS certificate / CA: [`ldap/certs/fixture.crt`](ldap/certs/fixture.crt)

The certificate and credentials are public test fixtures. Never use them for a
real identity directory. Use [`ldap/certs/fixture.crt`](ldap/certs/fixture.crt)
as the CA certificate. Its names are `localhost`, `ldap`, and `127.0.0.1`.

| Username | Name | Email | Groups |
| --- | --- | --- | --- |
| `maren.ashcroft` | Maren Ashcroft | maren.ashcroft@example.test | engineering, research |
| `nolan.quill` | Nolan Quill | nolan.quill@example.test | engineering |
| `opal.rourke` | Opal Rourke | opal.rourke@example.test | finance |
| `pavel.dane` | Pavel Dane | pavel.dane@example.test | engineering |
| `quincy.hale` | Quincy Hale | quincy.hale@example.test | finance |
| `rhea.calder` | Rhea Calder | rhea.calder@example.test | helpdesk |
| `soren.whitlock` | Soren Whitlock | soren.whitlock@example.test | directory-admins |
| `tamsin.greer` | Tamsin Greer | tamsin.greer@example.test | helpdesk |
| `ulric.vale` | Ulric Vale | ulric.vale@example.test | directory-admins |
| `vera.north` | Vera North | vera.north@example.test | finance, research |
| `willa.firth` | Willa Firth | willa.firth@example.test | helpdesk |
| `xavier.mott` | Xavier Mott | xavier.mott@example.test | research |

Groups: `directory-admins`, `engineering`, `finance`, `helpdesk`, `research`.

## Build locally

```sh
docker build -t idpf-oidc ./oidc
docker build -t idpf-ldap ./ldap
```
