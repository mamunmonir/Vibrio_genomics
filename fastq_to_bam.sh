#!/bin/bash
for iter in {1..981}
    do
      /home/mamun/.conda/envs/my_root/bin/bwa mem Vibrio_N16961.fasta ANA$iter"_R1.fastq.gz" ANA$iter"_R2.fastq.gz" > ANA$iter".sam"
      /home/mamun/.conda/envs/my_root/bin/samtools view -bS ANA$iter".sam" > ANA$iter".bam"
      /home/mamun/.conda/envs/my_root/bin/samtools sort ANA$iter".bam" ANA$iter"sort"
done