% This function aims to transfrom an image to a patch image.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:
%   inImg: an image;
%   len: the length of the slide window;
%   step: the step that the window slide;
% Output:
%   patchImg: the output patch image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you have any questions, please contact:
% Author: Tianfang Zhang
% Email: sparkcarleton@gmail.com
% Copyright:  University of Electronic Science and Technology of China
% Date: 2019/4/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function patchImg = image2patch(inImg, len, step)

[m, n] = size(inImg);
patchImg = zeros(len*len, (length(1:step:m-len)*length(1:step:n-len)));
counter = 1;

for i = 1:step:m-len
    for j = 1:step:n-len
        tmp_patch = inImg(i:i+len-1, j:j+len-1);
        patchImg(:, counter) = reshape(tmp_patch, len*len, 1);
        counter = counter + 1;
    end
end

end