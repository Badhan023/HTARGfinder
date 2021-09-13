#!/bin/sh
#SBATCH --time=100:00:00
#SBATCH --partition=largemem_q
#SBATCH -n 32
#SBATCH --mem=240G
#SBATCH --account=computeomics

echo $1     ##prefix of files

cd ${1}_bins_dir
var=( $(ls) )
echo ${var[0]}

##gtdb-toolkit
gtdbtk classify_wf --genome_dir ${1}_bins_dir -x $extension --out_dir ${1}_gtdbtk_out --cpus 32
echo "gtdb-tookit done"

##MetaCHIP
MetaCHIP PI -p $1 -r c -t 6 -i ${1}_bins_dir -x $extension -taxon ${1}_gtdbtk_out/gtdbtk.bac120.summary.tsv
MetaCHIP BP -p $1 -r c -t 6
echo "MetaCHIP done"

##DIAMOND
diamond blastx -q ${1}_MetaCHIP_wd/${1}_HGT_*/${1}*BM_nc.fasta -d reference_ARG -o ${1}_diamond_out_default.tsv
echo "DIAMOND done"

##cross-checking
python3 cross_checking.py ${1}_MetaCHIP_wd/${1}_HGT_*/${1}_c_detected_HGTs.txt ${1}_diamond_out_default.tsv ${1}_HTARGs.csv
echo "cross-checking done"

echo "pipeline ends"
