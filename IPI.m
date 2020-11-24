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

% 'D:\ProgramCache\MATLAB\InfraredSmallTargetDetection\data\Frames2\0001.bmp'
% num = '5';
Img = imread('../TestImages/0110.bmp');
if ndims(Img) == 3
    Img = rgb2gray(Img);
end
Img = im2double(Img);

% Img = imnoise(Img, 'gaussian', 0, 0.0001);

figure,imshow(Img),title('Original Image');

[m, n] = size(Img);
% Options initiation
len = 30;
step = 10;

% Construct image-patch
patchImg = zeros(len*len, (length(1:step:m-len)*length(1:step:n-len)));
counter = 1;
for i = 1:step:m-len
    for j = 1:step:n-len
        tmp_patch = Img(i:i+len-1, j:j+len-1);
        patchImg(:, counter) = reshape(tmp_patch, len*len, 1);
        counter = counter + 1;
    end
end

% Iterate solution
% IPI-Lp model with ADMM
lambda = 1 / len;
[B, T, loss] = func_ADMM_Lp(patchImg, lambda, 0.4);

% Reconstruct target image and background image
reconsT = zeros(m, n, 100);
reconsB = zeros(m, n, 100);
countMatrix = zeros(m, n);
index = 1;

for i = 1:step:m-len
    for j = 1:step:n-len
        % Count the time each pixel used and record the value
        repatch_T = reshape(T(:,index), len, len);
        repatch_B = reshape(B(:,index), len, len);
        countMatrix(i:i+len-1, j:j+len-1) = countMatrix(i:i+len-1, j:j+len-1) + 1;
        
        % Record the value of each pixel
        for ii = i:i+len-1
            for jj = j:j+len-1
                reconsT(ii, jj, countMatrix(ii,jj)) = repatch_T(ii-i+1, jj-j+1);
                reconsB(ii, jj, countMatrix(ii,jj)) = repatch_B(ii-i+1, jj-j+1);
            end
        end
        
        index = index + 1;
    end
end

rstT = zeros(m, n);
rstB = zeros(m, n);

for i = 1:m
    for j = 1:n
        % Median
        if countMatrix(i ,j) > 0
            vectorT = reconsT(i, j, 1:countMatrix(i,j));
            vectorB = reconsB(i, j, 1:countMatrix(i,j));
            
            rstT(i, j) = mean(vectorT);
            rstB(i, j) = mean(vectorB);
        end
    end
end

% Show the result
figure,subplot(121),imshow(rstT .* (rstT>0), []),title('Target');
subplot(122),imshow(rstB .* (rstB>0), []),title('Background');

[X, Y] = meshgrid(1:n, 1:m);
figure;
rstT = rstT .* (rstT>0);
rst_3D = mesh(X, Y, rstT);
xlim([1, n]),ylim([1, m]);
grid on




