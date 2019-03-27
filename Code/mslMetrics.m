function [SR_map1,SR_map2,GM_map1,GM_map2,Sal_map1,Sal_map2,PC1,PC2,I1,I2,Q1,Q2] =mslMetrics(img1, img2)

% RGB to YIQ color domain transformation
[rows, cols] = size(img1(:,:,1));
I1 = ones(rows, cols);
I2 = ones(rows, cols);
Q1 = ones(rows, cols);
Q2 = ones(rows, cols);

if ndims(img1) == 3 %images are colorful
    Y1 = 0.299 * double(img1(:,:,1)) + 0.587 * double(img1(:,:,2)) + 0.114 * double(img1(:,:,3));
    Y2 = 0.299 * double(img2(:,:,1)) + 0.587 * double(img2(:,:,2)) + 0.114 * double(img2(:,:,3));
    I1 = 0.596 * double(img1(:,:,1)) - 0.274 * double(img1(:,:,2)) - 0.322 * double(img1(:,:,3));
    I2 = 0.596 * double(img2(:,:,1)) - 0.274 * double(img2(:,:,2)) - 0.322 * double(img2(:,:,3));
    Q1 = 0.211 * double(img1(:,:,1)) - 0.523 * double(img1(:,:,2)) + 0.312 * double(img1(:,:,3));
    Q2 = 0.211 * double(img2(:,:,1)) - 0.523 * double(img2(:,:,2)) + 0.312 * double(img2(:,:,3));
else %images are grayscale
    Y1 = img1;
    Y2 = img2;
end

Y1 = double(Y1);
Y2 = double(Y2);

% Downsample the image
minDimension = min(rows,cols);
F = max(1,round(minDimension / 256));
aveKernel = fspecial('average',F);

aveI1 = conv2(I1, aveKernel,'same');
aveI2 = conv2(I2, aveKernel,'same');
I1 = aveI1(1:F:rows,1:F:cols);
I2 = aveI2(1:F:rows,1:F:cols);

aveQ1 = conv2(Q1, aveKernel,'same');
aveQ2 = conv2(Q2, aveKernel,'same');
Q1 = aveQ1(1:F:rows,1:F:cols);
Q2 = aveQ2(1:F:rows,1:F:cols);

aveY1 = conv2(Y1, aveKernel,'same');
aveY2 = conv2(Y2, aveKernel,'same');
Y1 = aveY1(1:F:rows,1:F:cols);
Y2 = aveY2(1:F:rows,1:F:cols);


% Calculate the phase congruency maps
PC1 = phasecong2(Y1);
PC2 = phasecong2(Y2);

% Calculate spectral residual maps

blockSize=[10 10];
stdDev=3.8;
avSize=3;
sY1 = imresize(Y1, 0.25);
myFFT = fft2(sY1); 
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', avSize), 'replicate'); 
SR_map1 = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;
SR_map1 = mat2gray(imfilter(SR_map1, fspecial('gaussian', blockSize, stdDev)));
SR_map1 = imresize(SR_map1,size(Y1));

sY2 = imresize(Y2, 0.25);
myFFT2 = fft2(sY2); 
myLogAmplitude2 = log(abs(myFFT2));
myPhase2 = angle(myFFT2);
mySpectralResidual2 = myLogAmplitude2 - imfilter(myLogAmplitude2, fspecial('average', avSize), 'replicate'); 
SR_map2 = abs(ifft2(exp(mySpectralResidual2 + i*myPhase2))).^2;
SR_map2 = mat2gray(imfilter(SR_map2, fspecial('gaussian', blockSize, stdDev)));
SR_map2=imresize(SR_map2,size(Y2));




% Calculate gradient maps
dx = [3 0 -3; 10 0 -10;  3  0 -3]/16;
dy = [3 10 3; 0  0   0; -3 -10 -3]/16;
% IxY1 = conv2(Y1, dx, 'same');     
% IyY1 = conv2(Y1, dy, 'same');    
IxY1 = conv2(Y1, dx, 'same');     
IyY1 = conv2(Y1, dy, 'same'); 
GM_map1 = sqrt(IxY1.^2 + IyY1.^2);

% IxY2 = conv2(Y2, dx, 'same');     
% IyY2 = conv2(Y2, dy, 'same');   
IxY2 = conv2(Y2, dx, 'same');     
IyY2 = conv2(Y2, dy, 'same');   

GM_map2 = sqrt(IxY2.^2 + IyY2.^2);

GM_map1=imresize(GM_map1,size(SR_map1));
GM_map2=imresize(GM_map2,size(SR_map1));

%calculate bless

window_sizes= [30 30];
rsz=6;
gamma        = 2.4;                     % gamma value for gamma correction
srgb_flag    = 0;                       % 0 if img is rgb; 1 if img is srgb

Sal_map1=abs(SIM(img1, window_sizes, gamma, srgb_flag, rsz));
Sal_map2=abs(SIM(img2, window_sizes, gamma, srgb_flag, rsz));


Sal_map1=abs(imresize(Sal_map1,size(GM_map1)));
Sal_map2=abs(imresize(Sal_map2,size(GM_map1)));


PC1=abs(imresize(PC1,size(GM_map1)));
PC2=abs(imresize(PC2,size(GM_map1)));


end

