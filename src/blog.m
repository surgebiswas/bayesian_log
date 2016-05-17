function z = blog( t, offset, prior )
% t is tpm table, sample x genes.
% prior is a struct output from naive_latent_abund_learn_prior

z = zeros(size(t));
for i = 1 : size(t,2)
    z(:,i) = learn_z(t(:,i), offset, prior.mu(i), prior.sig2(i));
    
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

