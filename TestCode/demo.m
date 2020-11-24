% This code is an implementation of the NOLC model.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you have any questions, please contact:
% Author: Tianfang Zhang
% Email: sparkcarleton@gmail.com
% Copyright:  University of Electronic Science and Technology of China
% Date: 2018/9/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

clc;    clear;  close all;
%==========================================================================
% Change image name and p here!
img_path = './images/0006.bmp';
p = 0.6;
%==========================================================================

Img = imread(img_path);
if ndims(Img) == 3
    Img = rgb2gray(Img);
end
Img = im2double(Img);
[m, n] = size(Img);
figure,
subplot(131),imshow(Img),title('Original Image');

% Options initiation
len = 30;
step = 10;

% Construct image-patch
patchImg = image2patch(Img, len, step);

% Iterate solution
% % NOLC model with ADMM
lambda = 1 / len;
[B, T, loss] = optimization(patchImg, lambda, p);

% Reconstruct target image and background image
rstT = patch2image(T, len, step, size(Img));
rstB = patch2image(B, len, step, size(Img));

% Show the result
subplot(132),imshow(rstT .* (rstT>0), []),title('Target');
subplot(133),imshow(rstB .* (rstB>0), []),title('Background');

[X, Y] = meshgrid(1:n, 1:m);
figure;
rstT = rstT .* (rstT>0);
rst_3D = mesh(X, Y, rstT);
xlim([1, n]),ylim([1, m]);
grid on




