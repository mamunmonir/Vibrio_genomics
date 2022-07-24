#!/bin/bash
/home/mamun/.conda/envs/my_root/bin/bcftools mpileup -Ov -f Vibrio_N16961.fasta ./ANA{1..981}sort.bam | /home/mamun/.conda/envs/my_root/bin/bcftools call -mv --ploidy 1 -o ANA.vcf
echo "done"