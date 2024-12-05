use strict;
use warnings;

my $file="input.txt";
open(IN,$file)||die $!;
my $istr='';
while(<IN>){
	chomp;
	$istr=$istr.$_;
}
close(IN);

#Part One#
my $pt1_sum=mul($istr);
print "Pt1 sum:$pt1_sum\n";
#Part Two#
my @subA=split(/do\(\)/,$istr);
my $total_sum=0;
foreach my $strA (@subA){
	my @subB=split(/don\'t\(\)/,$strA);
	my $subsum=mul($subB[0]);
	#print "$strA\n$subB[0]\n$subsum\n";
	$total_sum=$total_sum+$subsum;
}
print "Pt2 sum: $total_sum\n";

sub mul{
	my $ss=shift;
	#print"###$ss\n";
	my @matches = $ss =~/mul\(\d+,\d+\)/g;
	my $prodsum=0;
	foreach my $e (@matches){
		my @s=split(/\,/,$e);
		my $a=substr($s[0],4);
		my $b=substr($s[1],0,-1);
		my $prod =$a*$b;
		$prodsum=$prodsum+$prod;
	}
	return $prodsum;
}
