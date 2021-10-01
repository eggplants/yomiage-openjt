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
    open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic \
      -m /usr/share/hts-voice/白狐舞_1.0/白狐舞.htsvoice \
      -ow /dev/stdout -r 0.8 |
    aplay --quiet
}

main() {
  chkcmd open_jtalk aplay
  trap 'kill $$' 1 2 3 15
  grep -vE "^#" "$1" |
    while read -r line; do
      if [[ $line == *min ]]; then
        sleep "${line//min/}m"
      elif [[ $line == "" ]]; then
        sleep 0.3
      else
        echo "$line" | yomi 2 > /dev/null
      fi
      sleep 0.01
    done
}

main "$@"
exit "$?"
