function y = Gfun2(x, ind)
% =====================================================================
% This function provides different link functions for the Section 4 of Monte
% Carlo Studies
% =====================================================================

if ind == 1
    yhat = exp(sin(x))./(1+exp(sin(x)));  
    y = binornd(1,yhat);
elseif ind == 2
    yhat = exp(0.5*(x.^3-x))./(1+exp(0.5*(x.^3-x))) ; 
    y = binornd(1,yhat);
elseif ind == 3
    u = randn(size(x,1), 1);
    y = x + u >0; 
elseif ind == 4
	u = randn(size(x,1), 1);
    y = x + x.^2 + x.^3 + u >0; 
end


end

