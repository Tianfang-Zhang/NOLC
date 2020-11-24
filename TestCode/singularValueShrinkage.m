% This function aims to singular value shrinkage
% 
% Reference: Cai J F, Cand, S, E J, et al. A Singular Value Thresholding Algorithm for Matrix Completion[J]. Siam Journal on Optimization, 2008, 20(4):1956-1982.
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
% Date: 2018/9/26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function output = singularValueShrinkage(inImg, epsilon)

[U, S, V] = svd(inImg, 'econ');
output = U*softThreshold(S, epsilon)*V';

end