#!/bin/bash

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

yomi() {
  cat - |
    open_jtalk \
      -x /var/lib/mecab/dic/open-jtalk/naist-jdic \
      -m "$1" \
      -ow /dev/stdout -r 0.8 |
    aplay --quiet
}

main() {
  chkcmd open_jtalk aplay
  trap 'kill $$' 1 2 3 15
  local f="${1-/dev/stdin}"
  local a="${2-白狐舞}"

  # check given input file
  if [ "$f" = '-' ]; then
    f="/dev/stdin"
  fi
  if ! [ -f "$f" ]; then
    echo "file '$f' is not file"
    exit 1
  fi
  if [ $(wc -c < "$f") -eq 0 ]; then
    echo "file '$f' is empty" >&2
    exit 1
  fi

  # check given actor htsvoice
  local hts="$(
    find /usr/share/hts-voice/ -name "${a}.htsvoice" -type f |
    head -1
  )"
  if [ -z "$hts" ]; then
    echo "actor '$f' is not found" >&2
    exit 1
  fi
  grep -vE "^#" "$f" |
    while read -r line; do
      if [[ "$line" = *min ]]; then
        sleep "${line//min/}m"
      elif [[ "$line" = "" ]]; then
        sleep 0.3
      else
        echo "$line" | yomi "$hts"  2> /dev/null
      fi
      sleep 0.01
    done
}

main "$@"
exit "$?"
