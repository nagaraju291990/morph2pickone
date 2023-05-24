
# Printing the file

while($line=<>)
{
	$line=~s/(.*)\t(.*)\t[A-z]+(\t)?/$2/g;
	print "$2\n";
}
