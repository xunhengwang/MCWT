#!/bin/sh
n=5 #wavelet scale
for r in 0.5 0.6 0.7 0.8 0.9
do
sufix=sym4_${n}_zscore_dc_${r}_DegreeCentrality_PositiveBinarizedSumBrain ##modify as you need
for sub in `cat subs.txt`
do
echo $sub
fslmaths w${sub}_${sufix}.nii -s 3 s3w${sub}_${sufix}.nii
done

done
