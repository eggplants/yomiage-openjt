#!/bin/bash

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
  chkcmd apt wget unzip aplay
  local dic voice
  dic='/var/lib/mecab/dic/open-jtalk/naist-jdic'
  voice='/usr/share/hts-voice/mei/mei_normal.htsvoice'

  if ! command -v open_jtalk > /dev/null; then
    apt install open-jtalk -y
  fi

  if [[ ! -f $dic ]]; then
    apt install open-jtalk-mecab-naist-jdic -y
  fi

  if [[ ! -f $voice ]]; then
    wget 'http://sourceforge.net/projects/mmdagent/files/MMDAgent_Example/MMDAgent_Example-1.8/MMDAgent_Example-1.8.zip'
    unzip 'MMDAgent_Example-1.8.zip'
    if [[ ! -d '/usr/share/hts-voice/' ]]; then
      mkdir '/usr/share/hts-voice/'
    fi
    cp -r 'MMDAgent_Example-1.8/Voice/mei/' '/usr/share/hts-voice/'
    rm -rf MMDAgent*
  fi
  # test
  # open_jtalk -x "$dic" \
  #   -m "$voice" \
  #   -ow /dev/stdout <<< こんにちは |
  #   aplay --quiet
}

main
exit "$?"
