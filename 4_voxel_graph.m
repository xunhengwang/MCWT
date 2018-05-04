clc
clear all
n = 3;                   % Decomposition Level
w = 'sym4';              % Near symmetric wavelet
rThreshold=[0.5,0.6,0.7,0.8,0.9];

for i=1:length(rThreshold)
    for j=1:42
        r=rThreshold(i);
        %%%%%%%%%%%%%%%%%%%%%%%
        %%%%modify as you need
        AllVolume=['/Users/xunhengwang/Documents/MATLAB/paper7/vbm/wKKI2009-',num2str(j,'%02d'),'_',w,'_',num2str(n),'_zscore.nii']; 
        OutputName=['/Users/xunhengwang/Documents/MATLAB/paper7/vbm/wKKI2009-',num2str(j,'%02d'),'_',w,'_',num2str(n),'_zscore_dc_',num2str(r),'.nii']; 
        MaskFile='/Users/xunhengwang/Documents/MATLAB/paper7/aal_2mm.nii.gz'; 
        %%%%%%%%%%%%%%%%%%%%
        [MaskData,MaskVox,MaskHead]=rest_readfile(MaskFile);
        MaskData(MaskData>90)=0;
        %%%%%%%%%
        %%%need DPARSF toolbox:http://restfmri.net/forum/index.php
        [DegreeCentrality_PositiveWeightedSumBrain, DegreeCentrality_PositiveBinarizedSumBrain, Header] = y_DegreeCentrality(AllVolume, r, OutputName, MaskData);
        %%%%%%%%%%
    end
end