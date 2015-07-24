#!/usr/bin/perl
# install parallel::forkmanager module sudo apt-get install libparallel-forkmanager-perl
# or cpan Parallel::ForkManager
# @version 1.0
# @author M-A
# Perl Lov3r :)
use LWP::UserAgent;
use Getopt::Long;
use Parallel::ForkManager;
 
 
my $datestring = localtime();
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
 
our($url,$file,$keyward,$thread);
sub randomagent {
my @array = ('Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',
'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20120101 Firefox/29.0',
'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)',
'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36',
'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.67 Safari/537.36',
'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31'
);
my $random = $array[rand @array];
return($random);
}
 
GetOptions(
    'url|u=s' => \$url,
    'file|f=s' => \$file,
    'keyward|w=s' => \$keyward,
    'threads|t=i'   => \$thread,
) || &flag();
 
if(!defined($url) || !defined($file)|| !defined($keyward) || !defined($thread) ){
        &flag();
        exit;
}
 
print "[+] Started : $datestring\n";
 
open(my $arq,'<'.$file) || die($!);
my @paths = <$arq>;
@paths = grep { !/^$/ } @paths;
close($arq);
print "[".($#paths+1)."] URL to test upload\n\n";
 
my $pm = new Parallel::ForkManager($thread);# preparing fork
foreach my $path (@paths){#loop => working
    my $pid = $pm->start and next;
    chomp($path);
    if($url !~ /^(http|https):\/\//){
        $url = 'http://'.$url;
    }
   
    expqq($url,$path);
    $pm->finish;
}
$pm->wait_all_children();
 
sub expqq{
    my $useragent = randomagent();#Get a Random User Agent
    my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });#Https websites accept
    $ua->timeout(10);
    $ua->agent($useragent);
    my ($url,$path) = @_;
    #print "[Testing] $url\n";
    my $web = $url."/".$path;
    my $notfound = $ua->get($url."/notfound");
    my $notfound_length = length($notfound->content);
    my $response = $ua->get($web);
    if ($response->code == 200){
        #print "[OK] Path can be exist check with second methode\n";
        #print "[*] testing with length page\n";
        my $length = length($response->content);
        if ($length != $notfound_length) {
            #print "[OK] Path can be exist check with last methode\n";
            if ($notfound->content=~/$keyward/) {
                if ($response->content!=/$keyward/){
                    print "[OK] Found : $web\n";
                    save ("log.txt",$web);
                }
            }    
        }  
    }    
}
 
 
sub flag {
    print "\n[*] Path Checker \n";
    print "[*] Coder : M-A\n";
    print "[+] Idea : Uzundz & s4e\n";
    print "[+] Usage :\n";
    print "[REQUIRED] -u | website (Target to test).\n";
    print "[REQUIRED] -f | file  (Path to check).\n";
    print "[REQUIRED] -w | Keyward (Key to check into page).\n";
    print "[REQUIRED] -t | forknumber (Namber of fork).\n";
    print "\nExample: check.pl -u site.com -f path.txt -w Keyward -t 5 \n\n";
   
}
 
sub save {
    my ($file,$item) = @_;
    open(SAVE,">>".$file);
    print SAVE $item."\n";
    close(SAVE);
}
