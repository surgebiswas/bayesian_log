function plot_panel2(t, o, z, prior )

    hold on
    mask = t == 0;
    d = prior.mu - 4*sqrt(prior.sig2) : 0.01 : prior.mu + 4*sqrt(prior.sig2);
    npdf = @(x) normpdf(x, prior.mu, sqrt(prior.sig2))/normpdf(prior.mu, prior.mu, sqrt(prior.sig2));
    l(1) = plot(d, 50*npdf(d), '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));
    plot([prior.mu, prior.mu], [0 50*npdf(prior.mu)], '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));
    om = o(mask);
    [zs,sidx] = sort(z(mask));
    l(2) = plot(zs, om(sidx), '-ob', 'MarkerFaceColor', 'b', 'MarkerSize', 3, 'LineWidth', 2);
    axis square;
    axis tight
    ylabel('o_i', 'FontSize', 20);
    xlabel('nlag(t_i) = z_i', 'FontSize', 20);
    legend(l, 'prior', 't_i = 0');
    set(gca, 'FontSize', 18);


end

