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
fastp -i $2 -I $3 -o ${1}_out1.fastq -O ${1}_out2.fastq
echo "fastp done"

##megahit
megahit -1 ${1}_out1.fastq -2 ${1}_out2.fastq -o ${1}_megahit_output
echo "megahit done"

##bwa
bwa index ${1}_megahit_output/final.contigs.fa
bwa mem ${1}_megahit_output/final.contigs.fa ${1}_out1.fastq ${1}_out2.fastq > ${1}_aln-pe.sam
echo "bwa done"

##samtools
samtools view -S -b ${1}_aln-pe.sam > ${1}_sample.bam
samtools sort ${1}_sample.bam -o ${1}_sorted.bam
echo "samtools done"

##metabat
cd berkeleylab-metabat-*
runMetaBat.sh ../${1}_megahit_output/final.contigs.fa ../${1}_sorted.bam
mv final.contigs.fa.metabat-bins-* ..
cd ..
mv final.contigs.fa.metabat-bins-* ${1}_metabat_bins_dir
echo "MetaBat done"

cd ${1}_metabat_bins_dir
var=( $(ls) )
echo ${var[0]}

cd ..
filename=$(basename -- "${var[0]}")
extension="${filename##*.}"

##checkm-genome
checkm lineage_wf --tab_table --file ${1}_checkm.csv -t 8 -x $extension ${1}_metabat_bins_dir ${1}_chechm_metabat_bins_dir
echo "checkm-genome done"

##filtering
python3 filtering_bins.py ${1}_checkm.csv
echo "filtering done"

##removing
bash remove.sh ${1}_checkm_filtered.csv ${1}_metabat_bins_dir
echo "removing done"

##gtdb-toolkit
gtdbtk classify_wf --genome_dir ${1}_metabat_bins_dir -x $extension --out_dir ${1}_gtdbtk_out --cpus 32
echo "gtdb-tookit done"

##MetaCHIP
MetaCHIP PI -p $1 -r c -t 6 -i ${1}_metabat_bins_dir -x $extension -taxon ${1}_gtdbtk_out/gtdbtk.bac120.summary.tsv
MetaCHIP BP -p $1 -r c -t 6
echo "MetaCHIP done"

##DIAMOND
diamond blastx -q ${1}_MetaCHIP_wd/${1}_HGT_*/${1}*BM_nc.fasta -d reference_ARG -o ${1}_diamond_out_default.tsv
echo "DIAMOND done"

##cross-checking
python3 cross_checking.py ${1}_MetaCHIP_wd/${1}_HGT_*/${1}_c_detected_HGTs.txt ${1}_diamond_out_default.tsv ${1}_HTARGs.csv
echo "cross-checking done"

echo "pipeline ends"


