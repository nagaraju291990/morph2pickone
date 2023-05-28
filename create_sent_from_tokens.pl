
open("FH", $ARGV[0]) or "die cannot open $ARGV[0]: $!";
my @morphs = <FH>;
close(FH);

%sent_hash = {};
foreach $line(@morphs) {
	chomp($morph);
	if($line=~/<Sentence/) {
		$flag =1 ;
		$sentid=$line;
		$sentid=~s/<Sentence.*="(.*)">/$1/g;
		#print "$sentid\n";
		$sent= "Sentence:\t";
		next;
	}
	if($line=~/<\/Sentence/) {
		$sent=$sent. "\n";
		$sent_hash{$sentid} = $sent;
		$sent = '';
		$flag =0 ;
	}
	if($flag == 1) {
		@token=split(/\t/, $line);
		$sent=$sent.$token[1]." ";
	}
}

open("FI", $ARGV[1]) or "die cannot open $ARGV[0]: $!";
while($line1=<FI>) {
	#chomp($line1);
	if($line1=~/<Sentence/) {
		#print "|$line1|\n";
		$sentid=$line1;
		$sentid=~s/<Sentence.*="(.*)\">.*/$1/g;
		#print "|$sentid|\n";
		$sent = $sent_hash{$sentid};
		#print $sent;
		$sent=~s/\(\(//g;
		$sent=~s/\)\)//g;
		$line1=$sent."\n".$line1;
	}
	print $line1;
}
