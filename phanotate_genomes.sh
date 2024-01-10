#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p IMGVR_output_proteins

# Loop through each .fasta file in the input_genomes directory
for fasta_file in IMGVR_genomes/*.fasta; do
    # Extract the filename without the extension for naming output files
    filename=$(basename -- "$fasta_file")
    filename_noext="${filename%.*}"
    
    # Run phanotate.py on each .fasta file and output as .gbk
    phanotate.py "$fasta_file" -f genbank -o "IMGVR_output_proteins/${filename_noext}.gbk"
    
    # Run genbank.py on the .gbk output file to get the .faa output
    genbank.py "IMGVR_output_proteins/${filename_noext}.gbk" -f faa -o "IMGVR_output_proteins/${filename_noext}.faa"
    
    # Print a message to indicate progress
    echo "Processed $filename_noext"
done
