#! /bin/bash
echo "SILVA NR132 99 represented seq total#" >> in_silico_PCR.txt
grep ">" silva_132_99_16S.fna -c >> in_silico_PCR.txt

echo "V3V4" >> in_silico_PCR.txt
grep -f v3v4.pattern silva_132_99_16S.fna -c >> in_silico_PCR.txt
grep -f v3v4.pattern silva_132_99_16S.fna -o > v3v4_seq.txt
grep -f v3v4.pattern silva_132_99_16S.fna -B 1 | grep ">" > v3v4_head.txt
awk '{ print length }' v3v4_seq.txt > v3v4_seqLeng.txt

echo "V4O" >> in_silico_PCR.txt
grep -f v4o.pattern silva_132_99_16S.fna -c >> in_silico_PCR.txt
grep -f v4o.pattern silva_132_99_16S.fna -o > v4o_seq.txt
grep -f v4o.pattern silva_132_99_16S.fna -B 1 | grep ">" > v4o_head.txt
awk '{ print length }' v4o_seq.txt > v4o_seqLeng.txt

echo "V4N" >> in_silico_PCR.txt
grep -f v4n.pattern silva_132_99_16S.fna -c >> in_silico_PCR.txt
grep -f v4n.pattern silva_132_99_16S.fna -o > v4n_seq.txt
grep -f v4n.pattern silva_132_99_16S.fna -B 1 | grep ">" > v4n_head.txt
awk '{ print length }' v4n_seq.txt > v4n_seqLeng.txt


Rscript --vanilla mergeseqheads.R v3v4_seq.txt v3v4_head.txt v3v4.fasta
Rscript --vanilla mergeseqheads.R v4o_seq.txt v4o_head.txt v4o.fasta
Rscript --vanilla mergeseqheads.R v4n_seq.txt v4n_head.txt v4n.fasta


echo "tV4O" >> in_silico_PCR.txt
grep -f tv4o.pattern v3v4.fasta -c >> in_silico_PCR.txt
grep -f tv4o.pattern v3v4.fasta -o > tv4o_seq.txt
grep -f tv4o.pattern v3v4.fasta -B 1 | grep ">" > tv4o_head.txt
awk '{ print length }' v4o_seq.txt > tv4o_seqLeng.txt

echo "tV4N" >> in_silico_PCR.txt
grep -f v4n.pattern v3v4.fasta -c >> in_silico_PCR.txt
grep -f v4n.pattern v3v4.fasta -o > tv4n_seq.txt
grep -f v4n.pattern v3v4.fasta -B 1 | grep ">" > tv4n_head.txt
awk '{ print length }' v4n_seq.txt > v4n_seqLeng.txt


Rscript --vanilla mergeseqheads.R tv4o_seq.txt tv4o_head.txt tv4o.fasta
Rscript --vanilla mergeseqheads.R tv4n_seq.txt tv4n_head.txt tv4n.fasta

#mkdir vsearch/silva_v3v4_99
#vsearch --usearch_global v3v4.fasta \
#        --db silva_132_99_16S.fna \
#        --id 0.99 --blast6out vsearch/silva_v3v4_99/silva_v3v4_99.blast6out
#
#mkdir vsearch/silva_v4o_99
#vsearch --usearch_global v4o.fasta \
#        --db silva_132_99_16S.fna \
#        --id 0.99 --blast6out vsearch/silva_v4o_99/silva_v4o_99.blast6out
#
#mkdir vsearch/silva_v4n_99
#vsearch --usearch_global v4n.fasta \
#        --db silva_132_99_16S.fna \
#        --id 0.99 --blast6out vsearch/silva_v4n_99/silva_v4n_99.blast6out

mkdir vsearch/silva_v4ose_99
vsearch --usearch_global v4ose.fasta \
        --db silva_132_99_16S.fna \
        --id 0.99 --blast6out vsearch/silva_v4ose_99/silva_v4ose_99.blast6out

mkdir vsearch/silva_v4nse_99
vsearch --usearch_global v4nse.fasta \
        --db silva_132_99_16S.fna \
        --id 0.99 --blast6out vsearch/silva_v4nse_99/silva_v4nse_99.blast6out


#vsearch --usearch_global /tmp/qiime2-archive-pnhjjfcm/4c3402a6-c2e8-4382-ae84-e920b574ca6e/data/dna-sequences.fasta \
#        --id 0.8 --query_cov 0.8 --strand both --maxaccepts 1 --maxrejects 0 --output_no_hits \
#        --db /tmp/qiime2-archive-wl3ao2w4/a7b75640-5c85-4e6f-a3b9-8a626d1c51f3/data/dna-sequences.fasta \
#        --threads 12 --blast6out /tmp/tmp4l5cx8_k