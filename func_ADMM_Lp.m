% This function aims to separate the background image and target image via
% Alternating Direction Method of Multipliers (ADMM)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paremeter Explanation
% 
% Input: patchImg -> input image
%        lambda
% Output: B -> background patch, the low-rank matrix
%         T -> target patch, the sparse matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you have any questions, please contact:
% Author: Tianfang Zhang
% Email: sparkcarleton@gmail.com
% Copyright:  University of Electronic Science and Technology of China
% Date: 2018/11/7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function [B, T, loss] = func_ADMM_Lp(D, lambda, p)

% Parameters setting
B_k = D;   B_kp1 = D;
T_k = zeros(size(D));   T_kp1 = zeros(size(D));
Y_k = zeros(size(D));   Y_kp1 = zeros(size(D));

rho_k = 1 / (5*std(D(:)));
iterNum = 0;
normD = norm(D, 'fro');
Converged = false;
loss = [];

% Iteration steps
while ~Converged
    % Update B
    B_kp1 = singularValueShrinkage(D + Y_k/rho_k - T_k, 1/rho_k);
    
    % Update T
    tmp = D + Y_k/rho_k - B_kp1;
    T_kp1 = softThreshold_Lp(tmp .* (tmp>0), lambda/rho_k, p);
    
    % Update Y
    Y_kp1 = Y_k + rho_k*(D - B_kp1 - T_kp1);
    rho_kp1 = rho_k * 1.5;
    
    % Judge converged
    iterNum = iterNum + 1;
    stopCriterion = norm(D-B_kp1-T_kp1, 'fro') / normD;
    loss(iterNum) = stopCriterion;
    
    nonzeroNum_k = sum(T_k(:) ~= 0);
    nonzeroNum_kp1 = sum(T_kp1(:) ~= 0);

    if stopCriterion < 1e-7 || (nonzeroNum_k == nonzeroNum_kp1 && nonzeroNum_k ~= 0)
        Converged = true;
    end
    
    % Disp the status
    disp(['Iteration Number: ', num2str(iterNum), '    loss: ', num2str(stopCriterion)]);
    disp(['Non zero number: ', num2str(nonzeroNum_k)]);
    disp(' ');
    
    % Assignment to contine
    B_k = B_kp1;    T_k = T_kp1;
    Y_k = Y_kp1;    rho_k = rho_kp1;
end

B = B_k;
T = T_k;

end