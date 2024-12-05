use strict;
use warnings;
my $rfile="input.txt";
open(IN,$rfile)||die $!;
my %ruleA;
my %ruleB;
my $sum=0;
while(<IN>){
	chomp;
	if($_=~/\|/){
		my @s=split(/\|/,$_);
		if(exists $ruleA{$s[0]}){
			my $parr=$ruleA{$s[0]};
			push @$parr,$s[1];
			$ruleA{$s[0]}=\@$parr;
		}else{
			my @x;
			push @x,$s[1];
			$ruleA{$s[0]}=\@x;
		}
		if(exists $ruleB{$s[1]}){
			my $parr=$ruleB{$s[1]};
			push @$parr,$s[0];
			$ruleB{$s[1]}=\@$parr;
		}else{
			my @x;
			push @x,$s[0];
			$ruleB{$s[1]}=\@x;
		}
	}
}

my $t2c="F2C.txt";
open(TC,$t2c)||die $!;
while(<TC>){
	chomp;
	order_check($_);
}


sub order_check{
	my $ins=shift;
	my @s=split(/\,/,$ins);
	my $flag=0;
	my $t_i;
	my $t_j;
	for(my $i=0;$i<scalar(@s);$i++){
		my @ritmes;
		if(exists $ruleA{$s[$i]}){
			my $hhA=$ruleA{$s[$i]};
			@ritmes=@$hhA;
			for(my $j=$i+1;$j<scalar(@s);$j++){
				if ( grep( /^$s[$j]$/, @ritmes ) ) {
					#print "$s[$i] found $s[$j] in @ritmes\n";
				}else{
					#print "$s[$i] not found $s[$j] in @ritmes\n";
					$t_i=$i;
					$t_j=$j;
					$flag=1;
					last;
				}
			}
			if($flag==1){
				last;
			}
		}else{
			if(exists $ruleB{$s[$i]}){
				my $hhB=$ruleB{$s[$i]};
				@ritmes=@$hhB;
				for(my $j=$i-1;$j>0;$j--){
					if ( grep( /^$s[$j]$/, @ritmes ) ) {
						#print "*$s[$i] found $s[$j] in @ritmes\n";
					}else{
						#print "*$s[$i] not found $s[$j] in @ritmes\n";
						$t_i=$i;
						$t_j=$j;
						$flag=1;
						last;
					}
				}
				for(my $j=$i+1;$j<scalar(@s);$j++){
					if ( grep( /^$s[$j]$/, @ritmes ) ) {
						#print "**$s[$i] should not but found $s[$j] in @ritmes\n";
						$t_i=$i;
						$t_j=$j;
						$flag=1;
						last;
					}else{
						#print "**$s[$i] not found $s[$j] in @ritmes\n";
					}
				}
				if($flag==1){
					last;
				}
			}
		}
	}
	if($flag==1){
		my $new_ordered=adjust($ins,$t_i,$t_j);
		order_check($new_ordered);
	}else{
		my @s=split(/\,/,$ins);
		my $midpos=int((scalar(@s)-1)/2);
		print "$ins\tOK\tMID:$s[$midpos]|\n";
		$sum=$sum+$s[$midpos];
		print "TotalSum:$sum\n";
	}
}

sub adjust{
	my ($in_order,$A,$B)=@_;
	my @inputstr=split(/\,/,$in_order);
	my $temp = $inputstr[$A];
	$inputstr[$A] = $inputstr[$B];
	$inputstr[$B] = $temp;
	my $ostr=join(",",@inputstr);
	return $ostr;
}