#!/bin/bash

MECAB_BIN='/usr/lib/mecab/mecab-dict-index'
MECAB_DIC='/usr/share/mecab/dic/ipadic/'
DIC_NAME='user.dic'

wget -q http://web-apps.nbookmark.com/hatena-dic/hatena_msime_comment.zip
wget -q http://web-apps.nbookmark.com/hatena-dic/hatena_notice.zip
wget -q http://tkido.com/data/nicoime.zip
wget -q http://ftp.vector.co.jp/pack/winnt/writing/kao/dictionary20081217.zip
wget -q http://matsucon.net/material/dic/archive/ime_std.zip
wget -q http://www.facemark.jp/orange31-i2002sz.zip

unzip -q -o hatena_msime_comment.zip
unzip -q -o hatena_notice.zip
unzip -q -o nicoime.zip nicoime_msime.txt
unzip -q -j -o dictionary20081217.zip dictionary20081217/ks20081217.txt 
unzip -q -j -o ime_std.zip ime_std/ime_std.txt 
unzip -q -j -o orange31-i2002sz.zip orange31-i2002sz/list.txt

python ime.py hatena_msime_comment-*.txt hatena_notice-*.txt nicoime_msime.txt > output.csv
python emoticon.py ks20081217.txt ime_std.txt list.txt >> output.csv
$MECAB_BIN -d $MECAB_DIC -u $DIC_NAME -f utf-8 -t utf-8 output.csv

rm output.csv hatena_msime_comment-*.txt hatena_notice-*.txt nicoime_msime.txt ks20081217.txt ime_std.txt list.txt
rm hatena_msime_comment.zip hatena_notice.zip nicoime.zip dictionary20081217.zip ime_std.zip orange31-i2002sz.zip
