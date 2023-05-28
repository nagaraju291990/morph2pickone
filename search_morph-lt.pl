open("FH", $ARGV[0]) or "die cannot open $ARGV[0]: $!";
my @morphs = <FH>;
close(FH);

%morph_hash = {};
foreach $morph(@morphs) {
	chomp($morph);
	@arr = split("\t", $morph);
	$morph_hash{$arr[1]} = $arr[3];
}

#print(%morph_hash);
open("FH", $ARGV[1]) or "die cannot open $ARGV[1]: $!";
#my @morphs = <FH>;
while($line=<FH>)
{
	chomp($line);
	if($line!~/Sentence|Title|\(\(|\)\)|\t\t|^$/ ) {
		@arr = split(/\t/,$line);
		$token = $arr[1];
		$fs = $morph_hash{$token};
		if (exists $morph_hash{$token}) {
			print "$arr[0]\t$arr[1]\t$arr[2]\t$fs\n";
		} else {
			print "$arr[0]\t$arr[1]\t$arr[2]\t<fs af=\'$token,unk,,,,,,\'>\n";
		}
	} else {
		print "$line\n";
	}
}
