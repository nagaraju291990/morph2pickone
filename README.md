# Steps for generating pickone morph output

### From input file generate all unique tokens and run against apertium morph. The output file generated here will be given as input to next step.

## To convert apertium morph output into ssf format
python3 lt2ssf.py $1 > $1.ssf

## To search input tokens from $2 file and search in $1.ssf file, then substitute against token to get morph output
perl search_morph.pl $1.ssf $2 > $2.mo

## Morph output generated above is subjected to pruning
sh pruning.sh $2.mo > $2.prune

## Pruning output generated above is subjected to guess morph
sh guess-morph.sh $2.prune > $2.gmo

## Pickone output from pruning
perl pickone.pl < $2.gmo > $2.pickone

## Run below program to generate actual sentence above each sentence unit.
perl create_sent_from_tokens.pl < $2.pickone > $2.pickone
