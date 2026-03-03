#!/usr/bin/perl
# $Intent: generate NHI Trust Anchor from 24-word mnemonic (Zero Material) $

use lib "$ENV{RADIANT}/lib";
use encode qw(decode_bip39 encode_mbase58);
use Crypt::ScryptKDF qw(scrypt_raw);
use Crypt::PK::ECC;
use strict;

my $mnemonic_in = shift || die "Usage: $0 'word1 word2 ... word24' [passphrase]
";
my $passphrase = shift || "";
my $intent = shift || "NHI Trust Anchor v1";

# Convert 24 words to 32 bytes of entropy (BIP39)
my $entropy_raw = decode_bip39($mnemonic_in);
if (length($entropy_raw) != 32) {
    die "Error: Mnemonic must be 24 words (256 bits of entropy). Got " . length($entropy_raw)*8/11 . " words instead.
";
}

# Derive 32 bytes for secp256k1 private key
my $N = 1 << 14;
my $r = 8;
my $p = 1;
my $sk_raw = scrypt_raw($entropy_raw, $passphrase . $intent, $N, $r, $p, 32);

my $curve = 'secp256k1';
my $sk = Crypt::PK::ECC->new();
$sk->import_key_raw($sk_raw, $curve);
my $pk_raw = $sk->export_key_raw('public_compressed');
my $pku = encode_mbase58($pk_raw);
my $sku = encode_mbase58($sk_raw);

# Export public key to trust.anchor.asc (BlockSmith format)
open my $fh, '>', 'trust.anchor.asc' or die "Cannot write trust.anchor.asc: $!
";
print $fh "-----BEGIN BLOCKSMITH TRUST ANCHOR-----
";
print $fh "Lineage: $intent
";
print $fh "Public-Key: Z$pku
";
print $fh "-----END BLOCKSMITH TRUST ANCHOR-----
";
close $fh;

print "Generated NHI Trust Anchor:
";
print "Public Key: Z$pku
";
print "Saved to trust.anchor.asc
";

# Optional: secret.seed.asc (mnemonic representation)
open my $sfh, '>', 'secret.seed.asc' or die "Cannot write secret.seed.asc: $!
";
print $sfh "-----BEGIN BLOCKSMITH SECRET SEED-----
";
print $sfh "Format: BIP39 (24 words)
";
print $sfh "Note: Do not store this file in public repositories!
";
print $sfh "--- (Content omitted for security) ---
";
print $sfh "-----END BLOCKSMITH SECRET SEED-----
";
close $sfh;
