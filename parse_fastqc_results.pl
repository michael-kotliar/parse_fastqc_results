my %hash;
my $dir=$ARGV[0];
chomp $dir;
opendir(F,"$dir");
foreach my $f(readdir(F))
{
 if($f =~/_fastqc/)
 {
  opendir(R,"$dir/$f/");
  foreach my $m(readdir(R))
  {
   if($m =~/summary/)
   {
    open(V,"$dir/$f/$m");
    while(my $data = <V>)
    {
     chomp $data;
     my @arr=split(/\t/,$data);
     if($arr[0] eq "FAIL")
     {
      my $new=$arr[1];
      if(($new eq "Per base sequence quality")||($new eq "Per sequence quality scores")||($new eq "Overrepresented sequences")||($new eq "Adapter Content"))
      {
       $hash{$f}="Problem";
      }
     }
    }
    close V;
   }
  }
  closedir R;
 }
}
closedir F;
open(OUT,">files_with_problem.txt");
foreach my $m(keys %hash)
{
 print "$m\n";
 print OUT "$m\n";
}
close OUT;
