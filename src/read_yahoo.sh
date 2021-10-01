#!/usr/bin/env bash

chkcmd() {
  if [ $# -eq 0 ]; then
    echo "Usage: $0 <command> [<command> ...]"
    exit 1
  fi
  local NOT_EXIST=""
  for cmd in "$@"; do
    if ! command -v > /dev/null; then
      echo "command '$cmd' is not found" >&2
      NOT_EXIST=true
    fi
  done
  if [ "$NOT_EXIST" = "true" ]; then
    exit 1
  fi
}

main() {
  chkcmd curl
  curl -s 'https://news.yahoo.co.jp/' |
    grep -oP '(?<=yjnSub_list_headline">).*?(?=<)' |
    while read -r i; do
      tee <<< "$i" >("${0%/*}"/read.sh -)
    done
}

main
exit "$?"
