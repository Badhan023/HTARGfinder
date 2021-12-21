# HTARGfinder
HTARGfinder (Horizontally Transferred Antibiotic Resistant Genes finder) is a pipeline that detects and investigates horizontally transferred ARGs in metagenomic data.

**Conda Environment, Necessary Tools and Packages**
1. Conda environment from GTDB-Tk installation (https://ecogenomics.github.io/GTDBTk/installing/index.html)
2. fastp (https://github.com/OpenGene/fastp)
3. Megahit (https://github.com/voutcn/megahit)
4. BWA (https://github.com/lh3/bwa)
5. samtools (https://anaconda.org/bioconda/samtools)
6. Openssl (https://anaconda.org/anaconda/openssl)
7. CMake (https://cmake.org/install/)
8. MetaBAT2 (https://bitbucket.org/berkeleylab/metabat/src/master/)
9. numpy
10. matplotlib
11. pysam
12. hmmer
13. prodigal
14. pplacer
15. CheckM (https://github.com/Ecogenomics/CheckM/wiki)
16. mafft
17. blast
18. fasttree
19. ete3
20. MetaCHIP (https://github.com/songweizhi/MetaCHIP)
21. diamond (https://github.com/bbuchfink/diamond/wiki)
22. pandas

**Input** - two paired-end fastq/fq files

**Commands**

sbatch pipeline_before_gtdbtk.sh sample sample_read1.fq sample_read2.fq   

sbatch pipeline_from_gtdbtk.sh sample 

**Output**

list of horizontally transferred ARGs with the direction of transfer (donor and recepient)
