use strict;
use warnings;

my $file="input.txt";
open(IN,$file)||die $!;

my $max_leap=3;
my $min_leap=1;

my $safe_count=0;
my $ec_safe_count=0;

while(<IN>){
	chomp;
	my @line=split(/\s+/,$_);

	my $trigger=0;
	$trigger=valid(\@line);
	print "$_\t##$trigger\n";
	if($trigger !=0){
		my $ecres=ec(\@line,$trigger);
		$ec_safe_count=$ec_safe_count+$ecres;
		next;
	}
	$safe_count++;
}


sub valid{
	my $ll=shift;
	my $itri=0;
	my $prev=0;
	for(my $i=0;$i<scalar(@$ll)-1;$i++){
		my $diff=@$ll[$i]-@$ll[$i+1];
		if(abs($diff)<$min_leap){
			$itri=1;
			last;
		}
		if(abs($diff)>$max_leap){
			$itri=2;
			last;
		}
		if($i==0){
			$prev=$diff;
		}
		if($prev*$diff<0){
			$itri=3;
			last;
		}
	}
	return $itri;
}
sub ec{
	my ($s,$trig)=shift;
	
	my $cc=0;
	for(my $i=0;$i<scalar(@$s);$i++){
		my @sfd=@$s;
		splice @sfd, $i, 1;
		my $vs=valid(\@sfd);
		if($vs ==0){
			$cc++;
			print "@sfd\t##Fix\n";
			return 1;
			last;
		}else{
			next;
		}
	}
	if($cc==0){
		print "####No fix\n";
		return 0;
	}
}
print "$safe_count\t$ec_safe_count\n";