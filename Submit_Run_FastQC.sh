#!/bin/bash

while read sample caseID data_file data_type; do
    bash Run_FastQC.sh -i ${data_file} -o outputs/${sample} -f ${data_type} -t 6 -d /diskmnt/Projects/CPTAC3_QC/temp
done <inputs/CPTAC3_sample_data_list
