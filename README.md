# yomiage

- OpenJTalkくんの研究
- Debianのみで動作
  - よしなに書き換えれば他distroでも動くはず
  - `src/prepare_openjt.sh`のaptとかね

## はじめに

```bash
# open_jtalkコマンドのインストール
sudo ./prepare_openjt.sh
# 色々なボイスモデルをインストール
sudo ./down_akihito.sh
```

<details>
<summary>インストールされるモデル一覧</summary>

```shellsession
$ ./installed_model_list.sh
句音コノ。        /usr/share/hts-voice/句音コノ。_1.0/句音コノ。.htsvoice
遠藤愛            /usr/share/hts-voice/遠藤愛_1.0/遠藤愛.htsvoice
瑞歌ミズキ_Talk   /usr/share/hts-voice/瑞歌ミズキ_Talk_1.0/瑞歌ミズキ_Talk.htsvoice
和音シバ          /usr/share/hts-voice/和音シバ_1.0/和音シバ.htsvoice
戯歌ラカン        /usr/share/hts-voice/戯歌ラカン_1.0/戯歌ラカン.htsvoice
空唄カナタ        /usr/share/hts-voice/空唄カナタ_1.0/空唄カナタ.htsvoice
スランキ          /usr/share/hts-voice/スランキ_1.0/スランキ.htsvoice
能民音ソウ        /usr/share/hts-voice/能民音ソウ_1.0/能民音ソウ.htsvoice
蒼歌ネロ          /usr/share/hts-voice/蒼歌ネロ_1.0/蒼歌ネロ.htsvoice
闇夜 桜_1.0       /usr/share/hts-voice/闇夜 桜_1.0/闇夜 桜_1.0.htsvoice
獣音ロウ          /usr/share/hts-voice/獣音ロウ_1.0/獣音ロウ.htsvoice
誠音コト          /usr/share/hts-voice/誠音コト_1.0/誠音コト.htsvoice
唱地ヨエ          /usr/share/hts-voice/唱地ヨエ_1.0/唱地ヨエ.htsvoice
京歌カオル        /usr/share/hts-voice/京歌カオル_1.0/京歌カオル.htsvoice
松尾P             /usr/share/hts-voice/松尾P_1.0/松尾P.htsvoice
グリマルキン_1.0  /usr/share/hts-voice/グリマルキン_1.0/グリマルキン_1.0.htsvoice
桃音モモ          /usr/share/hts-voice/桃音モモ_1.0/桃音モモ.htsvoice
なないろニジ      /usr/share/hts-voice/なないろニジ_1.0/なないろニジ.htsvoice
薪宮風季          /usr/share/hts-voice/薪宮風季_1.0/薪宮風季.htsvoice
白狐舞            /usr/share/hts-voice/白狐舞_1.0/白狐舞.htsvoice
カマ声ギル子      /usr/share/hts-voice/カマ声ギル子_1.0/カマ声ギル子.htsvoice
ワタシ            /usr/share/hts-voice/ワタシ_1.0/ワタシ.htsvoice
遊音一莉          /usr/share/hts-voice/遊音一莉_1.0/遊音一莉.htsvoice
天月りよん        /usr/share/hts-voice/天月りよん_1.0/天月りよん.htsvoice
月音ラミ_1.0      /usr/share/hts-voice/月音ラミ_1.0/月音ラミ_1.0.htsvoice
想音いくと        /usr/share/hts-voice/想音いくと_1.0/想音いくと.htsvoice
沙音ほむ          /usr/share/hts-voice/沙音ほむ_1.0/沙音ほむ.htsvoice
mei_angry         /usr/share/hts-voice/mei/mei_angry.htsvoice
mei_happy         /usr/share/hts-voice/mei/mei_happy.htsvoice
mei_sad           /usr/share/hts-voice/mei/mei_sad.htsvoice
mei_normal        /usr/share/hts-voice/mei/mei_normal.htsvoice
mei_bashful       /usr/share/hts-voice/mei/mei_bashful.htsvoice
20代男性01        /usr/share/hts-voice/20代男性01_1.0/20代男性01.htsvoice
飴音わめあ        /usr/share/hts-voice/飴音わめあ_1.0/飴音わめあ.htsvoice
想音いくる        /usr/share/hts-voice/想音いくる_1.0/想音いくる.htsvoice
緋惺              /usr/share/hts-voice/緋惺_1.0/緋惺.htsvoice
```

</details>

## 依存

```shellsession
$ grep -r "  chkcmd" | awk '{for(i=3;i<=NF;)print$(i++)}' | sort | uniq | xargs
aplay apt bc curl open_jtalk sox unar unzip wget
```

- `down_akihito.sh`は[akihiro0105](http://akihiro0105.web.fc2.com)さんの配布している音響モデルを用意
  - [配布ページ](http://akihiro0105.web.fc2.com/Downloads/Downloads-htsvoice.html)


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

## Dockerfile

```bash
docker run -it eggplanter/yomiage_openjt bash
```

## ソース

- UTF-8でないと動かん
- beginner.txt
  - <http://kurata.x.fc2.com/sizihyou-dansei-syokyu.html>

- mid.txt
  - <http://kurata.x.fc2.com/sizihyou-dansei-tyuukyu.html>

