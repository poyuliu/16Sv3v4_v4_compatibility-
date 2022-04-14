#! /bin/bash
# in QIIME2
# v3v4.fasta  v4n.fasta  v4nse.fasta  v4o.fasta  v4ose.fasta

qiime tools import --input-path v3v4.fasta --output-path Q2classification/v3v4.qza --type 'FeatureData[Sequence]'
qiime tools import --input-path v4o.fasta --output-path Q2classification/v4o.qza --type 'FeatureData[Sequence]'
qiime tools import --input-path v4n.fasta --output-path Q2classification/v4n.qza --type 'FeatureData[Sequence]'
qiime tools import --input-path v4ose.fasta --output-path Q2classification/v4ose.qza --type 'FeatureData[Sequence]'
qiime tools import --input-path v4nse.fasta --output-path Q2classification/v4nse.qza --type 'FeatureData[Sequence]'


#qiime feature-classifier classify-sklearn --i-reads Q2classification/v3v4.qza \
#                                          --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza \
#                                          --p-n-jobs 4 \
#                                          --output-dir Q2classification/v3v4 
#qiime feature-classifier classify-sklearn --i-reads Q2classification/v4o.qza \
#                                          --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza \
#                                          --p-n-jobs 12 \
#                                          --output-dir Q2classification/v4o 
#qiime feature-classifier classify-sklearn --i-reads Q2classification/v4n.qza \
#                                          --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza \
#                                          --p-n-jobs 12 \
#                                          --output-dir Q2classification/v4n 
#qiime feature-classifier classify-sklearn --i-reads Q2classification/v4ose.qza \
#                                          --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza \
#                                          --p-n-jobs 12 \
#                                          --output-dir Q2classification/v4ose 
#qiime feature-classifier classify-sklearn --i-reads Q2classification/v4nse.qza \
#                                          --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza \
#                                          --p-n-jobs 12 \
#                                          --output-dir Q2classification/v4nse 
#
#
#qiime tools export --input-path Q2classification/v3v4/classification.qza --output-path Q2classification/v3v4
#qiime tools export --input-path Q2classification/v4o/classification.qza --output-path Q2classification/v4o
#qiime tools export --input-path Q2classification/v4n/classification.qza --output-path Q2classification/v4n
#qiime tools export --input-path Q2classification/v4ose/classification.qza --output-path Q2classification/v4ose
#qiime tools export --input-path Q2classification/v4nse/classification.qza --output-path Q2classification/v4nse

# using VSEARCH TO ASSIGN TAXONOMY

qiime tools import \
 --type 'FeatureData[Sequence]' \
 --input-path silva_132_99_16S.fna \
 --output-path Q2classification/Classifiers/Silva99_16SRepSeq.qza 

sed -i -- 's/;/; /g' taxonomy_7_levels_sep.txt

qiime tools import \
 --type 'FeatureData[Taxonomy]' \
 --input-path taxonomy_7_levels_sep.txt \
 --input-format HeaderlessTSVTaxonomyFormat \
 --output-path Q2classification/Classifiers/Silva99_16STaxonomy.qza
 
qiime feature-classifier classify-consensus-vsearch \
    --i-query Q2classification/v3v4.qza \
    --i-reference-reads Q2classification/Classifiers/Silva99_16SRepSeq.qza \
    --i-reference-taxonomy Q2classification/Classifiers/Silva99_16STaxonomy.qza \
    --p-threads 12 --p-strand 'plus'  --p-maxaccepts 1  --p-perc-identity 0.99 \
    --verbose \
    --output-dir Q2classification/v3v4
    
    
qiime feature-classifier classify-consensus-vsearch \
    --i-query Q2classification/v4ose.qza \
    --i-reference-reads Q2classification/Classifiers/Silva99_16SRepSeq.qza \
    --i-reference-taxonomy Q2classification/Classifiers/Silva99_16STaxonomy.qza \
    --p-threads 12 --p-maxaccepts 1  --p-perc-identity 0.8 \
    --verbose \
    --output-dir Q2classification/v4ose
qiime tools export --input-path Q2classification/v4ose/classification.qza --output-path Q2classification/v4ose