#!/bin/bash

main() {
  local dic voice
  dic='/var/lib/mecab/dic/open-jtalk/naist-jdic'
  voice='/usr/share/hts-voice/mei/mei_normal.htsvoice'

  if ! command -v open_jtalk > /dev/null; then
    sudo apt install open-jtalk -y
  fi

  if [[ ! -f ${dic} ]]; then
    sudo apt install open-jtalk-mecab-naist-jdic -y
  fi

  if [[ ! -f ${voice} ]]; then
    wget 'http://sourceforge.net/projects/mmdagent/files/MMDAgent_Example/MMDAgent_Example-1.8/MMDAgent_Example-1.8.zip'
    unzip 'MMDAgent_Example-1.8.zip'
    if [[ ! -d '/usr/share/hts-voice/' ]]; then
      sudo mkdir '/usr/share/hts-voice/'
    fi
    sudo cp -r 'MMDAgent_Example-1.8/Voice/mei/' '/usr/share/hts-voice/'
    rm -rf MMDAgent*
  fi
  # test
  open_jtalk -x "${dic}" \
    -m "${voice}" \
    -ow /dev/stdout <<< こんにちは |
    aplay --quiet
}

main
exit "$?"
