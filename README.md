# CPTAC3 QC pipeline

This pipeline provides the comprehensive QC of CPTAC3 sequence data with mulitple sections.

## Section 1: Basic BAM/FASTQ QC

### Tool: 
FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

### Steps:
 1.Create file list: bash Create_input_list.sh
 This step is to generate a file list with the corresponding sample name and data type which are needed to run the pipeine.

 2.FastQC pipeline: Run_FastQC.sh
 This is the pipeline of calling FastQC.

 3.Call the pipeline: e.g. nohup bash Submit_Run_FastQC.sh 1>logs/work.err 2>logs/work.log &
 This is to call Run_FastQC.sh with reading in the inputs from 1.

### Folder struture:
./inputs: the input files or file lists are saved in the inputs folder. The input data format can be fastq or bam. The user needs to revise the Create_input_list.sh accordingly to generate the file list or save/soft-link the files in this input folder. 

./outputs: the QC results are saved in the outputs folder (subfolder corresponding to each sample). The output is a report in HTML format. The detailed information can be found on the FastQC website.

./temp: the folder to be used for temporary files written when generating report images. Defaults to system temp directory if not specified.

./logs: the logs are saved in the logs folder.
