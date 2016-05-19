function [ z, prior, l ] = lag_plus_learn_prior( t, offset, prior )

oldl = -Inf;
del = Inf;

while abs(del) > 1e-6
    [z, l] = lag( t, offset, prior );
    
    prior.mu = mean(z);
    prior.sig2 = var(z);
    del = l - oldl;
    if del < 0; disp(num2str(del)); end
    oldl = l;
    fprintf('%0.4f\t%0.4f\t%0.7f\n', prior.mu, prior.sig2, l) 
end


end

