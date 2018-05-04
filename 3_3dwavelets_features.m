clc
clear all

workdir=['/Users/xunhengwang/Documents/MATLAB/paper7/vbm/'];%modify as you need
sufix='.nii.gz';

MaskFile=['/usr/local/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz'];%modify as you need
[MaskData,LabelHeader]=rest_ReadNiftiImage(MaskFile);
[dim1,dim2,dim3]=size(MaskData);
index=find(MaskData>0);

n = 3;                   % Decomposition Level
w = 'sym4';              % Near symmetric wavelet

for j=1:42
    PO=[workdir,'KKI2009-',num2str(j,'%02d'),sufix];%modify as you need
    [X, dataHeader]=rest_ReadNiftiImage(PO);%%need rest package:http://restfmri.net/forum/index.php
    X(find(MaskData==0))=0;
    data4d=zeros(dim1,dim2,dim3,6);
    %%%%%%%%%%%%%%%%

    WT = wavedec3(X,n,w);    % Multilevel 3D wavelet decomposition.
    A = cell(1,n);
    D = cell(1,n);
    for k = 1:n
        A{k} = waverec3(WT,'a',k);   % Approximations (low-pass components)
        D{k} = waverec3(WT,'d',k);   % Details (high-pass components)
    end
     for i=1:n
         temp1=A{i};
         temp2=D{i};
         temp1(index)=zscore(temp1(index));
         temp2(index)=zscore(temp2(index));
         data4d(:,:,:,i)=temp1;
         data4d(:,:,:,n+i)=temp2;
     end
    PO=[workdir,'w','KKI2009-',num2str(j,'%02d'),'_',w,'_',num2str(n),'_zscore.nii'];%modify as you need
    original_header=LabelHeader;
    original_header.dt(1)=16;
    rest_Write4DNIfTI(data4d,original_header,PO); %%need rest package:http://restfmri.net/forum/index.php

    fprintf(['running the : ', 'KKI2009-',num2str(j,'%02d'),' th sub OK \n']);
end
