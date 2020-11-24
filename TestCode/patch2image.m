% This function aims to transfrom a patch image to an image.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:
%   patchImg: a patch image;
%   len: the length of the slide window;
%   step: the step that the window slide;
% Output:
%   image: the output image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you have any questions, please contact:
% Author: Tianfang Zhang
% Email: sparkcarleton@gmail.com
% Copyright:  University of Electronic Science and Technology of China
% Date: 2019/4/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function image = patch2image(patchImg, len, step, imageSize)

m = imageSize(1); n = imageSize(2);

recons = zeros(m, n, 100);
countMatrix = zeros(m, n);
index = 1;

for i = 1:step:m-len
    for j = 1:step:n-len
        % Count the time each pixel used and record the value
        repatch = reshape(patchImg(:,index), len, len);
        countMatrix(i:i+len-1, j:j+len-1) = countMatrix(i:i+len-1, j:j+len-1) + 1;
        
        % Record the value of each pixel
        for ii = i:i+len-1
            for jj = j:j+len-1
                recons(ii, jj, countMatrix(ii,jj)) = repatch(ii-i+1, jj-j+1);
            end
        end
        
        index = index + 1;
    end
end

image = zeros(m, n);

for i = 1:m
    for j = 1:n
        % Median
        if countMatrix(i ,j) > 0
            vector = recons(i, j, 1:countMatrix(i,j));
            
            image(i, j) = mean(vector);
        end
    end
end

end