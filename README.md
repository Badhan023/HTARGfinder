# HT-ARGfinder
HT-ARGfinder (Horizontally Transferred Antibiotic Resistant Genes finder) a pipeline that detects and enumerates horizontally transferred ARGs in metagenomic data while also estimating the directionality of transfer.

**Requirements**
1. Conda installed
2. ~350GB space for GTDB-tk (https://ecogenomics.github.io/GTDBTk/installing/index.html)

**Installation**

```
git clone https://github.com/Badhan023/HTARGfinder.git
conda create -n htargfinder -c conda-forge -c bioconda gtdbtk=1.3.0
conda activate htargfinder
cd HTARGfinder
./setup.sh
```
The setup.sh will take ~4 hours for GTDB-tk.


**Running HT-ARGfinder**

Activate the conda for this tool, i.e., **htargfinder** in this case, before running the pipeline.
```sh
bash pipeline.sh sample sample_read1.fq sample_read2.fq database   #1 paired-end library in fastq format
```

Here, 
**sample** is the desired prefix of the intermediate and output files,
**sample_read1.fq** and **sample_read2.fq** are the paired-end reads as inputs.
**database** is the ARG database prefix. Currently there are two options for this argument: **CARD**, and **DeepARG**.


**Outputs**

1. sample_HTARGs_database.csv (horizontally transferred ARG-list with donor & recepient information according to the ARG database selected)
2. sample_diamond_out_default_database.csv (ARG matches running DIAMOND against the ARG database selected)
3. sample_taxonomy_DeepARG-DB.csv (taxonomic information of the bins associated with horizontally transferred ARGs according to the ARG database selected)


**Database Options**
User can add another database, for example **newdb.fa** in this pipeline by simple running the following command.
```sh
diamond makedb --in newdb.fa -d reference_newdb
```
When the database is ready to use, user can simply use **newdb** as the fourth argument of pipeline.sh as another option for ARG database. For example,
```sh
bash pipeline.sh sample sample_read1.fq sample_read2.fq newdb
```
