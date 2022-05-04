mkdir HTARGfinder
cd HTARGfinder
conda create -n gtdbtk -c conda-forge -c bioconda gtdbtk=1.3.0
conda activate gtdbtk
conda install -c bioconda fastp
conda install -c bioconda megahit
conda install -c bioconda bwa
conda install -c bioconda samtools
conda install -c anaconda openssl
conda install -c anaconda cmake
conda install -c bioconda metabat2
conda install -c bioconda/label/cf201901 metabat2
pip3 install numpy
pip3 install matplotlib
pip3 install pysam
pip install hmmer
conda install -c bioconda prodigal
conda install -c bioconda pplacer
pip3 install checkm-genome
pip3 install checkm-genome --upgrade --no-deps
wget https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz
mkdir checkm
tar -xvf checkm_data*.tar.gz -C checkm
checkm data setRoot checkm
conda install -c bioconda mafft
conda install -c bioconda blast
conda install -c bioconda fasttree
conda install -c etetoolkit ete3
pip3 install MetaCHIP
pip3 install --upgrade MetaCHIP
conda install -c bioconda diamond
diamond makedb --in ARGDB.fasta -d reference_ARG
diamond makedb --in protein_fasta_protein_homolog_model.fasta -d reference_CARD
conda install -c conda-forge pandas
download-db.sh