#!/bin/bash

yomi(){
  cat - | open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic \
   -m "$1" -ow /dev/stdout | aplay --quiet
}

main(){
  tmp=$(mktemp)
  cat <<- 'A' > "$tmp"
	音響モデル作成用利用規約の配布について。
	自分の声を録音して送っていただくことで、自分の声の音響モデルを作成することが出来ます。
	もしよろしければ音響モデル作成のための利用規約をダウンロードしてみてください。
	A
  while read -r name;do
    basename "$name"
    cat "$tmp" | while read -r i;do
      yomi "$name" <<< "$i"
    done
  done <(find /usr/share/hts-voice/ -name '*.htsvoice' | shuf)
}
main
exit "$?"
