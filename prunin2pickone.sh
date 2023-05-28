#$1=10000-lt-cm.mo.pickone
sh pruning.sh $1 > $1.prune
sh guess-morph.sh $1.prune > $1.gmo
perl pickone.pl < $1.gmo > $1.pickone
cut -d "       " -f4 10000-lt-cm.mo  > f4
#paste   10000-lt-cm.mo.pickone f4 > pickone-morph.txt
#perl create_sent_from_tokens.pl 10000.txt < pickone-morph.txt > final_10000.txt
