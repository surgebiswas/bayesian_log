function [z, priors] = lag_dataset( t, o, varargin )
% t = [samples x objects] table of nonnegative data.
% o = [samples x 1] vector of offsets.

priors = setParam(varargin, 'priors', cell(1, size(t,2)));

z = zeros(size(t));

for i = 1 : size(t,2)
    
    if isempty(priors{i})
        prior.mu = mean(log(t(:,i)./o + 1));
        prior.sig2 = var(log(t(:,i)./o + 1));
        [z(:,i), priors{i}] = lag_plus_learn_prior(t(:,i),o,prior);
    else
        z(:,i) = lag(t(:,i), o, priors{i});
    end
    
    if mod(i,100) == 0
        disp(i);
    end
end


end


