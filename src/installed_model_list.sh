#!/usr/bin/env bash

if [ -d /usr/share/hts-voice/ ]; then
  find /usr/share/hts-voice/ -name '*.htsvoice' |
  awk -F'/' '{n=split($0, a, "/");print substr(a[n],1,length(a[n])-9)"\t"$0}' |
  column -t -s $'\t'
else
  echo "(not installed)"
fi
