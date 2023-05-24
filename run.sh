python3 lt2ssf.py $1 > $1.ssf
perl search_morph.pl $1.ssf $2 > $2.mo
sh pruning.sh $2.mo > $2.prune
sh guess-morph.sh $2.prune > $2.gmo
perl pickone.pl < $2.gmo > $2.pickone
perl create_sent_from_tokens.pl < $2.pickone > $2.pickone
