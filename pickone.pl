while($line=<STDIN>) {
	if($line=~/\|/) {
		$line=~s/\|.*$//g;
	}
	$line=~s/ poslcat="NM"//g;
	print $line;
}
