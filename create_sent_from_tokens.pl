while($line=<>) {
	if($line=~/<Sentence/) {
		push(@out,$line);
		$flag =1 ;
		$sent= "Sentence:\t";
		next;
	}
	if($line=~/<\/Sentence/) {
		$sent=$sent. "\n";
		push(@out,$line);
		push(@fout,$sent);
		push(@fout,@out);
		$sent = '';
		@out = '';
		$flag =0 ;
	}
	if($flag == 1) {
		@token=split(/\t/, $line);
		$sent=$sent.$token[1]." ";
		push(@out,$line);
	}
}
print(@fout);

