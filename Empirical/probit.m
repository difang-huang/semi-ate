function [b, dhat] = probit(d, x)
% =====================================================================
% This function is the probit approach for propensity score estimation of
% the following models
%
%      y_i = g(x_i'theta) + e_i,  i=1,...,N 
%
% y_i   The dependent variable (1 x 1)
% x_i   The regressor (d x 1). Notice that due to the second decomposition
%       and demean process, X_i can not include a constant 1.     
% e_i   The error term (1 x 1)
%
% Input:
% y     The data set of the dependent variable (N x 1)
% x     The data set of the regressor (N x T x d)
% k1    The truncation parameter, such that the basis functions: 
%       h_0,...,h_{k-1} are chosen
% Output:
%       The fitted value of ck
%       The fitted outcome of dk
% =====================================================================

n = size(x,1);
X = [ones(n,1) x];
 
% propensity score estimation
b = glmfit(x,[d ones(length(d),1)],'binomial','link','probit');
ma = X*b;
dhat = normcdf(ma);
 
end
