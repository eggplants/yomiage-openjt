#!/bin/bash

main(){
    local dic voice
    dic=/var/lib/mecab/dic/open-jtalk/naist-jdic
    voice=/usr/share/hts-voice/mei/mei_normal.htsvoice

    which open_jtalk > /dev/null || {
        sudo apt install open-jtalk -y
    }

    [[ -f "${dic}" ]] || {
        sudo apt install open-jtalk-mecab-naist-jdic -y
    }

    [[ -f "${voice}" ]] || {
        wget http://sourceforge.net/projects/mmdagent/files/MMDAgent_Example/MMDAgent_Example-1.8/MMDAgent_Example-1.8.zip
        unzip MMDAgent_Example-1.8.zip
        sudo cp -r MMDAgent_Example-1.8/Voice/mei/ /usr/share/hts-voice/
        rm -rf MMDAgent*
    }
    # test
    open_jtalk -x "${dic}" \
               -m "${voice}" \
               -ow /dev/stdout <<<こんにちは| aplay --quiet
}

main
exit "$?"