# HTARGfinder
HTARGfinder (Horizontally Transferred Antibiotic Resistant Genes finder) is a pipeline that detects and investigates horizontally transferred ARGs in metagenomic data.

**Requirements**
1. Conda environment
2. ~350GB space for GTDB-tk (https://ecogenomics.github.io/GTDBTk/installing/index.html)

**Installation**

```
conda create -n htargfinder -c conda-forge -c bioconda gtdbtk=1.3.0
conda activate htargfinder
cd HTARGfinder
./setup.sh
```
The setup.sh will take ~4 hours for GTDB-tk.
**Running HT-ARGfinder**
```sh
bash pipeline.sh sample sample_read1.fq sample_read2.fq   #1 paired-end library in fastq format
```

Here, 
**sample** is the desired prefix of the intermediate and output files,
sample_read1.fq and sample_read2.fq are the paired-end reads as inputs.


**Output**

list of horizontally transferred ARGs with the direction of transfer (donor and recepient)
