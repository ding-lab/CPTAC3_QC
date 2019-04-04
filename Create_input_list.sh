#!/bin/bash

grep Y2.b1 /diskmnt/Projects/Users/yize.li/CPTAC/QC/archived/CPTAC3.catalog/CPTAC3.cases.dat | cut -f 1 > inputs/CPTAC3_sample_list

while read sample; do
    grep ${sample} /diskmnt/Projects/Users/yize.li/CPTAC/QC/archived/CPTAC3.catalog/katmai.BamMap.dat >> inputs/CPTAC3_sample_data_list_temp
done <inputs/CPTAC3_sample_list  

sed 's/BAM/bam/g' inputs/CPTAC3_sample_data_list_temp > inputs/CPTAC3_sample_data_list_temp1
sed 's/FASTQ/fastq/g' inputs/CPTAC3_sample_data_list_temp1 > inputs/CPTAC3_sample_data_list_temp2

cut -f 1,2,6,8 inputs/CPTAC3_sample_data_list_temp2 > inputs/CPTAC3_sample_data_list
rm inputs/CPTAC3_sample_data_list_temp*








