### Description of input argument:
## Required argument
# path_input: the pathway of the CNV files to be read in the pipeline (in any format set by the user), clinical file and sample type file
# path_output: the pathway of saving QC report and figures
# input_format: the format of CNV files (e.g. .cnv, .CNV); the CNV files should at least include columns Sample, Chromosome, Start, End, Segment_Mean

## Optional argument
# mean_l_bound: the lower bound of reasonable segment means (should not be less than 0; (0, 1) is suggested, e.g. 0.5 by default)
# mean_u_bound: the upper bound of reasonable segment means (should be larger than 1, e.g. 1.5 by default)
# good_cutoff: the lower cutoff set to compare with the proportion of outliers (segment mean values being outside the range of lower and upper bound, e.g. 0.1 by default)
# bad_cutoff: the upper cutoff set to compare with the proportion of outliers (segment mean values being outside the range of lower and upper bound, e.g. 0.3 by default)
# clinic_file: the name of the clinical file (providing the info of sex; need to have columns named Sample, Sex)
# sample_type_file: the sample type list (providing the info of donor identifier and the corresponding tumor and normal identifiers)
# Y_cutoff: the cutoff used to check the consistency of mean value of Y chromsome with the clinical data (sex), male should be higher than female (0.5 by default)

## All arguments should be defined here by the users.
# path_input, input_format, path_output are required arguments for the basic functions (if mean_l_bound, mean_u_bound, good_cutoff, bad_cutoff not provided, set default)
# clinic_file, sample_type_file Y_cutoff are optional arguments for additional functions (if Y_cutoff not provided, set default)

####################################################################################
# Section that needs to be set by the user (example shown as below)
## Required arguments (basic functions)
path_input <- "inputs/"
path_output <- "outputs/"
input_format <- "cnv"

## Optional arguments
## Comment out if not needed (basic functions with given customized argument values)
mean_l_bound <- 0.5  # default 0.5
mean_u_bound <- 1.5 # default 1.5
good_cutoff <- 0.1 # default 0.1
bad_cutoff <- 0.3 # default 0.3

## Comment out if not needed (full functions)
clinic_file <- "Sex.csv" # needed for sex-chrY consistency checking
sample_type_file <- "Sample.csv" # needed for tumor-normal swap checking
Y_cutoff <- 0.5 # default 0.5
####################################################################################

args <- c("path_input", "path_output", "input_format", "mean_l_bound", "mean_u_bound", "good_cutoff", "bad_cutoff", "clinic_file", "sample_type_file", "Y_cutoff")
args_count = 0

for (i in 1:length(args)) {
  if (exists(args[i])) {
    args_count <- args_count + 1
  } else {
  }
}

print(args_count)
