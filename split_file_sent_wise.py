import re
import sys

inpfile = sys.argv[1]
#splitfile = sys.argv[2]
#open file using open file mode
fp1 = open(inpfile) # Open file on read mode -- input file
lines = fp1.read().split("\n") # Create a list containing all lines
fp1.close() # Close file

flag = 0
for line in lines:
	
	line = line.strip()
	if(line == ""):
		continue
	if(re.search(r'<Sentence id=', line) and flag == 0):
		sentid = re.sub(r'<Sentence id="(.*)">', r'\1', line)
		#print(sentid)
		out_arr = ''
		flag = 1
	if(flag == 1):
		out_arr += line + "\n"
	if(re.search(r'<\/Sentence>', line)):
		#out_arr += line + "\n"
		fp = open("out/" + sentid + ".txt", "w")
		fp.write(out_arr)
		fp.close()
		flag = 0
