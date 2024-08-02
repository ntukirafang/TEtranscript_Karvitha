#!/bin/bash
#
#SBATCH --job-name=TEtranscript
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=256G
#SBATCH --output=/wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/POGZ_project/TE-mm10-%A_%a.out
#SBATCH --array=0-0
#SBATCH --time=0-08:00:00

treat_bam=/wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/POGZ_project/Bam/POGZ_KD/*.bam
control_bam=/wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/POGZ_project/Bam/WT/*.bam
ref_gtf=/wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/POGZ_project/GTF/mouse/mm10.ncbiRefSeq.gtf
TE_gtf=/wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/POGZ_project/TE_GTF/mouse/mm10_rmsk_TE.gtf
outputdirectory=/wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/POGZ_project/Output/

module load Python/3.10.4-GCCcore-11.3.0
module load R/4.2.1-foss-2022a
module load Anaconda3
pip3 install pysam
eval "$(conda shell.bash hook)"
conda activate TE_transcript
cd /wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/
source myenv/bin/activate
cd /wistar/sarma/Jimmy/Bioinformatics_tools/TE_transcript/TEtranscripts-master
python setup.py install

cd ${outputdirectory}
mkdir Test
cd Test

TEtranscripts --sortByPos --format BAM --mode multi -t ${treat_bam} -c ${control_bam} --GTF ${ref_gtf} --TE ${TE_gtf} --project TE_transcript_test --outdir ./
