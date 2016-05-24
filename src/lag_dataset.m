function z = lag_dataset( t, o )
% t = [samples x objects] table of nonnegative data.
% o = [samples x 1] vector of offsets.

z = zeros(size(t));
for i = 1 : size(t,2)
    prior.mu = mean(log(t(:,i)./o + 1));
    prior.sig2 = var(log(t(:,i)./o + 1));
    [z(:,i), pl] = lag_plus_learn_prior(t(:,i),o,prior);
    
    if mod(i,100) == 0
        disp(i);
    end
end


end

