function [bhat, dhat] = Estm(k1, d, x)
% =====================================================================
% This function is the semiparametric estimation of propensity score using
% the Maximum Likelihood Approach 
%
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
% =====================================================================

[N, ~] = size(x);

% Step 1 The choice of initial value for estimation of theta
btemp1 = (x'*x)\(x'*d);

% Step 2 The function to be minimized
f1 = @(b)Semipk(b, k1, d, x);

A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = @unitdisk;

bhat = fmincon(f1,btemp1,A,b,Aeq,beq,lb,ub,nonlcon);
    
SI = x*bhat;
HP_exp = zeros(N, k1);
for k = 1:k1
    HP_exp(:, k) = 1/(sqrt(gamma(k+1)))*HP(SI, k-1);
end

% Step 3 The function to be minimized
a0 = HP_exp\d;
f = @(a) objfun(a,d,HP_exp);
options = optimoptions('fminunc','Algorithm','quasi-newton');
[ck,~] = fminunc(f,a0,options);
 
dhat = exp(HP_exp*ck)./(1+exp(HP_exp*ck));
 
end
