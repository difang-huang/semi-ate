function f = objfun(beta,y,x)

f = -mean(y.*(x*beta) - log(1+exp(x*beta)));

end

