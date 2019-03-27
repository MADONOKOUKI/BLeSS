% window_sizes = [17 37];                 % window sizes for computing normalized center contrast
window_sizes = [5 5];                 % window sizes for computing normalized center contrast
gamma        = 2.4;                     % gamma value for gamma correction
srgb_flag    = 1;                       % 0 if img is rgb; 1 if img is srgb

% factor by which to resize image: 
% image should NOT be resized before calling SIM, 
% as the size of the image is related to the CSF.
rsz = 2;

% get saliency map:

nameRef     = 'I21.BMP';
imgRef          = imread(nameRef);
[m n p]      = size(imgRef);
smapRef = SIM(imgRef, window_sizes, gamma, srgb_flag, rsz);
nameDist     = 'I21_07_4.bmp';
imgDist         = imread(nameDist);
smapDist = SIM(imgDist, window_sizes, gamma, srgb_flag, rsz);

c1=0.4;
bills=(2*smapRef.*smapDist+c1)./(smapRef.^2+smapDist.^2+c1);


figure, imshow(imgRef);
figure, imshow(imgDist);
figure, imagesc(bills);
colormap jet