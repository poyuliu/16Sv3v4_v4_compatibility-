```mkdir reads_qza```

## for V3-V4 PE  
```
qiime tools import --type SampleData[PairedEndSequencesWithQuality] \
                   --input-path /nas2/poyuliu/16S_NextSeqPrimer/V3V4_VS_V4_Project/V3V4/ \
                   --output-path reads_qza/reads_import_V3V4.qza \
                   --input-format CasavaOneEightSingleLanePerSampleDirFmt
```                   
### Trim amplicon primers  
```
qiime cutadapt trim-paired --i-demultiplexed-sequences reads_qza/reads_import_V3V4.qza \
                            --p-cores 16 \
                            --p-front-f CCTACGGGNGGCWGCAG \
                            --p-front-r GACTACHVGGGTATCTAATCC  \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V3V4_PE.qza \
                            --verbose \
                            &> primer_trimming_V3V4.log 
```

### Running DADA2  
```
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V3V4_PE.qza \
                           --p-trunc-len-f 270 \
                           --p-trunc-len-r 210 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V3V4
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V3V4_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V3V4/table.qza --o-visualization qiime2_outputs/dada2_output_V3V4_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V3V4_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4/table.qza --output-path qiime2_outputs/dada2_output_V3V4_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V3V4_exported
biom convert -i qiime2_outputs/dada2_output_V3V4_exported/feature-table.biom -o qiime2_outputs/dada2_output_V3V4_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V3V4_exported/feature-table.txt ./ASV_tables/dada2_V3V4_asv.txt
```

## for V4O PE  
*F 5'-3':GTGYCAGCMGCCGCGGTAA*  
*R 5'-3':GGACTACHNGGGTWTCTAAT*  
```
qiime tools import --type SampleData[PairedEndSequencesWithQuality] \
                   --input-path /nas2/poyuliu/16S_NextSeqPrimer/V3V4_VS_V4_Project/V4O/ \
                   --output-path reads_qza/reads_import_V4O.qza \
                   --input-format CasavaOneEightSingleLanePerSampleDirFmt
```
```
qiime cutadapt trim-paired --i-demultiplexed-sequences reads_qza/reads_import_V4O.qza \
                            --p-cores 16 \
                            --p-front-f GTGYCAGCMGCCGCGGTAA \
                            --p-front-r GGACTACHNGGGTWTCTAAT  \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V4O_PE.qza \
                            --verbose \
                            &> primer_trimming_V4O.log 
```
```
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V4O_PE.qza \
                           --p-trunc-len-f 131 \
                           --p-trunc-len-r 130 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V4O
```
**trunc to 141/140: perfect matching in MiSeq simulation, see archive folder => use for profiling**
**trunc to 131/130: real condition in NextSeq sequencing, but poor matching, poor merging by DADA2 => use for claiming failure of NextSeq 150PE** 

```
qiime tools export --input-path qiime2_outputs/dada2_output_V4O/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V4O_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V4O/table.qza --o-visualization qiime2_outputs/dada2_output_V4O_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V4O_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V4O_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4O/table.qza --output-path qiime2_outputs/dada2_output_V4O_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V4O/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V4O_exported
biom convert -i qiime2_outputs/dada2_output_V4O_exported/feature-table.biom -o qiime2_outputs/dada2_output_V4O_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V4O_exported/feature-table.txt ./ASV_tables/dada2_V4O_asv.txt
```

## for V4N PE  
*F 5'-3':CAGCMGCCGCGGTAAT*  
*R 5'-3':GGGTWTCTAATCCKGTT*  
```
qiime tools import --type SampleData[PairedEndSequencesWithQuality] \
                   --input-path /nas2/poyuliu/16S_NextSeqPrimer/V3V4_VS_V4_Project/V4N/ \
                   --output-path reads_qza/reads_import_V4N.qza \
                   --input-format CasavaOneEightSingleLanePerSampleDirFmt
```
```
qiime cutadapt trim-paired --i-demultiplexed-sequences reads_qza/reads_import_V4N.qza \
                            --p-cores 16 \
                            --p-front-f CAGCMGCCGCGGTAAT \
                            --p-front-r GGGTWTCTAATCCKGTT  \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V4N_PE.qza \
                            --verbose \
                            &> primer_trimming_V4N.log 
```
```
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V4N_PE.qza \
                           --p-trunc-len-f 134 \
                           --p-trunc-len-r 133 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V4N
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4N/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V4N_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V4N/table.qza --o-visualization qiime2_outputs/dada2_output_V4N_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V4N_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V4N_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4N/table.qza --output-path qiime2_outputs/dada2_output_V4N_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V4N/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V4N_exported
biom convert -i qiime2_outputs/dada2_output_V4N_exported/feature-table.biom -o qiime2_outputs/dada2_output_V4N_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V4N_exported/feature-table.txt ./ASV_tables/dada2_V4N_asv.txt
```

# V3-V4 PE trim to V4
## for V3-V4 PE trim to V4O PE  
```
qiime cutadapt trim-paired --i-demultiplexed-sequences reads_qza/reads_import_V3V4.qza \
                            --p-cores 16 \
                            --p-front-f GTGYCAGCMGCCGCGGTAA \
                            --p-front-r GACTACHNGGGTWTCTAAT  \
                            --p-discard-untrimmed \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V3V4toV4O_PE.qza \
                            --verbose \
                            &> primer_trimming_V3V4toV4O.log 
```
```
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V3V4toV4O_PE.qza \
                           --p-trunc-len-f 75 \
                           --p-trunc-len-r 210 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V3V4toV4O
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4O/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V3V4toV4O_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V3V4toV4O/table.qza --o-visualization qiime2_outputs/dada2_output_V3V4toV4O_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4O_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V3V4toV4O_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4O/table.qza --output-path qiime2_outputs/dada2_output_V3V4toV4O_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4O/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V3V4toV4O_exported
biom convert -i qiime2_outputs/dada2_output_V3V4toV4O_exported/feature-table.biom -o qiime2_outputs/dada2_output_V3V4toV4O_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V3V4toV4O_exported/feature-table.txt ./ASV_tables/dada2_V3V4toV4O_asv.txt
```


## for V3-V4 PE trim to V4N PE  
```
qiime cutadapt trim-paired --i-demultiplexed-sequences reads_qza/reads_import_V3V4.qza \
                            --p-cores 16 \
                            --p-front-f CAGCMGCCGCGGTAAT \
                            --p-front-r GACTACHVGGGTWTCTAATCCKGTT  \
                            --p-discard-untrimmed \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V3V4toV4N_PE.qza \
                            --verbose \
                            &> primer_trimming_V3V4toV4N.log 
```
```
qiime dada2 denoise-paired --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V3V4toV4N_PE.qza \
                           --p-trunc-len-f 75 \
                           --p-trunc-len-r 210 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V3V4toV4N
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4N/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V3V4toV4N_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V3V4toV4N/table.qza --o-visualization qiime2_outputs/dada2_output_V3V4toV4N_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4N_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V3V4toV4N_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4N/table.qza --output-path qiime2_outputs/dada2_output_V3V4toV4N_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V3V4toV4N/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V3V4toV4N_exported
biom convert -i qiime2_outputs/dada2_output_V3V4toV4N_exported/feature-table.biom -o qiime2_outputs/dada2_output_V3V4toV4N_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V3V4toV4N_exported/feature-table.txt ./ASV_tables/dada2_V3V4toV4N_asv.txt
```

# V4 SE  
```
mkdir ../V3V4_VS_V4_Project/V4O/R1
mv ../V3V4_VS_V4_Project/V4O/*R1_001.fastq.gz ../V3V4_VS_V4_Project/V4O/R1
mkdir ../V3V4_VS_V4_Project/V4N/R1
mv ../V3V4_VS_V4_Project/V4N/*R1_001.fastq.gz ../V3V4_VS_V4_Project/V4N/R1
```
## for V4O SE  
```
qiime tools import --type 'SampleData[SequencesWithQuality]' \
                   --input-path /nas2/poyuliu/16S_NextSeqPrimer/V3V4_VS_V4_Project/V4O/R1 \
                   --output-path reads_qza/reads_import_V4O_SE.qza \
                   --input-format CasavaOneEightSingleLanePerSampleDirFmt
```
```
mv ../V3V4_VS_V4_Project/V4O/R1/* ../V3V4_VS_V4_Project/V4O/
rm -r ../V3V4_VS_V4_Project/V4O/R1                   
```
```
qiime cutadapt trim-single --i-demultiplexed-sequences reads_qza/reads_import_V4O_SE.qza \
                            --p-cores 16 \
                            --p-anywhere GTGYCAGCMGCCGCGGTAA \
                            --p-discard-untrimmed \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V4O_SE.qza \
                            --verbose \
                            &> primer_trimming_V4OSE.log 
```
```
qiime dada2 denoise-single --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V4O_SE.qza \
                           --p-trunc-len 131 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V4OSE
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4OSE/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V4OSE_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V4OSE/table.qza --o-visualization qiime2_outputs/dada2_output_V4OSE_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V4OSE_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V4OSE_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4OSE/table.qza --output-path qiime2_outputs/dada2_output_V4OSE_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V4OSE/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V4OSE_exported
biom convert -i qiime2_outputs/dada2_output_V4OSE_exported/feature-table.biom -o qiime2_outputs/dada2_output_V4OSE_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V4OSE_exported/feature-table.txt ./ASV_tables/dada2_V4OSE_asv.txt
```

## for V4N SE  
```
qiime tools import --type 'SampleData[SequencesWithQuality]' \
                   --input-path /nas2/poyuliu/16S_NextSeqPrimer/V3V4_VS_V4_Project/V4N/R1 \
                   --output-path reads_qza/reads_import_V4N_SE.qza \
                   --input-format CasavaOneEightSingleLanePerSampleDirFmt
```
```
mv ../V3V4_VS_V4_Project/V4N/R1/* ../V3V4_VS_V4_Project/V4N/
rm -r ../V3V4_VS_V4_Project/V4N/R1
```
```
qiime cutadapt trim-single --i-demultiplexed-sequences reads_qza/reads_import_V4N_SE.qza \
                            --p-cores 16 \
                            --p-anywhere CAGCMGCCGCGGTAAT \
                            --p-discard-untrimmed \
                            --o-trimmed-sequences trimmed_qza/primer-trimmed_V4N_SE.qza \
                            --verbose \
                            &> primer_trimming_V4NSE.log 
```
```
qiime dada2 denoise-single --i-demultiplexed-seqs trimmed_qza/primer-trimmed_V4N_SE.qza \
                           --p-trunc-len 134 \
                           --p-n-threads 16 \
                           --output-dir qiime2_outputs/dada2_output_V4NSE
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4NSE/denoising_stats.qza --output-path qiime2_outputs/dada2_output_V4NSE_stats
qiime feature-table summarize --i-table qiime2_outputs/dada2_output_V4NSE/table.qza --o-visualization qiime2_outputs/dada2_output_V4NSE_stats/table_summary.qzv
qiime tools export --input-path qiime2_outputs/dada2_output_V4NSE_stats/table_summary.qzv --output-path qiime2_outputs/dada2_output_V4NSE_stats/table_summary
```
```
qiime tools export --input-path qiime2_outputs/dada2_output_V4NSE/table.qza --output-path qiime2_outputs/dada2_output_V4NSE_exported
qiime tools export --input-path qiime2_outputs/dada2_output_V4NSE/representative_sequences.qza --output-path qiime2_outputs/dada2_output_V4NSE_exported
biom convert -i qiime2_outputs/dada2_output_V4NSE_exported/feature-table.biom -o qiime2_outputs/dada2_output_V4NSE_exported/feature-table.txt --to-tsv
cp qiime2_outputs/dada2_output_V4NSE_exported/feature-table.txt ./ASV_tables/dada2_V4NSE_asv.txt
```

## Output representative sequences
```
cp qiime2_outputs/dada2_output_V3V4/representative_sequences.qza        representative_sequences/V3V4.qza
cp qiime2_outputs/dada2_output_V3V4toV4N/representative_sequences.qza   representative_sequences/V3V4toV4N.qza
cp qiime2_outputs/dada2_output_V3V4toV4O/representative_sequences.qza   representative_sequences/V3V4toV4O.qza
cp qiime2_outputs/dada2_output_V4N/representative_sequences.qza         representative_sequences/V4N.qza
cp qiime2_outputs/dada2_output_V4NSE/representative_sequences.qza       representative_sequences/V4NSE.qza
cp qiime2_outputs/dada2_output_V4O/representative_sequences.qza         representative_sequences/V4O.qza
cp qiime2_outputs/dada2_output_V4OSE/representative_sequences.qza       representative_sequences/V4OSE.qza
cp qiime2_outputs/archive/dada2_output_V4O_F141R140/representative_sequences.qza       representative_sequences/V4O_F141R140.qza
```

## Assign taxonomy
```
qiime feature-classifier classify-sklearn --i-reads representative_sequences/V3V4.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V3V4
qiime tools export --input-path Taxonomy/V3V4/classification.qza --output-path Taxonomy/V3V4
time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V3V4toV4N.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V3V4toV4N
qiime tools export --input-path Taxonomy/V3V4toV4N/classification.qza --output-path Taxonomy/V3V4toV4N
time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V3V4toV4O.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V3V4toV4O
qiime tools export --input-path Taxonomy/V3V4toV4O/classification.qza --output-path Taxonomy/V3V4toV4O
time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V4N.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V4N
qiime tools export --input-path Taxonomy/V4N/classification.qza --output-path Taxonomy/V4N
time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V4NSE.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V4NSE
qiime tools export --input-path Taxonomy/V4NSE/classification.qza --output-path Taxonomy/V4NSE
time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V4O.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V4O
qiime tools export --input-path Taxonomy/V4O/classification.qza --output-path Taxonomy/V4O
time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V4OSE.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V4OSE
qiime tools export --input-path Taxonomy/V4OSE/classification.qza --output-path Taxonomy/V4OSE

time qiime feature-classifier classify-sklearn --i-reads representative_sequences/V4O_F141R140.qza --i-classifier ~/metagenome_tool/QIIME2_taxa_classifiers/silva-132-99-nb-classifier.qza --p-n-jobs 12 \
                                          --output-dir Taxonomy/V4O_F141R140
qiime tools export --input-path Taxonomy/V4O_F141R140/classification.qza --output-path Taxonomy/V4O_F141R140
```

