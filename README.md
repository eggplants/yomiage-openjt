# yomiage

- OpenJTalkくんの研究

## はじめに

```bash
$ chmod +x ./*.sh
$ ./prepare_openjt.sh
$ ./down_akihito.sh # 様々なボイスモデルをインストール(任意)
```

## お試し

```bash
# インストールしたボイスモデルを全部試す
$ ./allvoice_test.sh
# cv. 白狐舞
$ ./read.sh -<<<こんにちは
# ファイル読み上げ
$ ./read.sh beginner
# yahooトップページニュース読み上げ
$ curl -s 'https://news.yahoo.co.jp/' \
  | grep -oP '(?<=yjnSub_list_headline">).*?(?=<)' \
  | while read i;do ./read.sh -<<<"$i";done
```

## 正規化

- 正常に読んでもらうためのコツ

- 改行コードをCR+LFをLFのみに（\rを削る）
- 改行をいったん全て削り、句点のあとに改行コード（\n）を挿入

```bash
$ cat file | tr -d \\n\\r | sed -r 's/。/&\n/g'
```

## ソース

- UTF-8でないと動かん
- beginner
  - http://kurata.x.fc2.com/sizihyou-dansei-syokyu.html

- mid
  - http://kurata.x.fc2.com/sizihyou-dansei-tyuukyu.html
