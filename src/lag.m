function [z, l] = lag( t, offset, prior )
% lag - computes latent logarithm, given t, offset (o), and the prior.
%
% t:        column vector of non-negative values (e.g. counts)
% offset:   column vector of positive values the same size as t. This is 'o' from the paper.
% prior:    struct with two fields: 'mu' (the prior mean), and 'sig2' (the prior variance).

z = zeros(size(t));
for i = 1 : size(t,2)
    z(:,i) = learn_z(t(:,i), offset, prior.mu(i), prior.sig2(i));
    
end

l = complete_data_loglike(t, offset, z, prior.mu, prior.sig2);

    function l = complete_data_loglike(t, o, z, mu, s)
        d = t.*z + t.*log(o) - exp(z).*o - log(s)/2 - ((z- mu).^2)/(2*s);
        l = sum(d);
    end

    function z = learn_z(t, offset, mu, s)
        tol = 1e-4;
        del = Inf(size(t,1),1);
        
        z = log(t./offset+0.1)-log(0.1);
        oldf = -Inf(size(t,1),1);
        
        active = true(size(t,1),1);
        f = zeros(size(active));
        g = f;
        H = f;
        while max(del) > tol
            [f(active),g(active),H(active)] = zfun(z(active), t(active), mu, s, offset(active));
            
            del(active) = f(active) - oldf(active);
            oldf(active) = f(active);
            z(active) = z(active) - g(active)./H(active);
            active = del > tol;
            
            if false; disp(sum(active)); end
        end
    end

end

