# yomiage

- OpenJTalkくんの研究

## 録音

```bash
# Listen
$ arecord -f S16_LE -r 44100 a.wav
# Intrrupt -> Play
$ aplay a.wav
```

## 正規化

- 正常に読んでもらうためのコツ

- 改行コードをCR+LFをLFのみに。（\rを削る）
- 改行をいったん全て削り、句点のあとに改行コード（\n）を挿入

```bash
$ cat file | tr -d \\n\\r | sed -r 's/。/&\n/g'
```

## ソース

- UTF-8でないと動かん

- mid
  - http://kurata.x.fc2.com/sizihyou-dansei-tyuukyu.html
