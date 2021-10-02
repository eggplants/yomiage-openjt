# yomiage

- OpenJTalkくんの研究
- Debianのみで動作
  - よしなに書き換えれば他distroでも動くはず
  - `src/prepare_openjt.sh`のaptとかね

## はじめに

```shellsession
# open_jtalkコマンドのインストール
$ sudo ./prepare_openjt.sh
# 色々なボイスモデルをインストール
$ sudo ./down_akihito.sh
```

## 依存

```shellsession
$ grep -r "  chkcmd" | awk '{for(i=3;i<=NF;)print$(i++)}' | sort | uniq | xargs
aplay apt bc curl open_jtalk sox unar unzip wget
```

## お試し

```bash
# インストールしたボイスモデルを全部試す
./allvoice_test.sh
# yahooトップページニュース読み上げ
./read_yahoo.sh
```

## `read.sh`

```shellsession
$ ./read.sh -h
usage: ./read.sh [-s] [-h] [file, def: /dev/stdin] [actor, def: 白狐舞]
$ ./read.sh - <<< こんにちは
[input: -, actor: 白狐舞]
[working in: /tmp/tmp.mF8HdxASHy]
[1/1]
再生中 WAVE '/tmp/tmp.mF8HdxASHy/audio_-dev-stdin_1633132546.wav' : Signed 16 bit Little Endian, レート 48000 Hz, モノラル
$ ./read.sh - 唱地ヨエ <<< おはよう
[input: -, actor: 唱地ヨエ]
[working in: /tmp/tmp.F8iJNBfPFB]
[1/1]
再生中 WAVE '/tmp/tmp.F8iJNBfPFB/audio_-dev-stdin_1633132575.wav' : Signed 16 bit Little Endian, レート 48000 Hz, モノラル
$ ./read.sh beginner.txt 白狐舞
[input: beginner.txt, actor: 白狐舞]
[working in: /tmp/tmp.Oq8IrdWzio]
[1/314]
...
[314/314]
再生中 WAVE '/tmp/tmp.Oq8IrdWzio/audio_beginner.txt_1633133100.wav' : Signed 16 bit Little Endian, レート 48000 Hz, モノラル
$ ./read.sh -s beginner.txt 白狐舞
[input: beginner.txt, actor: 白狐舞]
[working in: /tmp/tmp.BsFtnzVVNs]
[314/314]
[created: audio_beginner.txt_1633133412.wav]
$
```

## 正規化(正常に読んでもらうためのコツ)

- 改行コードをCR+LFをLFに置換(`\r`を削る)
- 改行をいったん全て削り、句点のあとに改行(`\n`)を挿入

```bash
cat hoge_file.txt | tr -d \\n\\r | sed -r 's/。/&\n/g'
```

## ソース

- UTF-8でないと動かん
- beginner.txt
  - <http://kurata.x.fc2.com/sizihyou-dansei-syokyu.html>

- mid.txt
  - <http://kurata.x.fc2.com/sizihyou-dansei-tyuukyu.html>
