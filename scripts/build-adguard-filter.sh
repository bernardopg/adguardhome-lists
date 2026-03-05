#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BLOCK_FILE="$ROOT_DIR/blocklist/domains.txt"
ALLOW_FILE="$ROOT_DIR/allowlist/domains.txt"
OUT_FILE="$ROOT_DIR/dist/adguard-filter.txt"

mkdir -p "$(dirname "$OUT_FILE")"

echo "! AdGuard Home custom filter" > "$OUT_FILE"
echo "! Repo: https://github.com/bernardopg/adguardhome-lists" >> "$OUT_FILE"
echo "" >> "$OUT_FILE"

echo "! BLOCKLIST" >> "$OUT_FILE"
while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line#${line%%[![:space:]]*}}"
  line="${line%${line##*[![:space:]]}}"
  [[ -z "$line" || "$line" == \#* ]] && continue
  domain="${line#||}"
  domain="${domain%^}"
  domain="${domain#@@||}"
  echo "||${domain}^" >> "$OUT_FILE"
done < "$BLOCK_FILE"

echo "" >> "$OUT_FILE"
echo "! ALLOWLIST" >> "$OUT_FILE"
while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line#${line%%[![:space:]]*}}"
  line="${line%${line##*[![:space:]]}}"
  [[ -z "$line" || "$line" == \#* ]] && continue
  domain="${line#@@||}"
  domain="${domain#||}"
  domain="${domain%^}"
  echo "@@||${domain}^" >> "$OUT_FILE"
done < "$ALLOW_FILE"

echo "Generated: $OUT_FILE"
