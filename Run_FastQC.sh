#/bin/bash

# Tool installation using conda
# conda create --name py3.6 python=3.6 # Comment out if already installed
# conda install -c bioconda fastqc # Comment out if already installed
# conda install -c bioconda multiqc # Comment out if already installed

# Run FastQC
# FastQC can be run in one of two modes. It can either run as a stand alone interactive application for the immediate analysis of small numbers of FastQ files, or it can be run in a non-interactive mode where it would be suitable for integrating into a larger analysis pipeline for the systematic processing of large numbers of files.
# FastQC supports files in the following formats
## FastQ (all quality encoding variants)
## Casava FastQ files*
## Colorspace FastQ
## GZip compressed FastQ
## SAM
## BAM
## SAM/BAM Mapped only (normally used for colorspace data)

# Usage: CPTAC_QC.sh [options] -i input_file (fastq|bam|sam)
# Options [ defaults ]:
# -i : input file (required)
# -o : Output directory [Create all output files in the specified output directory. Please note that this directory must exist as the program will not create it. If this option is not set then the output file for each sequence file is created in the same directory as the sequence file which was processed.]
#      Recommend create sub-directory with sampleID if running multiple samples
# -f : input file format (bypasses the normal sequence file format detection and forces the program to use the specified format with valid formats of bam,sam,bam_mapped,sam_mapped and fastq) 
# -t : threads (Specifies the number of files which can be processed simultaneously. Each thread will be allocated 250MB of memory so you shouldn't run more threads than your available memory will cope with, and not more than 6 threads on a 32 bit machine)
# -d : Selects a directory to be used for temporary files written when generating report images. Defaults to system temp directory if not specified.

# Load the conda environment
if [ -z "$CONDA_DEFAULT_ENV" ]; then
    # source /opt/conda/bin/activate py3.6
    source activate py3.6
fi

# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":i:o:f:t:d:" opt; do
  case $opt in
    i) # value argument
      INFILE=$OPTARG
      >&2 echo "Input file: $INFILE "
      ;;
    o) # value argument
      OUTD=$OPTARG
      >&2 echo "Output directory: $OUTD "
      ;;
    f) # value argument
      INTFORMAT=$OPTARG
      >&2 echo "Input file format: $INTFORMAT "
      ;;
    t) # value argument
      NTHREAD=$OPTARG
      >&2 echo "Number of threads: $NTHREAD "
      ;;
    d) # value argument
      TEMP=$OPTARG
      >&2 echo "Directory used for temporary files: $TEMP "
      ;;
    \?)
      >&2 echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      >&2 echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done

#shift $((OPTIND-1))

#if [ "$#" -ne 3 ]; then
#    >&2 echo Error: Wrong number of arguments
#    exit 1
#fi

# Run FastQC (the job is submitted to Katmai/Denali)
if [ ! -d "$OUTD" ]; then
    mkdir $OUTD # Need to create the output folder before running FastQC (such as ./outputs/C3L-00104/)
fi

fastqc -o $OUTD -t $NTHREAD -f $INTFORMAT --extract -d $TEMP $INFILE

rc=$? # catch errors
if [[ $rc != 0 ]]; then
    >&2 echo Fatal error $rc: $!.  Exiting.
    exit $rc;
else
    >&2 echo FastQC run success.
fi

source deactivate

