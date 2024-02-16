#!/bin/sh
#SBATCH --time=100:00:00
#SBATCH --partition=largemem_q
#SBATCH -n 32
#SBATCH --mem=240G
#SBATCH --account=computeomics

echo $1     ##prefix of files
echo $2     ##1st input
echo $3     ##2nd input

echo "pipeline starts"

##fastp
fastp -i $2 -I $3 -o ${1}_out1.fq -O ${1}_out2.fq
echo "fastp done"

##megahit
megahit -1 ${1}_out1.fq -2 ${1}_out2.fq -o ${1}_megahit_output
echo "megahit done"

##bwa
bwa index ${1}_megahit_output/final.contigs.fa
bwa mem ${1}_megahit_output/final.contigs.fa ${1}_out1.fq ${1}_out2.fq > ${1}_aln-pe.sam
echo "bwa done"

##samtools
samtools view -S -b ${1}_aln-pe.sam > ${1}_sample.bam
samtools sort ${1}_sample.bam -o ${1}_sorted.bam
echo "samtools done"

##metabat

gzip ${1}_megahit_output/final.contigs.fa
jgi_summarize_bam_contig_depths --outputDepth ${1}_depth.txt ${1}_sorted.bam
metabat2 -i ${1}_megahit_output/final.contigs.fa.gz -a ${1}_depth.txt -o ${1}_bins_dir/bin
gzip -d ${1}_megahit_output/final.contigs.fa.gz
echo "MetaBat done"

cd ${1}_bins_dir
var=( $(ls) )
echo ${var[0]}

cd ..
filename=$(basename -- "${var[0]}")
extension="${filename##*.}"

##checkm-genome
checkm lineage_wf --tab_table --file ${1}_checkm.csv -t 8 -x $extension ${1}_bins_dir ${1}_checkm_bins_dir
echo "checkm-genome done"

##filtering
python3 filtering_bins.py ${1}_checkm.csv
echo "filtering done"

##removing
bash remove.sh ${1}_checkm_filtered.csv ${1}_bins_dir
echo "removing done"
