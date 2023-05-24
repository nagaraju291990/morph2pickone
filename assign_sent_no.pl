$i=1;
while($line=<>){

	if($line=~/<Sentence/) {
		$line="<Sentence id=\"$i\">\n";
		$i = $i + 1;
		print $line;
	} else {
		print $line;
	}
}
