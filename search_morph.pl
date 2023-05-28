open("FH", $ARGV[0]) or "die cannot open $ARGV[0]: $!";
my @morphsin = <FH>;
close(FH);

%inmorphs={};
$lineno = 1;
foreach $m(@morphsin) {
	@arr = split( "\t", $m);
	$inmorphs{$arr[1]} = $lineno;
	$lineno++;
}
open("FH", $ARGV[1]) or "die cannot open $ARGV[1]: $!";
my @morphsout = <FH>;
close(FH);

%outmorphs={};
foreach $m(@morphsout) {
	chomp($m);
	@arr = split("\t", $m);
	$pos = $arr[2];
	if($arr[2] =~/unk/) {
		if($arr[3]=~/,v,/) {
			$pos=~s/unk/VM/g;
		} elsif($arr[3]=~/,n,/) {
			$pos=~s/unk/NN/g;
		} elsif($arr[3]=~/,pn,/) {
			$pos=~s/unk/PRP/g;
		} else {
			$pos=~s/unk/NN/g;
		}
	}
	if(exists $outmorphs{$arr[0]}) {
		$tmp = $outmorphs{$arr[0]};
		#$outmorphs{$arr[0]} = $tmp."##SS##". $arr[1]."\t".$arr[2]."\t".$arr[3];
		$outmorphs{$arr[0]} = $tmp."\n"."TOKENO"."\t". $arr[1]."\t".$pos."\t".$arr[3];
	} else {
		#print "2 $arr[0]|$arr[1]|\n";
		$outmorphs{$arr[0]} = $arr[1]."\t".$pos."\t".$arr[3];
	}
}
#foreach $k (sort keys %outmorphs) {
	#    print "$k => $outmorphs{$k}\n";
	#}
open("FH", $ARGV[2]) or "die cannot open $ARGV[2]: $!";
#my @morphs = <FH>;
while($line=<FH>)
{
	chomp($line);
	if($line=~/unk,,,,/ ) {
		#print "$line\n";
		@arr = split(/\t/,$line);
		$token = $arr[1];
		#print "$line|$inmorphs{$token}\n";
		if (exists $inmorphs{$token}) {
			$line_no = $inmorphs{$token};
			$outline = $outmorphs{$line_no};
			$outline=~s/TOKENO/$arr[0]/g;
			print "$arr[0]\t$outline\n";
		} else {
			print "$arr[0]\t$arr[1]\t$arr[2]\t<fs af=\'$token,unk,,,,,,\'>\n";
		}
	} else {
		print "$line\n";
	}
}
