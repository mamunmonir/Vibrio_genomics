#!/bin/bash
for iter in {1..981}
    do
      /home/mamun/.conda/envs/my_root/bin/spades.py -1 ANA$iter"_R1.fastq.gz" -2 ANA$iter"_R2.fastq.gz" --careful --cov-cutoff auto -o ANA$iter
done