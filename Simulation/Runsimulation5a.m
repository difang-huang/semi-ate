function Runsimulation5a(no_mc, N, k1, ind, no_par)
% =====================================================================
% This function provides a simple Monte Carlo study for the average
% treatment effect
%
% The bias and mean squared errors (MSE) of the estimate on theta are 
% stored in a txt file.
%
% Input: 
% no_mc   The number of iterations
% N       The number of individuals
% k1      The truncation parameter
% ind     The choice of link function
% no_par  The number of parallel computation
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

% True value of betas
beta1 = 0.8;
beta2 = -0.6;
theta = 1; % average treatment effect
d = 2; % The number of parameters

Ttheta       = zeros(d,1);
Ttheta(1, 1) = beta1;
Ttheta(2, 1) = beta2;

Results = nan(no_mc, 1);
 
parfor l = 1:no_mc
    
    try
        
	% ---------------------------------------------------------------------
    % (1) DGP
    
    fprintf('\nThe %5.0fth iteration\n', l)
    
    x1 = randn(N,1);
    x2 = randn(N,1);
    x  = [x1, x2];

    % Generate propensity score with different models (Gfun1-2.m)
    d = Gfun2(x*Ttheta, ind);
    %yhat = Gfun1(x*Ttheta, ind);

    % Generate outcome variable y
    e = randn(N,1);
    y = theta*d + x1 + x2 + e;

 
    % ---------------------------------------------------------------------
    % (2) estimation of average treatment effect
    low = 0;
    upp = 1;
    
    lse = psrlse2(y,x,d,low,upp,k1);
    
    % ---------------------------------------------------------------------
    % (3) store the results
	Results(l, :) = lse';
    
	catch
    fprintf('Inconsistent data in iteration %5.0f skipped.\n', l);
    end

end

    delete(gcp('nocreate'));
 
 
end
