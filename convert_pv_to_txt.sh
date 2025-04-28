#!/bin/bash

# Script to convert all ProVerif (.pv) files to text (.txt) files
# for easy viewing and documentation

# Create a log file
echo "ProVerif File Conversion $(date)" > conversion_log.txt
echo "----------------------------------------" >> conversion_log.txt

# Find all .pv files and convert them
for pvfile in *.pv; do
    # Skip if no .pv files are found
    [ -e "$pvfile" ] || continue
    
    # Create output filename (keep original name but change extension)
    txtfile="${pvfile%.pv}_code.txt"
    
    # Copy content with line numbers and formatting
    echo "# ProVerif Model: $pvfile" > "$txtfile"
    echo "# Generated on: $(date)" >> "$txtfile"
    echo "# ----------------------------------------" >> "$txtfile"
    echo "" >> "$txtfile"
    
    # Add line numbers and content
    line_num=1
    while IFS= read -r line; do
        printf "%3d: %s\n" "$line_num" "$line" >> "$txtfile"
        ((line_num++))
    done < "$pvfile"
    
    # Add a summary of the file
    echo "" >> "$txtfile"
    echo "# ----------------------------------------" >> "$txtfile"
    echo "# Summary:" >> "$txtfile"
    echo "# - Total lines: $((line_num-1))" >> "$txtfile"
    
    # Count specific elements (types, functions, processes, etc.)
    echo "# - Type declarations: $(grep -c "type " "$pvfile")" >> "$txtfile"
    echo "# - Function declarations: $(grep -c "fun " "$pvfile")" >> "$txtfile"
    echo "# - Events: $(grep -c "event " "$pvfile")" >> "$txtfile"
    echo "# - Processes: $(grep -c "let " "$pvfile")" >> "$txtfile"
    
    echo "Converted $pvfile -> $txtfile"
    echo "Converted $pvfile -> $txtfile" >> conversion_log.txt
done

echo "Conversion complete. See conversion_log.txt for details."
