# BLeSS
Code for paper - D. Temel and G. AlRegib, “BLeSS: Bio-inspired Low-level Spatiochromatic Similarity Assisted Image Quality Assessment “, the IEEE International Conference on Multimedia and Expo , Seattle, USA, Jul. 11-15, 2016.


<p align="center">
  <img src=/Images/BLeSS.PNG/>
</p> 

### Paper
ArXiv: https://arxiv.org/abs/1811.07044

IEEE: https://ieeexplore.ieee.org/document/7552874 

This is a brief explanation and demonstration of the proposed image quality assessment (IQA) assistance algorithm BLeSS, which can be used to complement existing IQA algorithms. In this study, we show that BLeSS can be used to complement IQA algorithms based on phase congruency, gradient magnitude, and spectral residual 



### Citation
If you find our paper and repository useful, please consider citing our paper:  
```
@INPROCEEDINGS{Temel2016_ICME, 
author={D. {Temel} and G. {AlRegib}}, 
booktitle={2016 IEEE International Conference on Multimedia and Expo (ICME)}, 
title={BLeSS: Bio-inspired low-level spatiochromatic similarity assisted image quality assessment}, 
year={2016}, 
volume={}, 
number={}, 
pages={1-6}, 
doi={10.1109/ICME.2016.7552874}, 
ISSN={1945-788X}, 
month={July},}

```
### Code
#### Run:
- Run mslPoolingMetric(img1,img2,1,4) ---> SR-SIM
- Run mslPoolingMetric(img1,img2,2,4) ---> FSIM
- Run mslPoolingMetric(img1,img2,3,4) ---> FSIMc
- Run mslPoolingMetric(img1,img2,4,1) ---> BLeSS-SR-SIM
- Run mslPoolingMetric(img1,img2,4,2) ---> BLeSS-FSIM
- Run mslPoolingMetric(img1,img2,4,3) ---> BLeSS-FSIMc
#### Main files:
- mslMetrics.m: computes BleSS and the main blocks of BleSS assisted quality metrics
- mslPoolingMetric.m: combines quality attribute and pooling strategy to obtain the final quality score
#### External package (http://www.cvc.uab.cat/~xotazu/?page_id=116):
- SIM.m: converts the image to the opponent colour space, generates a saliency map for each channel and combines these maps to produce the final saliency map.
- rgb2opponent.m: converts the image to the opponent colour space.
- generate_csf.m: returns the value of the csf at a specific center-surround contrast energy and spatial scale.
- GT.m: performs the forward DWT and GT on one channel of an image and applies the ECSF.
- blockMatching.<c,mexa64,mexglx,mexw64>: block matching source code and executables. Determines association field.
- norm_center_contrast.m: computes normalized center contrast
- IDWT.m: performs the inverse DWT on one channel of an image.
- symmetric_filtering.m: performs 1D Gabor filtering with symmetric edge handling.
- mirroring.m: helper function to symmetric_filtering.m
#### Existing IQA Algorithms:
- SR_SIM: Spectral residual similarity-based image quality metric code
- phasecong2.m: Quality attribute code based on phase congruenbcy used in FSIM and FSIMc quality metrics
- lowpassfilter.m: required for phasecong2
- FeatureSIM.m: FSIM quality metric code



### Abstract 
This paper proposes a biologically-inspired low-level spatiochromatic-model-based similarity method (BLeSS) to assist full-reference image-quality estimators that originally oversimplify color perception processes. More specifically, the spatiochromatic model is based on spatial frequency, spatial orientation, and surround contrast effects. The assistant similarity method is used to complement image-quality estimators based on phase congruency, gradient magnitude, and spectral residual. The effectiveness of BLeSS is validated using FSIM, FSIMc and SR-SIM methods on LIVE, Multiply Distorted LIVE, and TID 2013 databases. In terms of Spearman correlation, BLeSS enhances the performance of all quality estimators in color-based degradations and the enhancement is at 100% for both feature- and spectral residualbased similarity methods. Moreover, BleSS significantly enhances the performance of SR-SIM and FSIM in the full TID 2013 database.

### Keywords
color perception, chromatic induction, image-quality assessment, computational perception, surround-frequency effect, surround-orientation effect, surround-contrast effect




### Contact:

Ghassan AlRegib:  alregib@gatech.edu, https://ghassanalregib.com/, 

Dogancan Temel: dcantemel@gmail.com, http://cantemel.com/


