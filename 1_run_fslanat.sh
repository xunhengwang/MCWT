#!/bin/sh
for sub in `cat subs.txt`
do
echo $sub
fsl_anat -i $sub
done
