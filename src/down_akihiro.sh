#!/usr/bin/env bash

chkcmd() {
  if [ $# -eq 0 ]; then
    echo "usage: $0 <command> [<command> ...]"
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
  chkcmd curl wget unar
  tmp="$(mktemp -d)"
  cd "$tmp" || return 1
  t='http://akihiro0105.web.fc2.com/Downloads/Downloads-htsvoice.html'
  curl -s "$t" | grep button-dark |
    grep -oP '(?<=href=")[^"]+' | xargs wget
  for i in *.zip*; do
    mv "$i" "${i//?dl=1/}"
  done
  find . -name '*.zip' -maxdepth 1 -exec unar {} \;
  sudo mv ./*_1.0 /usr/share/hts-voice/
}

main
exit "$?"
