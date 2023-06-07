import re
import sys

inpfile = sys.argv[1]
spellfile = sys.argv[2]
#open file using open file mode
fp1 = open(inpfile) # Open file on read mode -- input file
lines = fp1.read().split("\n") # Create a list containing all lines
fp1.close() # Close file

fp2 = open(spellfile) # Open file on read mode -- input file
lines2 = fp2.read().split("\n") # Create a list containing all lines
fp2.close() # Close file

spell_hash = {}
for line2 in lines2:
	if(line2 == ""):
		continue
	arr = line2.split("\t")
	#print(line2)
	spell_hash[arr[0]] = arr[1]


for line in lines:
	line = line.strip()
	#print("|"+line+"|")
	if(line == "" or re.search(r'Sentence|\(\(|\)\)', line)):
		print(line)
		continue
	arr = line.split("\t")
	if(arr[1] in spell_hash):
		print("%s\t%s\t%s" %(arr[0], spell_hash[arr[1]], arr[2]))
	else:
		print(line)
