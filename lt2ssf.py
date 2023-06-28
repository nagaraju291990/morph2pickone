import re
import sys

#open file using open file mode
fp1 = open(sys.argv[1]) # Open file on read mode -- input file
lines = fp1.read()#.split("\n") # Create a list containing all lines
fp1.close() # Close file

lines = re.sub(r'\$\+\^', r'$\n^', lines)
lines = lines.split("\n")
count = 0
for line in lines:
	if(line == ""):
		continue
	token = re.sub(r'^\^(.*?)\/.*', r'\1', line)
	fs = re.sub(r'^\^(.*?)\/(.*)', r'\2', line)
	#print(line)
	#print(token)
	#print(fs)
	arr = fs.split("/")
	feature_ssf = ''
	for a in arr:
		print(a)
		#if(re.match(r'\*'), a):
		if(re.search(r'(lcat:noun|lcat:pronoun|lcat:adj|lcat:adv|lcat:numeric)', a)):
			m = re.match(r'(.*?)<lcat:(.*)><gen:(.*)><num:(.*)><per:(.*)><cm:(.*)><suffix:(.*)>', a)
			if(m.group(2) == "pronoun"):
				cat = re.sub(r'pronoun', r'pn', m.group(2))
			elif(m.group(2) == "noun"):	
				cat = re.sub(r'noun', r'n', m.group(2))
			elif(m.group(2) == "numeric"):
				cat = re.sub(r'numeric', r'num', m.group(2))
			else:
				cat = m.group(2)
			feature_ssf +='<fs af=\'' + m.group(1) + ',' + cat +  ',' + m.group(3) + ',' +m.group(4) + ',' + m.group(5) + ',,' + m.group(6) + ',' + m.group(7) + '>\''
		elif(re.search(r'lcat:verb', a)):
			m = re.match(r'(.*?)<lcat:(.*)><gen:(.*)><num:(.*)><per:(.*)><tam:(.*)><suffix:(.*)>', a)
			cat = re.sub(r'verb', r'v', m.group(2))
			feature_ssf +='<fs af=\'' + m.group(1) + ',' + cat +  ',' + m.group(3) + ',' +m.group(4) + ',' + m.group(5) + ',,' + m.group(6) + ',' + m.group(7) + '>\''
		elif(re.search(r'(lcat:avy|lcat:punc|lcat:num)', a)):
			m = re.match(r'(.*?)<lcat:(.*)>', a)
			feature_ssf +='<fs af=\'' + m.group(1) + ',' + m.group(2) + ',,,,,, \'>'
		elif(re.search(r'\*' + token + r'\$', a)):
			feature_ssf += '<fs af=\''+ token + ',unk,,,,,,\'>'
		feature_ssf += '|'
	feature_ssf = re.sub(r'\|$', r'', feature_ssf)
	count = count + 1
	#print(token)
	print(str(count) + "\t" + token + '\tunk\t' + feature_ssf)
		#print(root)
		#print(a)
	#print(line)