# Targeted_Metagenomics
Metabarcoding of mitochondrial 16S targeting aquatic invertebrates from eDNA extracted from a freshwater stream within Great Smoky Mountains National Park.


#How Does Whole Genome Metagenomics Work?

Taxonomic Profiling : Use databases and tools to identify which species of microbes are present in the sample(e.g. Kraken2, MetaPhlAn)

Functional Annotation : to know what these microbes are doing, so they identify the genes involved in various biological processes (e.g. PROKKA, EggNOG-mapper)

Sample Collection : Collect a sample from any environment (e.g., soil, water, human gut).

DNA Extraction : Extract DNA from all the microbes in the sample

DNA Fragmentation : The extracted DNA is randomly fragmented into smaller pieces.

Sequencing the DNA : The fragmented DNA is then sequenced using a high-throughput sequencing platform.

Data Assembly : Assembly means putting the small fragments back together to form longer sequences (called contigs).

#Computational Methods and Tools in Whole Genome Metagenomics

1. Quality Control (QC)
FastQC: A tool for checking the quality of sequencing data.
Trimmomatic, fastp: These tools help clean the data by removing low-quality sequences and trimming unwanted parts.

2. DNA Assembly
SPAdes or MetaSPAdes: These tools are used to assemble short DNA fragments into longer contigs.
MEGAHIT: A tool that’s efficient for metagenomic assembly.

3. Taxonomic Classification
Kraken2, MetaPhlAn: These tools compare the DNA fragments against large databases to identify the species present in the sample.

4. Functional Annotation
PROKKA: Used to annotate genomes by predicting the genes and their functions.
InterProScan, EggNOG-mapper: These tools help assign functional categories to genes, linking them to metabolic pathways or biological functions (e.g., antibiotic resistance, carbon cycling).

5. Data Visualization and Analysis
QIIME (for 16S rRNA data): For visualizing microbial diversity in metagenomics.
KneadData: For filtering contaminant DNA.
Cytoscape: For visualizing microbial networks and gene interactions.

#How Does targeted Metagenomics Work?

Step 1: Sample Collection : Collect a sample from any environment (e.g., soil, water, human gut).
Step 2: DNA Extraction : Extract DNA from all the microbes in the sample
Step 3: Target Amplification: Use PCR to amplify a specific region (e.g., 16S rRNA).
Step 4: Sequencing the DNA : The fragmented DNA is then sequenced using a high-throughput sequencing platform.
Step 5: Quality Control: Perform data quality checks and filtering with QIIME2 tools.
Step 6: OTU/ASV Assignment: Identify operational taxonomic units or amplicon sequence variants using QIIME2 pipelines.
Step 7: Taxonomic Profiling: Assign taxonomy to microbial communities using databases (e.g., SILVA, Greengenes).
Step 8: Diversity Analysis: Perform alpha and beta diversity analysis with QIIME2 visualizations.
Step 9: Krona Plot: Use tools Krona Excel Template to infer Taxonomic composition.

#Computational Methods and Tools in Whole Genome Metagenomics

1. Quality Control (QC)
FastQC: A tool for checking the quality of sequencing data.
Trimmomatic, fastp: These tools help clean the data by removing low-quality sequences and trimming unwanted parts.

2. Operational Taxonomic Unit (OTU)/ASV Picking:
Use DADA2 or Deblur in QIIME2 to generate OTUs(Oprtaional Taxonomic Unit).

3. Taxonomic Assignment:
Compare OTUs to a reference database (e.g., SILVA, Greengenes) to identify microbial taxa.

4. Diversity Analysis
Alpha Diversity: Measure within-sample diversity (e.g., Shannon Index).
Beta Diversity: Compare diversity between samples (e.g., Bray-Curtis, Jaccard Distance). 




