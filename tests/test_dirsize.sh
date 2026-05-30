#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
script_path="$repo_root/dirsize"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

assert_eq() {
  local expected=$1
  local actual=$2
  local message=$3

  if [[ "$expected" != "$actual" ]]; then
    printf 'FAIL: %s\n' "$message" >&2
    printf 'Expected:\n%s\n' "$expected" >&2
    printf 'Actual:\n%s\n' "$actual" >&2
    exit 1
  fi
}

assert_contains() {
  local haystack=$1
  local needle=$2
  local message=$3

  if ! grep -Fq -- "$needle" <<<"$haystack"; then
    fail "$message"
  fi
}

assert_not_contains() {
  local haystack=$1
  local needle=$2
  local message=$3

  if grep -Fq -- "$needle" <<<"$haystack"; then
    fail "$message"
  fi
}

build_listing_line() {
  local item=$1
  local size_bytes
  local size_human

  size_bytes=$(du -s --block-size=1 "$item" | cut -f1)
  size_human=$(du -sh "$item" | cut -f1)

  if [[ -d "$item" ]]; then
    printf '%s\t%s - %s/\n' "$size_bytes" "$size_human" "$item"
  else
    printf '%s\t%s - %s\n' "$size_bytes" "$size_human" "$item"
  fi
}

expected_output() {
  local -a items=("$@")
  local total_bytes
  local total_human

  for item in "${items[@]}"; do
    build_listing_line "$item"
  done | sort -n -k1,1 | cut -f2-

  total_bytes=$(du -sc --block-size=1 "${items[@]}" | tail -n1 | awk '{print $1}')
  total_human=$(numfmt --to=iec-i --suffix=B --format='%9.1f' "$total_bytes")
  printf 'TOTAL: %s\n' "$total_human"
}

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

head -c 1 /dev/zero > "$temp_dir/visible.bin"
head -c 5000 /dev/zero > "$temp_dir/.hidden.bin"
mkdir "$temp_dir/visible_dir" "$temp_dir/.hidden_dir"
head -c 9000 /dev/zero > "$temp_dir/visible_dir/file.bin"
head -c 15000 /dev/zero > "$temp_dir/.hidden_dir/file.bin"

default_output=$(cd "$temp_dir" && "$script_path")
expected_default=$(cd "$temp_dir" && expected_output ".hidden.bin" ".hidden_dir" "visible.bin" "visible_dir")

assert_contains "$default_output" ".hidden.bin" "default mode should include hidden files"
assert_contains "$default_output" ".hidden_dir/" "default mode should include hidden directories"
assert_eq "$expected_default" "$default_output" "default mode should match the expected listing and total"

hidden_excluded_output=$(cd "$temp_dir" && "$script_path" -h)
expected_hidden_excluded=$(cd "$temp_dir" && expected_output "visible.bin" "visible_dir")

assert_not_contains "$hidden_excluded_output" ".hidden.bin" "-h should exclude hidden files"
assert_not_contains "$hidden_excluded_output" ".hidden_dir/" "-h should exclude hidden directories"
assert_eq "$expected_hidden_excluded" "$hidden_excluded_output" "-h mode should match the expected listing and total"

printf 'All tests passed.\n'