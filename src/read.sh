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
        -s 48000 \
        -ow "$TMP/$(uuidgen).wav" -r 0.8
}

usage() {
  echo "Usage: $0 [-s] [-h] [<file>, def: /dev/stdin] [<actor>, def: 白狐舞]"
  exit "${1-0}"
}

main() {
  chkcmd open_jtalk aplay uuidgen sox
  trap 'kill $$' 1 2 3 15
  local SAVE
  while getopts "sh" OPT
  do
    case "$OPT" in
      s) SAVE="true" ;;
      h) usage ;;
      *) echo "option '${OPT}' is invalid." >&2 && usage 1
         ;;
    esac
  done
  shift "$((OPTIND - 1))"
  local f a
  f="${1-/dev/stdin}"
  a="${2-白狐舞}"
  echo "[input: $f, actor: $a]"
  # check given input file
  if [ "$f" = '-' ] || [ "$f" = '/dev/stdin' ]; then
    if ! [ -f "/dev/stdin" ]; then
      echo "stdin is empty">&2
      exit 1
    fi
    f="/dev/stdin"
  fi
  if ! [ -f "$f" ]; then
    echo "file '$f' is not file"
    usage 1
  fi
  local word_count
  word_count="$(wc -c < "$f")"
  if [ "$word_count" -eq 0 ]; then
    echo "file '$f' is empty" >&2
    usage 1
  fi

  # check given actor htsvoice
  local hts
  hts="$(
    find /usr/share/hts-voice/ -name "${a}.htsvoice" -type f |
      head -1
  )"
  if [ -z "$hts" ]; then
    echo "actor '$a' is not found" >&2
    usage 1
  fi

  readonly OUT="audio_${f//\//-}_$(date +%s).wav"
  readonly TMP="$(mktemp -d)"
  echo "[working in: $TMP]"
  local line_count idx
  line_count="$(< "$f" wc -l)"
  idx=0
  grep -vE "^#" "$f" |
    while read -r line; do
      ((idx++))
      echo -ne "\r[${idx}/${line_count}]"
      if [[ "$line" =~ *min$ ]]; then
        local m
        m="${line//min/}"
        sox -n -r 48000 -c 1 "$TMP/$(uuidgen).wav" trim 0 "$((m*60))"
      elif [[ -z "$line" ]]; then
        sox -n -r 48000 -c 1 "$TMP/$(uuidgen).wav" trim 0 0.3
      else
        echo "$line" | yomi "$hts" 2> /dev/null
      fi
      sleep 0.01
    done

  echo
  ls "$TMP"/*.wav -tr > "$TMP/_list"
  readarray -t arr < "$TMP/_list"
  if sox "${arr[@]}" "$TMP/$OUT"; then
    if [[ "$SAVE" = "true" ]]; then
      mv "$TMP/$OUT" .
      echo "[created: $OUT]"
      aplay "$OUT"
    else
      aplay "$TMP/$OUT"
    fi
  fi
}

main "$@"
exit "$?"
