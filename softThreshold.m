% This function aims to soft thresholding
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paremeter Explanation
% Input: inImg
%        epsilon
% Output: output -> the size is as same as inImg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you have any questions, please contact:
% Author: Tianfang Zhang
% Email: sparkcarleton@gmail.com
% Copyright:  University of Electronic Science and Technology of China
% Date: 2018/9/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function output = softThreshold(inImg, epsilon)
    output = zeros(size(inImg));
    posImg = inImg .* (inImg>epsilon);
    negImg = inImg .* (inImg<-epsilon);
    output = output + (posImg-epsilon).*(inImg>epsilon) + (negImg+epsilon) .* (inImg<-epsilon);
end