function Runsimulation5b(no_mc, N, k1, ind, no_par)
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

% True value of theta


beta1 = sqrt(0.2);
beta2 = sqrt(0.3);
beta3 = sqrt(0.25);
beta4 = -sqrt(-0.1);
beta5 = sqrt(0.08);
beta6 = -sqrt(0.07);
d = 6;    % The number of parameters
theta = 1; % average treatment effect

Ttheta       = zeros(d,1);
Ttheta(1, 1) = beta1;
Ttheta(2, 1) = beta2;
Ttheta(3, 1) = beta3;
Ttheta(4, 1) = beta4;
Ttheta(5, 1) = beta5;
Ttheta(6, 1) = beta6;

Results = nan(no_mc, 1);
 
parfor l = 1:no_mc
    
    try
        
	% ---------------------------------------------------------------------
    % (1) DGP
    
    fprintf('\nThe %5.0fth iteration\n', l)
    
    x1 = randn(N,1);
    x2 = randn(N,1);
    x3 = randn(N,1);
    x4 = randn(N,1);
    x5 = randn(N,1);
    x6 = randn(N,1);
    x = [x1, x2, x3, x4, x5, x6];
    
    % Generate propensity score with different models (Gfun2.m)
    d = Gfun2(x*Ttheta, ind);
    
    % Generate outcome variable y
    e = randn(N,1);
    y = theta*d + x1 + x2 + x3 + x4 + x5 + e;
    
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
  