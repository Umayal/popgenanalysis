$viterbi=$ARGV[0]; # Viterbi File obtained from RFMIX Software - RFMIX determines the genotypes comes from which ancestry in case of the hybrid population come from 3 ancestries ex: Latin Americans -> Africans + Europeans + Native Americans
$vcf=$ARGV[1];  #variant file 
$mask_vcf=$ARGV[2]; #output file -> In the ouput file, This program masks the genotypes of two ancestries (Europeans and africans) in the admixed population and in PCA, then if we run Admix-tools or RFMIX or any other Admixture software, the Latin americans will be treated as Native Americans as the other two ancestries in them are masked.

	open(A,"< $viterbi")|| print "Unable to read the file\n";
	
	open(C,"> $mask_vcf")|| print "Unable to read the file\n";
	
	$pos=1;
	
	while(<A>){
	
		$i=0;
	
		$j=1;
		
		$x=0;
		
		$str="";
		
		$e=$_;
	
		chomp($e);
	
		@a=split(' ',$e);
			
		while($a[$i] ne ""){
			
			$str=$str."\t".$a[$i]."|".$a[$j];			
					
			$i=$i+2;
				
			$j=$j+2;
				
		}
		
		$arr[$pos]=$pos."\tN\tN\tN\tN\tN\tN\tN\tN".$str;
		
		#print  C$arr[$pos],"\n";
			
		$pos++;
		
	}
	
	close(A);
	
	
	open(B,"< $vcf")|| print "Unable to read the file\n";
	
	$loc=1;
	
		while(<B>){

			$e=$_;
	
			chomp($e);
			
			if($e =~ /\#/){
			
				print C $e,"\n";
			
			}
			
			else{
		
				if($arr[$loc] ne ""){
				
					print $loc,"\n";
			
					#print C $arr[$loc],"\n";		
										
					@f=split(' ',$arr[$loc]);
					
					@g=split(' ',$e);
					
					print C $g[0],"\t",$g[1],"\t",$g[2],"\t",$g[3],"\t",$g[4],"\t",$g[5],"\t",$g[6],"\t",$g[7],"\t",$g[8],"\t";
					
			
					
					$u=9;
					
					while($g[$u] ne ""){
					
						$fga="";
						
						@fa=split(/\|/,$f[$u]); #viterbi format
						
						@ga=split(/\|/,$g[$u]); #vcf
						
						if(($fa[0]==1) && ($fa[1]==1)){
						
							print C $ga[0],"|",$ga[1],"\t";
							
						}
						
						elsif(($fa[0]==1) && ($fa[1]==2)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==2) && ($fa[1]==1)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==2) && ($fa[1]==2)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==1) && ($fa[1]==3)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==2) && ($fa[1]==3)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==3) && ($fa[1]==3)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==3) && ($fa[1]==2)){
						
							print C "./.\t";
							
						}
						
						elsif(($fa[0]==3) && ($fa[1]==1)){
						
							print C "./.\t";
							
						}
						
						else{
						
							print C $ga[0],"|",$ga[1],"\t";
						
						}
						
						
						
						#print C $g[$u],"\t";
						
						$u++;
					
					}
					
					print C "\n";
					
					#print C $arr[$loc],"\n";		
			
					$loc++;
				}
				
				
				
			}
			
			}
	
	close(B);
	
	close(C);


	