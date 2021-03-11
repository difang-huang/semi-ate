function f = HP(a, index)
% This function only includes the first 10 terms of Hermite polynomials and
% supports matrix calculation. Notice that we have normalise Hermite
% functions with 1/sqrt(factorial(index)). More details can bee seen in
% Peng, Dong and Gao (2014).
% 
% Input:
% a        A scalr or a matrix which will be used to evaluation for Hermite 
%          functions.
% index    Indicating which Hermite polynomial is being used.
% 
% Output:
% f        f(a), where f denotes the corresponding Hermite polynomial 
%          function. 

if index > 10 || index < 0
    error('index = %d is not an integer between 0 and 10', index)
end

if index == 0
    f = ones(size(a));
elseif index == 1
    f = a;
elseif index == 2
    f = a.^2-1;
elseif index == 3
    f = a.^3-3*a;
elseif index == 4
    f = a.^4-6*(a.^2)+3;
elseif index == 5
    f = a.^5-10*(a.^3)+15*a;
elseif index == 6
    f = a.^6-15*(a.^4)+45*(a.^2)-15;
elseif index == 7
    f = a.^7-21*(a.^5)+105*(a.^3)-105*a;
elseif index == 8
    f = a.^8-28*(a.^6)+210*(a.^4)-420*(a.^2)+105;
elseif index == 9
    f = a.^9-36*(a.^7)+378*(a.^5)-1260*(a.^3)+945*a;
elseif index == 10
    f = a.^10-45*(a.^8)+630*(a.^6)-3150*(a.^4)+4725*(a.^2)-945;
else
end

f = (1/sqrt(gamma(index + 1)))*f;

end