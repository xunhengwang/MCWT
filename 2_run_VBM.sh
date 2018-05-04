#!/bin/sh
template=/usr/local/fsl/data/standard/MNI152_T1_2mm.nii.gz
for sub in `cat subs.txt`
do
echo $sub
cd ${sub%.nii.gz}.anat
applywarp --ref=${template} --in=T1_fast_pve_1.nii.gz --warp=T1_to_MNI_nonlin_field.nii.gz --out=warped_gm.nii.gz
fslmaths warped_gm.nii.gz -mul T1_to_MNI_nonlin_jac.nii.gz mod_warped_gm -odt float
cd ..
done
