function lse0 = psrlse2(y,x,d,l,u,k1)
% =====================================================================
% This function is the PSR with propensity score estimated with MLE and
% estimate the ATE with LSE

% input 
% y: dependent variable (n*1)
% x: independent variables (n*k)
% l: lower bound for trimming ps
% u: upper bound for trimming ps

% output
% least square estimator & weighted least square estimator with s.d. value
% =====================================================================

n = size(x,1);
X = [ones(n,1) x];

% propensity score estimation
[~, p] = Estm0(k1, d, x);
dres = d-p;

% drop if p<l and p>u
index = p<l|p>u;

y(index,:) = [];
X(index,:) = [];
dres(index,:) = [];
p(index,:) = [];
d(index,:) = [];
n = n - sum(index);

dressq = dres'*dres;

%===================================
% LSE
%===================================

lse0=dres'*y/dressq;



 


end
