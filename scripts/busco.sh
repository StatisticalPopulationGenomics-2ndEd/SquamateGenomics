#!/bin/bash

#SBATCH --job-name=busco_sqmt
#SBATCH --ntasks=2
#SBATCH --array=297,298
#SBATCH --nodes=2
#SBATCH --time=10:00:00
#SBATCH --mem=150G
#SBATCH --error=/home/zajac/busco_sqmt.%J.err
#SBATCH --output=/home/zajac/busco_sqmt.%J.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zajac@evolbio.mpg.de
#SBATCH --partition=highmemnew

source /data/modules/python/python-miniconda3-2025-02/etc/profile.d/conda.sh
conda activate buscov5

k=$SLURM_ARRAY_TASK_ID
genome=`sed -n ${k}p < /home/zajac/SquamateGenomics/list_of_genomes`
genome_unzip=$(echo $genome | sed 's/.gz//g')
name=$(echo $genome | sed 's/_genomic.fna.gz//g' | sed 's"/groups/mpistaff/Zajac/squamate_genomes/""g')

#gunzip $genome
busco -i $genome_unzip  -l /home/zajac/SquamateGenomics/sauropsida_odb12/ -o ${name} -m genome --cpu 2
