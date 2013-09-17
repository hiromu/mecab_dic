#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import codecs

def convert(input):
	hiragana = ''.join(map(unichr, range(ord(u'ぁ'), ord(u'ゞ') + 1)))
	katakana = ''.join(map(unichr, range(ord(u'ァ'), ord(u'ヾ') + 1)))

	for line in input:
		if len(line) < 1 or line[0] == '!':
			continue
		if '。' in line or ',' in line or '"' in line:
			continue

		try:
			words = filter(bool, line.split('\t'))
		except:
			continue

		if len(words) < 3:
			continue

		yomi = ''
		for c in words[0].decode('utf-8'):
			if c in hiragana:
				yomi += katakana[hiragana.index(c)]
			else:
				yomi += c
		yomi = yomi.encode('utf-8')

		score = max(-32768, (6000 - 200 * (len(words[1]) ** 1.3)))
		info = ','.join([''] + words[3:])
		print '%s,,,%d,名詞,固有名詞,*,*,*,*,%s,%s,%s%s' % (words[1], score, words[1], yomi, yomi, info)

if __name__ == '__main__':
	for filename in sys.argv[1:]:
		data = codecs.open(filename, 'r', 'utf-16-le').read()

		convert(data.encode('utf-8').split('\n'))
