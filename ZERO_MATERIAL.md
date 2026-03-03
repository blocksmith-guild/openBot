# 🛡️ Zero Material Protocol: The BIP39 Paper Key Guide

> *"If you don't store it, they can't steal it."*

## 📜 The Philosophy
**Zero Material** is the architectural mandate that no high-value master secrets (like symmetric keys or private keys) should exist as static files at rest. Instead, we treat security as a **Signal** (human knowledge/mnemonic) rather than **Material** (a binary file).

By converting our `git-crypt` keys into 24-word BIP39 mnemonics, we achieve:
1.  **Vaultless Portability**: You can rebuild your entire secure workspace on a fresh machine using only your memory or a physical paper key.
2.  **Zero Breach Liability**: If your machine is seized or breached while "cold," the attacker finds zero reversible secrets.
3.  **Deterministic Lineage**: Your `git-crypt` key and your **NHI Trust Anchor** share the same genetic seed, ensuring a unified identity across your agents.

---

## 🛠️ The Workflow

### 1. Create Your Paper Key (Extraction)
If you already have an active `git-crypt` key in your `.git` folder, you must extract the "Signal" before deleting the "Material."

**Run the extraction script:**
```bash
perl bin/extract-mnemonic.pl
```
*   **Action**: This reads your 148-byte `.git/git-crypt/keys/default` file and converts the AES-256 key into **24 words**.
*   **Storage**: Write these words down on physical paper or stamp them into steel. **Never store them in a digital file or cloud notes.**

### 2. Enter the "Zero Material" State (Sanitization)
Once your paper key is verified, you can delete the binary liability from your disk.

**Sanitize your workspace:**
```bash
./bin/trashit.sh .git/git-crypt/keys/default
```
*   **Result**: Your repository is now "locked" at rest. The key is gone. You are now operating in a state of **Mathematical Immunity**.

### 3. Recover Your Workspace (Re-hydration)
When you need to work, you "blink" the material back into existence using your paper key.

**Run the recovery script:**
```bash
perl bin/zero-material-key.pl 'your twenty four words go here in order' [optional_passphrase]
```
*   **Mechanism**: The script uses **Scrypt KDF** (Type-Length-Value compliant) to deterministically reconstruct the 148-byte key file with the correct `GITCRYPTKEY` header, versioning, and HMAC-SHA256 segments.
*   **Result**: `git-crypt` is now ready to unlock your files (`git-crypt unlock`).

---

## ⚠️ Critical Warnings
*   **Passphrase Entropy**: If you use an optional passphrase during recovery, it becomes part of the key derivation. You **must** remember it to recover the key again.
*   **Word Order**: The order of the 24 words is non-negotiable. Word 1 is not Word 2.
*   **Clean Up**: After finishing a sensitive session, remember to use `trashit.sh` on the key file again to return to a Zero Material state.

---
*"The secret to safety is to have no secrets to hide."*
