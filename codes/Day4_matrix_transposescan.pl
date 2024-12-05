use strict;
use warnings;

my $file=shift;
open(IN,$file)||die $!;
my $r1_count=0;
my $r2_count=0;
my @strarr;
while(<IN>){
	chomp;
	push @strarr,$_;

}
close(IN);
my @o1_count=match_count(\@strarr);
#print "$o1_count[0]\t$o1_count[1]\n";
my @xcxv=transpose(\@strarr);
my $sum1=$o1_count[0]+$o1_count[1];

#Scan #2 ##
my @o2_count=match_count(\@xcxv);
#print "$o2_count[0]\t$o2_count[1]\n";
my $sum2=$o2_count[0]+$o2_count[1];
#Scan #3 ##
my ($diag1A,$diag1B)=diag(\@strarr);
#print "@$diag1A,@$diag1B\n";

my @o3_countA=match_count($diag1A);
my @o3_countB=match_count($diag1B);
#print "$o3_countA[0]\t$o3_countA[1]\t$o3_countB[0]\t$o3_countB[1]\n";
my $sum3=$o3_countA[0]+$o3_countA[1]+$o3_countB[0]+$o3_countB[1];

my $total=$sum3+$sum2+$sum1;
print "Total:$total\n";

sub match_count{
	my $s=shift;
	my $r3_count=0;
	my $r4_count=0;
	print "\n_____________________\n";
	foreach my $ele (@$s){
		#print "$ele\n";
		my $countA = () = $ele =~/XMAS/g;
		my $countB = () = $ele =~/SAMX/g;
		$r3_count=$r3_count+$countA;
		$r4_count=$r4_count+$countB;
	}
	return $r3_count,$r4_count;
}


# Part2

match_mas_count($diag1A);
match_mas_count($diag1B);

sub match_mas_count{
	my ($s,$fl)=@_;
	my $pass_count=0;
	my %locator;
	my %fullmat;
	my $row_c=0;
	my $maxc=0;
	foreach my $ele (@$s){
		my $col_c=0;
		my @sx=split //,$ele;
		foreach my $sce (@sx){
			$fullmat{$row_c}{$col_c}=$sce;
			$col_c++;
		}
		##notice that $ele =~/MAS|SAM/g does not work properly for palindrome sequences like MASAM##
		while($ele =~/MAS/g){
			print "##$row_c|$-[0]\n";
			$locator{$row_c}{$-[0]}=1;
			$maxc++;
		}
		while($ele =~/SAM/g){
			print "##$row_c|$-[0]\n";
			$locator{$row_c}{$-[0]}=1;
			$maxc++;
		}
		$row_c++;
	}
	foreach my $t_row (keys %locator){
		foreach my $t_col (keys %{$locator{$t_row}}){
			my $check_str1=$fullmat{$t_row-2}{$t_col+2};
			my $check_str2=$fullmat{$t_row+2}{$t_col};
			my $ccstr=$check_str1."A".$check_str2;
			if($ccstr eq "SAM" || $ccstr eq "MAS"){
				$pass_count++;
			}
		}
	}
	print "found: $maxc\tpass:$pass_count\n";
}


#scan 3 Diagnal lines##

sub diag{
	my $oarr=shift;
	my @oa1=@$oarr;
	my @oa2=@$oarr;
	my @new_array;
	my $xcv=length($oa1[1]);
	for(my $i=0;$i<$xcv;$i++){
		my $L_padN = "N" x ($xcv-$i);
		my $R_padN = "N" x $i;
		$oa1[$i]=$L_padN.$oa1[$i].$R_padN;
	}
	my @ww1=transpose(\@oa1);
	my $xcv2=length($oa2[1]);
	for(my $i=0;$i<$xcv2;$i++){
		my $L_padN = "N" x ($xcv2-$i);
		my $R_padN = "N" x $i;
		$oa2[$i]=$R_padN.$oa2[$i].$L_padN;
	}
	my @ww2=transpose(\@oa2);
	return (\@ww1,\@ww2);
	
}

sub transpose{
	my $oarr=shift;
	my @oa=@$oarr;
	my @new_array;
	my $xcv=length($oa[1]);
	for(my $i=0;$i<$xcv;$i++){
		#print "$oa[$i]\t$i\n";
		my @new_row;
		for(my $j=0;$j<scalar(@oa);$j++){
			push @new_row,substr($oa[$j],$i,1);
		}
		my $str_new_row=join("",@new_row);
		push @new_array,$str_new_row;
	}
	return @new_array;
}