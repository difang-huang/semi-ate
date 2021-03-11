function Runsimulation2(no_mc, N, k1, ind, no_par)
% =====================================================================
% This function provides a simple Monte Carlo study for the following
% single index model:
%          d_i = f*g(x_i'theta) + e_i
% The bias and mean squared errors (MSE) of the estimate on theta are 
% stored in a txt file.
%
% Input: 
% no_mc   The number of iterations
% N       The number of individuals
% k1      The truncation parameter
% ind     The choice of link function
% no_par  The number of parallel computation

% Output:
%         The Bias and MSE are stored in the generated txt file
% =====================================================================

%---- Parallel Computing ----
if isempty(gcp('nocreate'))  % checking to see if matlab pool is already open
    parpool(no_par);
elseif ~isempty(gcp('nocreate')) 
    delete(gcp('nocreate'));
    parpool(no_par);
else
end

%----- Simulation ----

% True value of theta (does not satisfy the identification condition)
beta1 = 0.5;
beta2 = -0.5;
d     = 2;    % The number of parameters

Results = nan(no_mc, d);

Ttheta       = zeros(d,1);
Ttheta(1, 1) = beta1;
Ttheta(2, 1) = beta2;

parfor l = 1:no_mc
    
    try
        
    % ---------------------------------------------------------------------
    % (1) DGP
    fprintf('\nThe %5.0fth iteration\n', l)
    
    x1 = randn(N,1);
    x2 = randn(N,1);
    x  = [x1, x2];
    
    % Generate y with different models (Gfun1-2.o,m)
    y = Gfun2(x*Ttheta, ind);
    %yhat = Gfun1(x*Ttheta, ind);
    
    % ---------------------------------------------------------------------
    % (2) estimation of propensity score
    [bhat1, ~] = Estm(k1, y, x);
   
	% ---------------------------------------------------------------------
    % (3) store the results
    Results(l,:) = bhat1';
    
	catch
    fprintf('Inconsistent data in iteration %5.0f skipped.\n', l);
    end

end

delete(gcp('nocreate'));

end
