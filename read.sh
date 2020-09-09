#!/bin/bash

yomi(){
  cat - | open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic \
   -m /usr/share/hts-voice/白狐舞_1.0/白狐舞.htsvoice \
   -ow /dev/stdout -r 0.8 | aplay --quiet
}

main(){
  cat "$1" | while read line;do
    if [[ "$line" == *min ]];then
      sleep "$(echo \"$line\" | sed 's/min//')m"
    elif [[ "$line" = "" ]];then
      sleep 0.3
    else
      echo "$line" | yomi 2 > /dev/null
    fi
    sleep 0.01
  done
}

main "$@"
exit "$?"
