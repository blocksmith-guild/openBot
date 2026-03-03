#!/usr/bin/perl
# $Intent: extract 24-word mnemonic from current git-crypt key for Zero Material recovery $

use lib "$ENV{RADIANT}/lib";
use encode qw(encode_bip39);
use strict;

chomp(my $top = `git rev-parse --show-toplevel`);
my $key_file = $top . '/.git/git-crypt/keys/default';
if (! -f $key_file) {
    die "git-crypt key not found at $key_file
";
}

open my $fh, '<', $key_file or die "Cannot open $key_file: $!
";
binmode $fh;
my $content;
read $fh, $content, 148;
close $fh;

# Extract the 32-byte AES key (starts at byte 40, length 32)
# Structure:
# 0-15: Header
# 16-19: Padding
# 20-23: Version
# 24-27: Number of keys
# 28-31: Padding
# 32-35: Type (3)
# 36-39: Length (32)
# 40-71: AES Key
my $aes_key = substr($content, 40, 32);

# Convert to 24 words (256 bits of entropy)
my $words = encode_bip39($aes_key);
printf "24-word mnemonic: %s\n", $words;

print "
Keep these words safe! You can use them to recover your git-crypt key without storing the .key file.
";
