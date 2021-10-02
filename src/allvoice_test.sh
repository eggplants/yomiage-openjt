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

yomi() {
  cat - |
    open_jtalk \
      -x /var/lib/mecab/dic/open-jtalk/naist-jdic \
      -m "$1" -ow /dev/stdout |
    aplay --quiet
}

main() {
  chkcmd open_jtalk aplay
  tmp="$(mktemp)"
  cat <<- 'A' > "$tmp"
	音響モデル作成用利用規約の配布について。
	自分の声を録音して送っていただくことで、自分の声の音響モデルを作成することが出来ます。
	もしよろしければ音響モデル作成のための利用規約をダウンロードしてみてください。
	A
  find /usr/share/hts-voice/ -name '*.htsvoice' | shuf |
    while read -r name; do
      basename "$name"
      while read -r i; do
        yomi "$name" <<< "$i"
      done < "$tmp"
    done
}
main
exit "$?"
