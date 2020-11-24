% This function aims to soft thresholding in Lp norm
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
% Date: 2018/11/8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function output = softThreshold_Lp(inImg, epsilon, p)

[m, n] = size(inImg);
output = zeros(m, n);

v = (epsilon*p*(1-p)) ^ (1/(2-p));
v1 = v + epsilon * p * (abs(v)^(p-1));

mask = inImg > v1;

h = inline('(xh-ah)^2 / 2 + lambdah * abs(xh)^ph', 'xh', 'ah', 'lambdah', 'ph');

for i = 1:m
    for j = 1:n
        if mask(i, j) == 0
            continue;
        end
        
%         disp(['i=', num2str(i), '    j=', num2str(j)]);
        % Compare x=0 and x=x1
        x1 = newtonMethod_x1(inImg(i, j), epsilon, p);
        h0 = h(0, inImg(i, j), epsilon, p);
        h1 = h(x1, inImg(i, j), epsilon, p);
        if h0 < h1
            output(i, j) = 0;
        else
            output(i, j) = x1;
        end
        
    end
end

end

% This function aims to get a x when g(x)=0 via newton method
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paremeter Explanation
% 
% Input: a -> constant value and the initial value of x
%        lambda -> constant value
%        p -> constant value
% Output: output -> the answer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If you have any questions, please contact:
% Author: Tianfang Zhang
% Email: sparkcarleton@gmail.com
% Copyright:  University of Electronic Science and Technology of China
% Date: 2018/11/8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%* License: Our code is only available for non-commercial research use.

function x1 = newtonMethod_x1(a, lambda, p)
% g(x) = x - a + epilson * p * abs(x)^(p-1)*sgn(x)
g = inline('x - a + epilson * p * (abs(x)^(p-1)) * sign(x)', 'x', 'a', 'epilson', 'p');
gp = inline('1 - epilson * p * (1-p) * abs(x)^(p-2)', 'x', 'epilson', 'p');
x0 = a;   k = 0;  er = 1;

while er > 1e-7
    xk = x0 - g(x0, a, lambda, p) / gp(x0, lambda, p);
    er = abs(xk - x0);
    x0 = xk;
    k = k + 1;

end
x1 = xk;
end