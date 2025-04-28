#!/bin/bash

# Script to run ProVerif on all .pv files in the current directory
# and save the output to .txt files

# Create a log file for overall results
echo "ProVerif Batch Processing $(date)" > verification_summary.txt
echo "----------------------------------------" >> verification_summary.txt

# Find all .pv files and process them
for pvfile in *.pv; do
    # Skip if no .pv files are found
    [ -e "$pvfile" ] || continue
    
    # Extract the base filename without extension
    basename="${pvfile%.pv}"
    outfile="${basename}_results.txt"
    
    echo "Processing $pvfile -> $outfile"
    echo "Processing $pvfile -> $outfile" >> verification_summary.txt
    
    # Run ProVerif and capture output
    proverif "$pvfile" > "$outfile" 2>&1
    
    # Check if verification was successful and add to summary
    if grep -q "RESULT.*true" "$outfile"; then
        echo "  ✓ Verification SUCCESSFUL: Secure properties verified" >> verification_summary.txt
    elif grep -q "RESULT.*false" "$outfile"; then
        echo "  ✗ Verification FAILED: Security properties not satisfied" >> verification_summary.txt
    else
        echo "  ? Verification INCONCLUSIVE or ERROR occurred" >> verification_summary.txt
    fi
    
    echo "----------------------------------------" >> verification_summary.txt
done

echo "Batch processing complete. See verification_summary.txt for an overview."
