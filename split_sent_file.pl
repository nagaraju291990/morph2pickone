while($line=<>){
	if($line=~/<Sentence/) {
		chomp($line);
		$name=$line;
		$name=~s/.*id="//g;
		$name=~s/".*//g;
		$name="Sent_".$name.".txt";
		open("FW",">", $name);
		print FW $line."\n";
	} elsif($line=~/<\/Sentence/) {
		print FW $line;
		close($FW)
	} else {
		print FW $line;
	}
}
