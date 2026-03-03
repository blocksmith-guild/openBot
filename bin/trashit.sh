#!/bin/bash
# bin/trashit.sh - Secure, reversible file de-materialization for OpenBot
# Intent: Move files to a .trash sanctuary while maintaining audit trails.

FILE="$1"
if [ -z "$FILE" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

if [ ! -e "$FILE" ]; then
    echo "Error: Signal '$FILE' not found."
    exit 1
fi

ABS_FILE=$(readlink -f "$FILE")
BASENAME=$(basename "$ABS_FILE")
# Try to find .trash in current or parent dirs, default to current/./trash
TRASH_DIR=".trash"

# Ensure trash sanctuary exists
[ ! -d "$TRASH_DIR" ] && mkdir -p "$TRASH_DIR"

# RCS Audit: Check in before de-materializing if tracked
if [ -f "${FILE},v" ] || [ -f "RCS/${FILE},v" ]; then
    echo "Signal detected in RCS. Performing final audit check-in..."
    ci -u -m"De-materializing to .trash: $(date)" "$FILE"
fi

# Conflict Resolution (Thermodynamic Stability)
TARGET="${TRASH_DIR}/${BASENAME}"
if [ -e "$TARGET" ]; then
    COUNT=1
    while [ -e "${TRASH_DIR}/${BASENAME}~${COUNT}" ]; do
        ((COUNT++))
    done
    TARGET="${TRASH_DIR}/${BASENAME}~${COUNT}"
fi

# Perform the de-materialization
mv "$FILE" "$TARGET"
echo "Signal de-materialized to: $TARGET"

# Verification
if [ ! -e "$FILE" ]; then
    echo "Success: Workspace entropy reduced."
else
    echo "Error: De-materialization failed."
    exit 1
fi

# "Nothing is ever truly gone; it just becomes a different kind of signal."
