##Tool Installation
sudo apt-get install fastqc

sudo apt-get install fastp


#Tutorial Link

https://docs.qiime2.org/2024.2/tutorials/
##Installation

#data downloading
#SRR17487861
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/061/SRR17487861/SRR17487861_1.fastq.gz
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/061/SRR17487861/SRR17487861_2.fastq.gz
#SRR17487862
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/062/SRR17487862/SRR17487862_1.fastq.gz
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/062/SRR17487862/SRR17487862_2.fastq.gz
#SRR17487928
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/028/SRR17487928/SRR17487928_1.fastq.gz
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/028/SRR17487928/SRR17487928_2.fastq.gz
#SSRR17488023
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/023/SRR17488023/SRR17488023_1.fastq.gz
wget -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR174/023/SRR17488023/SRR17488023_2.fastq.gz

gunzip *.gz

##Quality control using fastqc

sudo apt-get install fastqc

fastqc *.fastq

#There are three main imp parameters to decide the quality
#1. Per base sequence quality
#2. Overrepresented sequnece
#3. Adapter content

#Trimming(fastp/cutadapt/trimmomatic)

sudo apt-get install fastp

fastp -i SRR17487861_1.fastq -o Trim_SRR17487861_1.fastq -I SRR17487861_2.fastq -O Trim_SRR17487861_2.fastq -5 -3 -q 30 --adapter_fasta adapter_1.fasta




##Dwonload the metadata file
#activate conda and qiime
source $HOME/miniconda3/bin/activate
conda activate qiime

#https://docs.qiime2.org/2022.2/tutorials/importing/#per-feature-unaligned-sequence-data-i-e-representative-fasta-sequences

## To run qiime2 each new terminal first you have to activate conda

conda activate qiime2

##1. Importing the data

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path metadata.txt --output-path paired-end-demux.qza --input-format PairedEndFastqManifestPhred33V2

##to generate a summary of the imported Data

qiime demux summarize --i-data paired-end-demux.qza --o-visualization demux.qzv

##to view sample file with Qiime tool

qiime tools view demux.qzv

##2. Sequence quality control and feature table construction

qiime dada2 denoise-single --i-demultiplexed-seqs paired-end-demux.qza --p-trim-left 0 --p-trunc-len 0 --o-representative-sequences rep-seqs-dada2.qza --o-table table-dada2.qza --o-denoising-stats stats-dada2.qza

##To check number of sequences from each sample that passed filtering

qiime metadata tabulate --m-input-file stats-dada2.qza --o-visualization stats-dada2.qzv

##Rename the files to a common name:
mv rep-seqs-dada2.qza rep-seqs.qza

mv table-dada2.qza table.qza

##create visual summaries of the FeatureTable and FeatureData .

qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file metadata.txt

qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv

qiime tools view rep-seqs.qzv

##3. Generate a tree for Phylogenetic diversity analyses

qiime phylogeny align-to-tree-mafft-fasttree --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza

##Alpha and Beta diversity Analysis
#to choose sampling depth

qiime diversity core-metrics-phylogenetic --i-phylogeny rooted-tree.qza --i-table table.qza --p-sampling-depth 29000 --m-metadata-file metadata.txt --output-dir core-metrics-results

qiime tools view core-metrics-results1/unweighted_unifrac_emperor.qzv

##Alpha rarefaction Plotting

qiime diversity alpha-rarefaction --i-table table.qza --i-phylogeny rooted-tree.qza --p-max-depth 100000 --m-metadata-file metadata.txt --o-visualization alpha-rarefaction.qzv

qiime tools view alpha-rarefaction.qzv

##link for classifier
https://docs.qiime2.org/2022.2/tutorials/feature-classifier/

##To download Greengenes 13_8 99% OTUs classifier
wget -c https://docs.qiime2.org/2022.2/data/tutorials/feature-classifier/ref-seqs.qza
wget -c https://docs.qiime2.org/2022.2/data/tutorials/feature-classifier/ref-taxonomy.qza

#wget -c https://data.qiime2.org/2021.4/common/gg-13-8-99-515-806-nb-classifier.qza

##to create classifier file

qiime feature-classifier fit-classifier-naive-bayes --i-reference-reads ref-seqs.qza --i-reference-taxonomy ref-taxonomy.qza --o-classifier classifier.qza

##taxonomy analysis

qiime feature-classifier classify-sklearn --i-classifier classifier.qza --i-reads rep-seqs.qza --o-classification taxonomy.qza


qiime metadata tabulate --m-input-file taxonomy.qza --o-visualization taxonomy.qzv

qiime tools view taxonomy.qzv

##view the taxonomic composition of our samples with interactive bar plots.

qiime taxa barplot --i-table table.qza --i-taxonomy taxonomy.qza --m-metadata-file metadata.txt --o-visualization taxa-bar-plots.qzv


qiime tools view taxa-bar-plots.qzv

## Krona plot
wget -c https://github.com/marbl/Krona/releases/download/xl2.5/Krona.xltm.zip




##Phylogenetic analysis






