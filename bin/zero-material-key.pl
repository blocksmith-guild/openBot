#!/usr/bin/perl
# $Intent: recover git-crypt key from a 24-word mnemonic (Zero Material) $

use lib "$ENV{RADIANT}/lib";
use encode qw(decode_bip39);
use Crypt::ScryptKDF qw(scrypt_raw);
use strict;

my $mnemonic_in = shift || die "Usage: $0 'word1 word2 ... word24' [passphrase]\n";
my $passphrase = shift || "";

# Convert 24 words to 32 bytes of entropy (BIP39)
my $entropy_raw = decode_bip39($mnemonic_in);
if (length($entropy_raw) != 32) {
    die "Error: Mnemonic must be 24 words (256 bits of entropy). Got " . length($entropy_raw)*8/11 . " words instead.\n";
}

# Derive 96 bytes of key material (32 for AES, 64 for HMAC)
# We use scrypt for robust KDF
my $N = 1 << 14; # Moderate cost
my $r = 8;
my $p = 1;
my $derived = scrypt_raw($entropy_raw, $passphrase . "git-crypt-zmt-v1", $N, $r, $p, 96);

my $aes_key = substr($derived, 0, 32);
my $hmac_key = substr($derived, 32, 64);

# Construct git-crypt key file (148 bytes total)
# 1. Preamble (16 bytes)
my $preamble = "\0GITCRYPTKEY" . pack('N', 1); # Magic (12) + Version (4)

# 2. Header Fields (TLV) - only END marker (4 bytes)
my $header_fields = pack('N', 0); # Type 0 (Header End)

# 3. Key Entry Fields (TLV)
my $key_version = pack('N', 1) . pack('N', 4) . pack('N', 1); # Type 1, Len 4, Val 1
my $key_aes     = pack('N', 3) . pack('N', 32) . $aes_key;    # Type 3, Len 32, Val $aes
my $key_hmac    = pack('N', 5) . pack('N', 64) . $hmac_key;   # Type 5, Len 64, Val $hmac
my $key_end     = pack('N', 0);                               # Type 0 (Entry End)

my $key_content = $preamble . $header_fields . $key_version . $key_aes . $key_hmac . $key_end;

# Verification
if (length($key_content) != 148) {
    die "Internal error: key content size is " . length($key_content) . " bytes, expected 148.\n";
}

# Output to stdout (to be redirected) or write to file
my $target = ".git/git-crypt/keys/default";
if (-f $target) {
    print STDERR "Warning: $target already exists. Overwrite? (y/n) ";
    my $ans = <STDIN>;
    exit if ($ans !~ /^y/i);
}

open my $fh, '>', $target or die "Cannot open $target for writing: $!\n";
binmode $fh;
print $fh $key_content;
close $fh;

chmod 0600, $target;
print "Successfully recovered git-crypt key from mnemonic to $target\n";
