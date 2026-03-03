#!/usr/bin/perl

use open qw(:std :encoding(utf8));

my $log = 0;
my $flat = 0;
my $simu = 0;
my $copy = 0;
my $pathdir = 0;
my $keep = 0;
my $delete = 0;
my $force = 0;
my $bname = undef;
my $ext = undef;
my $nospace = 1;
my $nospecial = 1;
my $backupdir = './backups';
chomp( my $top = `git top`);
while (@ARGV && $ARGV[0] =~ m/^-/)
{
  $_ = shift;
  #/^-(l|r|i|s)(\d+)/ && (eval "\$$1 = \$2", next);
  if (/^-v(?:erbose)?/) { $verbose= 1; }
  elsif (/^-n/) { $simu= 1; }
  elsif (/^--?l(?:og)?/) { $log= 1; $simu = 1; }
  elsif (/^--?c(?:o?py?)?/) { $copy= 1; }
  elsif (/^--?b(?:a?c?k(?:up)?)?/) { $backupdir= shift; } # provide backup dir
  elsif (/^--?p(?:ath)?/) { $pathdir= 1; }
  elsif (/^--?k(?:eep)?/) { $keep= 1; }
  elsif (/^--?bn(?:ame)?/) { $bname= shift; } # provide base name
  elsif (/^--?d(?:elete)?/) { $delete= 1; }
  elsif (/^--?f(?:force)?/) { $force= 1; }
  elsif (/^--?e(?:xt?)?/) { $ext= shift; } # provide extension
  elsif (/^--?no?s(?:pace)?/) { $nospace= 1; }
  elsif (/^--?no?spe(?:cial)?/) { $nospecial= 1; }
  elsif (/^--?spe(?:cial)?/) { $nospecial= 0; }
  elsif (/^--?s(?:pace)?/) { $nospace= 0; }
  elsif (/^--?f(?:lat)?/) { $flat= 1; }
  else                  { die "Unrecognized switch: $_\n"; }

}
#understand variable=value on the command line...
eval "\$$1='$2'"while $ARGV[0] =~ /^(\w+)=(.*)/ && shift;

if (! -d $backupdir) {
  if (-d '$top/backups') {
    $backupdir = $top.'/backups';
  } elsif (-d '../backups') {
    $backupdir = '../backups';
  } elsif (-d '../../backups') {
    $backupdir = '../../backups';
  }
}


use Encode qw(decode encode);
my $file = shift;
if (! -f "$file") {
 $file = decode('UTF-8', $file);
}
if ( ! -f "$file") {
  printf "warn: ! -f %s\n",$file;
  $file =~ s/\.mp4/.mkv/;
  if (! -f $file && ! $simu) {
    die;
  }
}
printf "file: %s\n",$file;
my @ver = &version($file);
printf "ver: %s\n", join'; ',@ver;
printf "build: %s\n",$ver[-1];

if ($log) {
  local *LOG;
  my ($atime,$mtime,$ctime) = (lstat($file))[8,9,10];
  my $etime = ($mtime < $ctime) ? $mtime : $ctime;
  printf LOG '%s: %s %s %s # %s'."\n",$ver[-1],$ver[0],&sdate($etime),$file,$mtime;
  open LOG, '>>', 'version.log';
  printf 'log: %s %s %s %s'."\n",$ver[-1],$ver[0],&sdate($mtime),$file;
  close LOG;
  exit;
}

my ($fname,$path);
if (@ARGV) {
  $fname = shift; # if second argument use it as target name
} else {
  my $s = rindex($file,'/');
  $fname = ($s>0) ? substr($file,$s+1) : $file;
  $path = ($s>0) ? substr($file,0,$s+1) : '';
}

  $fname =~ s,\.[123]$,,; # remove simple versioning
  $fname =~ s,\.(?:old|bak|new)$,,; # remove old bak, etc. tags

if (! defined $bname) {
  my $p = rindex($fname,'.');
  $ext = ($p>0) ? substr($fname,$p+1) : 'blob';
  $bname = ($p>0) ? substr($fname,0,$p) : $file;
}
# add a leading f to uuid...
#
#123456789012345678901234567890123456 -> 36 chars
#8cd80098-4ba1-11f0-a0a7-2f7740b5f5a6
$bname =~ s,^,f, if ($bname =~ m/^[\-0-9a-f]{2,36}$/i);


   $bname =~ s,^\./,,;
   $bname =~ s,_[A-Z]{3}$,,; # remove jslib tag
   $bname =~ s,_+v\d\.\d+-[a-z]+,,; # remove version tag
   $bname =~ s,\(\d+\)$,,;
   $bname =~ s,-\d$,,;
   $bname =~ s,[\-_\s]+$,,;
   $bname =~ s,[#|—],_,g;

$ext =~ s/~\d$//;
$bname =~ s,[\[\]],_,g; # remove []
$bname =~ s,[()],_,g; # no ()
$bname =~ s,[""＂],_,g; # no "
$bname =~ s,['’],-,g; # no '
$bname =~ s,=,_,g; # no =
$bname =~ s,^[\-_\s]+,,;

print "bname: $bname\n";
#print "ext: $ext\n";

if ($nospace) {
 $bname =~ s, - ,_,g;
 $bname =~ s, +,-,g;
}
 my $special = decode_utf8("：");
 $bname =~ s/[$special]/_/g;
 $bname =~ s/[:\|\!]/_/g;
 $bname =~ s/€/EU/g;
 $bname =~ s/,[-_]/,/g;

 $bname =~ s/[\-_]{2,}/_/g;
 #$bname =~ s,&,﹠,g;
 $bname =~ s,&,n,g;
 $bname =~ s,&,%26,g;
 $bname =~ s,",＂,g;
 $bname =~ s,',’,g;
 $bname =~ s,_+,_,g;
 $bname =~ s,-+,-,g;
 $bname =~ s,_$,,; # remove trailing _

if ($nospecial) {
  $bname =~ s/\*/~/g;
  #use Unicode::Normalize qw(NFD);
  #$bname = NFD($bname); # Normalize to NFD (decomposed form)
  #$bname =~ s/\p{M}//g; # Remove combining diacritical marks (accents)
  $bname = decode_utf8($bname);
  #$bname = encode_utf8($bname);

  use Text::Unidecode qw(unidecode);
  $bname = unidecode($bname);
  $bname =~ s,/,-,g;
  $bname =~ s,\$,S,g;
  #$bname =~ tr,A-Za-z0-9\+\-_,\.,-,c;
  $bname =~ s/([\000-\032\`%?&\<\( \)\>\177-\377])/-/g;
  $bname =~ s,[\[\]],_,g; # remove []
}

if (-d $backupdir) {
  $bname = $backupdir.'/'.$bname,
}
my $name = sprintf '%s_v%.2f-%s.%s',$bname,@ver,$ext;

if ($pathdir) {
 printf "path: %s\n",$path;
 $name = sprintf '%s%s_v%.2f-%s.%s',$path,$bname,@ver,$ext;
}
if ($flat) {
 $name =~ s,/,-,g;
 $name =~ s/^-+//;
}
printf "name: %s\n",$name;

if ($simu == 0) {
  if ($copy == 1) {
    copy($file, $name) or warn $!;
    printf "cmd: cp -p %s %s\n",$file,$name;
  } elsif ($keep == 1) {
    link $file, $name or warn $!;
    printf "cmd: link %s %s\n",$file,$name;
  } else {
    if (! -e "$name") {
      rename $file, $name or ( copy($file, $name) && unlink $file) or warn $!;
      printf qq'undo: <-\n mv %s "%s"\n',$name,$file;
    } else {
      if ($force) {
        if ($name ne $file) {
          unlink $name;
          printf qq'# unlink "%s"\n',$name;
          rename $file, $name or ( copy($file, $name) && unlink $file) or warn $!;
          printf "cmd: mv -f %s %s\n",$file,$name;
        }
      } elsif ($delete) {
        if ($name ne $file) {
          unlink $file;
          printf qq'# rm -f %s # done /!\\ \n',$file;
        }
      } else {
        printf qq'warning -e "%s"\n',$name;
      }
    }
  }
} else {
  if ($log == 1) {
  }
}

exit $?;

# -----------------------------------------------------------------------
sub copy ($$) {
    my ($src, $trg) = @_;
    return undef unless -r $src;
    return undef if (-e $trg && ! -w $trg);
    my ($atime, $mtime) = (lstat($src))[8,9];  # Stat source before opens
    
    local *F1, *F2;
    open F1, '<', $src or warn "-r $src $!"; binmode(F1);
    open F2, '>', $trg or die "-w $trg $!"; binmode(F2);
    local $/ = undef;
    print F2 <F1>;
    close F1; close F2;
    
    utime $atime, $mtime, $trg;
    print "status: $?\n" if $?;
    return -s $trg;
}
# -----------------------------------------------------------------------
sub version {
  my @times = (lstat($_[0]))[8,9,10]; # atime,ctime,mtime
  printf "a.c.m.: %s\n",join(',',@times);
  my $etime = (sort { $a <=> $b } @times)[0] || $times[2] ;
  my $vtime = (sort { $a <=> $b} (@times)[1,2])[-1]; # biggest ctime,mtime...
  printf "vtime: %u # %s\n",$vtime,&wdate($vtime);
  printf "etime: %u # %s\n",$etime,&wdate($etime);
  my $version = &rev($etime);
  die if ($etime == 0 && ! $simu);

  if (wantarray) {
     my $shk_raw = &get_shake(160,$_[0]);
     printf "$_[0] : shk:%s\n",unpack('H*',$shk_raw) if $dbug;
     #my $pn = unpack('n',substr($shk_raw,-4)); # 16-bit
     my $pn = unpack('n',substr($shk_raw,-7,6)); # 40-bit

     my $build = &word($pn);
     return ($version, $build);
  } else {
     return sprintf '%g',$version;
  }
}
# -----------------------------------------------------------------------
sub rev {
  my ($sec,$min,$hour,$mday,$mon,$yy,$wday,$yday) = (localtime($_[0]))[0..7];
  my $rweek=($yday+&fdow($_[0]))/7;
  my $rev_id = int($rweek) * 4;
  my $low_id = int(($wday+($hour/24)+$min/(24*60))*4/7);
  my $revision = ($rev_id + $low_id) / 100;
  return (wantarray) ? ($rev_id,$low_id) : $revision;
}
# -----------------------------------------------------
sub wdate { # return a simpler human readable date 
  my $tic = int($_[0]);
  my $DoW = [qw( Sun Mon Tue Wed Thu Fri Sat )];
  my ($sec,$min,$hour,$mday,$mon,$yy,$wday) = (localtime($tic))[0..6];
  my ($yr4,$yr2) =($yy+1900,$yy%100);
  my $date = sprintf '%s, %02u/%02u %02u:%02u %04u',
             $DoW->[$wday],$mon+1,$mday, $hour,$min,$yr4;
  return $date
}
# -----------------------------------------------------------------------
sub get_shake { # use shake 256 because of ipfs' minimal length of 20Bytes
  use Crypt::Digest::SHAKE;
  my $len = shift;
  my $file = shift;
  my $msg = Crypt::Digest::SHAKE->new(256);
  local *F; open F,$file or do { warn qq{"$file": $!}; return undef };
  if ($file =~ m/\.txt$/i) {
    use Encode qw(encode_utf8 decode_utf8);
    binmode F, ':encoding(UTF-8)';
    local $/; # slurp mode
    my $content = <F>;
    $msg->add(encode_utf8($content));  # encode as UTF-8 bytes[4][2][5]
  } else {
        binmode F;
        $msg->addfile(*F);
    }
  my $digest = $msg->done(($len+7)/8);
  return $digest;
}
# -----------------------------------------------------
# max word: pabokyrulafivacanud QmVMDSybz4hQnEvxc5PrKqNS7osvLHADgifaZ3PXcJh9PF
sub word { # 20^4 * 6^3 + 20^3*6^4 words (25.4bit worth of data ...)
  use Math::Int64 qw(uint64);
  my $n = uint64($_[0]);
  my $vo = [qw ( a e i o u y )]; # 6
  my $cs = [qw ( b c d f g h j k l m n p q r s t v w x z )]; # 20
  my $str = '';
  $str = chr(ord('a') +$n%26);
  $n /= 26;
  my $vnc = ($str =~ /[aeiouy]/) ? 1 : 0;
  while ($n > 0) {
    if ($vnc) {
      my $c = $n % 20;
      $n /= 20;
      $str .= $cs->[$c];
      $vnc = 0;
      #print "cs: $n -> $c -> $str\n";
    } else {
      my $c = $n % 6;
      $n /= 6;
      $str .= $vo->[$c];
      $vnc = 1;
      #print "vo: $n -> $c -> $str\n";
    }
  }
  return $str;
}
# -----------------------------------------------------------------------
sub fdow {
   my $tic = shift;
   use Time::Local qw(timelocal);
   ##     0    1     2    3    4     5     6     7
   #y ($sec,$min,$hour,$day,$mon,$year,$wday,$yday)
   my $year = (localtime($tic))[5]; my $yr4 = 1900 + $year ;
   my $first = timelocal(0,0,0,1,0,$yr4);
   $fdow = (localtime($first))[6];
   #printf "1st: %s -> fdow: %s\n",&sdate($first),$fdow;
   return $fdow;
}
# -----------------------------------------------------------------------
sub sdate { # return a human readable date ... but still sortable ...
  my $tic = int ($_[0]);
  my $ms = ($_[0] - $tic) * 1000;
     $ms = ($ms) ? sprintf('%04u',$ms) : '____';
  my ($sec,$min,$hour,$mday,$mon,$yy) = (localtime($tic))[0..5];
  my ($yr4,$yr2) =($yy+1900,$yy%100);
  my $date = sprintf '%04u-%02u-%02u %02u.%02u.%02u',
             $yr4,$mon+1,$mday, $hour,$min,$sec;
  return $date;
}
# -----------------------------------------------------------------------
1; # $Source: /my/perl/scripts/rename $
