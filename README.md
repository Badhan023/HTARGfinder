# HT-ARGfinder
HT-ARGfinder (Horizontally Transferred Antibiotic Resistant Genes finder) a pipeline that detects and enumerates horizontally transferred ARGs in metagenomic data while also estimating the directionality of transfer.

**Requirements**
1. Conda installed
2. ~350GB space for GTDB-tk (https://ecogenomics.github.io/GTDBTk/installing/index.html)

**Installation**

```
conda create -n htargfinder -c conda-forge -c bioconda gtdbtk=1.3.0
conda activate htargfinder
git clone https://github.com/Badhan023/HTARGfinder.git
cd HTARGfinder
./setup.sh
```
The setup.sh will take ~4 hours for GTDB-tk.


**Running HT-ARGfinder**

Activate the conda for this tool, i.e., **htargfinder** in this case, before running the pipeline.
```sh
bash pipeline.sh sample sample_read1.fq sample_read2.fq   #1 paired-end library in fastq format
```

Here, 
**sample** is the desired prefix of the intermediate and output files,
sample_read1.fq and sample_read2.fq are the paired-end reads as inputs.


**Outputs**

1. sample_HTARGs_DeepARG-DB.csv (horizontally transferred ARG-list with donor & recepient information according to DeepARG-DB)
2. sample_HTARGs_CARD.csv (horizontally transferred ARG-list with donor & recepient information according to CARD)

