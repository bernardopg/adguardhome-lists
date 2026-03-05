# adguardhome-lists

Listas personalizadas para o AdGuard Home, separadas entre bloqueio e liberacao.

## Estrutura

- `blocklist/domains.txt`: dominios para bloquear
- `allowlist/domains.txt`: dominios para permitir
- `scripts/build-adguard-filter.sh`: gera o filtro consolidado
- `dist/adguard-filter.txt`: arquivo final para consumir no AdGuard Home

## Como usar

1. Edite os arquivos de dominio:
   - `blocklist/domains.txt`
   - `allowlist/domains.txt`
2. Gere o filtro consolidado:
   - `./scripts/build-adguard-filter.sh`
3. Commit e push para atualizar a URL raw.

## URL para AdGuard Home

Use esta URL no AdGuard Home (DNS blocklists):

`https://raw.githubusercontent.com/bernardopg/adguardhome-lists/main/dist/adguard-filter.txt`

Observacao: regras de allowlist sao geradas como `@@||dominio^` no mesmo arquivo de filtro.
