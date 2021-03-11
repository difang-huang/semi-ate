function f = Semipk(b, k1, y, x)
% =====================================================================
% This function provides the esimation of the following model
%
%      d_i = f*g(x_i'theta) + e_i,  i=1,...,N 
%
% d_i   The binary dependent variable (1 x 1)
% x_i   The regressor (d x 1). Notice that due to the second decomposition
%       and demean process, X_i can not include a constant 1.     
% e_i   The error term (1 x 1)
%
% Input:
% d     The data set of the dependent variable (N x 1)
% x     The data set of the regressor (N x T x d)
% k1    The truncation parameter, such that the basis functions: 
%       h_0,...,h_{k-1} are chosen
% Output:
%       The fitted value of ck
%       The fitted outcome of dk
% Warnings:
%       I assume the observation of x and y are the same
% [N1, T1]  = size(y);
% if N ~= N1 || T1 ~= 1
%     error(['The dimensions of X and Y are not correct:\n', ...
%            'X is size [%d x %d]\n', ...
%            'Y is size [%d x 1]'], N, d, N1)
% end
% 
% if length(b) ~= d
%     error('The number of parameters is not correct.')
% end
% =====================================================================

[N, ~] = size(x);

% Step 1 The Hermite polynomials
SI = x*b;

HP_exp = zeros(N, k1);
for k = 1:k1
    HP_exp(:, k) = 1/(sqrt(gamma(k+1)))*HP(SI, k-1);
end

% Step 2 Calculate the optimal value of c_k given the value of theta
a0 = HP_exp\y;
f = @(a)objfun(a,y,HP_exp);
options = optimoptions('fminunc','Algorithm','quasi-newton');
[a,~] = fminunc(f,a0,options);

% Step 3 Calculate the optimal value of objective function
F = -y.*(HP_exp*a) + log(1+exp(HP_exp*a));
f = mean(F);

end