#!/bin/bash

main() {
  mkdir tmp; cd tmp || return 1
  t=http://akihiro0105.web.fc2.com/Downloads/Downloads-htsvoice.html
  curl -s "$t" | grep button-dark |
  grep -oP '(?<=href=")[^"]+' | xargs wget
  for i in *.zip*;{ mv "$i" "${i//?dl=1/}";}
  find  -name '*.zip' -maxdepth 1 -exec unar {} \;
  sudo mv ./*_1.0 /usr/share/hts-voice/
  cd ..; rm -rf tmp
}
main
exit "$?"