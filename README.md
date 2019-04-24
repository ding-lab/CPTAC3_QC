# CPTAC3 QC master pipeline

This pipeline provides the comprehensive QC of CPTAC3 sequence data with multiple sections.

## Section 1: Basic BAM/FASTQ QC

### Tool: 
FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

### Steps:
 1.Create file list: bash Create_input_list.sh
 This step is to generate a file list with the corresponding sample name and data type which are needed to run the pipeline.

 2.FastQC pipeline: Run_FastQC.sh
 This is the pipeline of calling FastQC.

 3.Call the pipeline: e.g. nohup bash Submit_Run_FastQC.sh 1>logs/work.err 2>logs/work.log &
 This is to call Run_FastQC.sh with reading in the inputs from 1.

### Folder structure:
./inputs: the input files or file lists are saved in the inputs folder. The input data format can be fastq or bam. The user needs to revise the Create_input_list.sh accordingly to generate the file list or save/soft-link the files in this input folder. 

./outputs: the QC results are saved in the outputs folder (subfolder corresponding to each sample). The output is a report in HTML format. The detailed information can be found on the FastQC website.

./temp: the folder to be used for temporary files written when generating report images. Defaults to system temp directory if not specified.

./logs: the logs are saved in the logs folder.

## Section 2: WXS CNV QC
Description of major functions in this section:
1. Check the missing chromosome in each sample
2. Check the coverage (number of regions/segments) of each chromosome in each sample
3. Calculate the bp-weighted mean values of all means in each chromosome of each sample
4. Check the range of mean and proportion of outliers to determine the quality of data
5. Check the consistency of bp-weighte mean value in Y chromsome with the clinical data
6. Collect the donor identifiers and corresponding paired sample identifiers
7. Check if tumor & normal pairs are swapped or not (3 criteria: Proportion of outliers, segment mean variation, segment mean - 1)
8. Find the cutoff to get the highest accuracy of Sex (ROC)
9. Output a QC report in the csv format
10. Generate the histogram of P_outliers to show the distribution and set the cutoffs
11. Generate the histogram of Y_mean to show the distribution and set the cutoffs
12. Generate the histogram of X_mean to show the distribution and set the cutoffs

### Tool:
R scripts which requires packages ggplot2 etc.

### Steps:
 1.Get the CNV calls
 Run GATK4 to get the WXS CNV outputs as the input of this section (which is not a part of the QC pipeline).

 2.Define inputs: WXS_CNV_QC_input.R
 Required arguments:
 path_input: the pathway of the CNV files to be read in the pipeline (in any format set by the user), clinical file and sample type file
 path_output: the pathway of saving QC report and figures
 input_format: the format of CNV files (e.g. .cnv, .CNV); the CNV files should at least include columns Sample, Chromosome, Start, End, Segment_Mean

 Optional arguments:
 mean_l_bound: the lower bound of reasonable segment means (should not be less than 0; (0, 1) is suggested, e.g. 0.5 by default)
 mean_u_bound: the upper bound of reasonable segment means (should be larger than 1, e.g. 1.5 by default)
 good_cutoff: the lower cutoff set to compare with the proportion of outliers (segment mean values being outside the range of lower and upper bound, e.g. 0.1 by default)
 bad_cutoff: the upper cutoff set to compare with the proportion of outliers (segment mean values being outside the range of lower and upper bound, e.g. 0.3 by default)
 clinic_file: the name of the clinical file (providing the info of sex; need to have columns named Sample, Sex)
 sample_type_file: the sample type list (providing the info of donor identifier and the corresponding tumor and normal identifiers)
 Y_cutoff: the cutoff used to check the consistency of mean value of Y chromsome with the clinical data (sex), male should be higher than female (0.5 by default)

 3.Call the pipeline: e.g. Rscript WXS_CNV_QC_pipeline_v10.R > ./logs/work.log &
 The pipeline will apply the QC functions based on the arguments provided.

### Folder structure:
./inputs: the input files or file lists are saved in the inputs folder. The input data format from GATK4 is .cnv.

./outputs: the QC results are saved in the outputs folder (subfolder corresponding to each sample). The outputs include a comprehensive QC summary table and multiple figures for visualization.

./logs: the logs are saved in the logs folder.
