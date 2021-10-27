mkdir SEPP
cd SEEP

##### run SEPP #####
qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V3V4/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V3V4

qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V3V4toV4N/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V3V4toV4N

qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V3V4toV4O/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V3V4toV4O

qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V4N/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V4N

qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V4NSE/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V4NSE

qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V4O/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V4O

qiime fragment-insertion sepp \
  --i-representative-sequences ../dada2_output_V4OSE/representative_sequences.qza \
  --i-reference-database /home/share/sepp-refs-gg-13-8.qza \
  --p-threads 8 \
  --output-dir sepp_output_V4OSE

##### run SEPP filter-features #####
qiime fragment-insertion filter-features \
  --i-table ../dada2_output_V3V4/table.qza \
  --i-tree sepp_output_V3V4/tree.qza \
  --o-filtered-table sepp_output_V3V4/filtered_table.qza \
  --o-removed-table sepp_output_V3V4/removed_table.qza
qiime tools export --input-path sepp_output_V3V4/filtered_table.qza --output-path sepp_output_V3V4
biom convert -i sepp_output_V3V4/feature-table.biom -o sepp_output_V3V4/feature-table.txt --to-tsv
