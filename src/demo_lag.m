clear;
rng('default');
cd('~/GitHub/latent_log'); % Change accordingly
path(genpath(pwd), path);

% Load the data.
% t, t2, and o in memory. 
% t and t2 are the TPM abundances for the 'rare' and 'abundant' gene respectively.
% o contains the TPM offsets.
load('AT2G43386_AT1G14630.mat'); 


% Figure 1 code
if true
    % Define the prior.
    % These values were actually those found from an independent set of samples
    % measured for this gene.
    prior.mu = 0.25;
    prior.sig2 = 0.05;
    z = lag(t, o, prior);


    % Create some fake data to see how z behaves in the case of truly limiting data.
    osyn = logspace(1,-6,20)';
    tsyn = zeros(length(osyn),1);
    zsyn = lag(tsyn,osyn,prior);


    % Generate plots
    d = prior.mu - 4*sqrt(prior.sig2) : 0.01 : prior.mu + 4*sqrt(prior.sig2);
    npdf = @(x) normpdf(x, prior.mu, sqrt(prior.sig2))/normpdf(prior.mu, prior.mu, sqrt(prior.sig2));

    % z vs observed.
    figure;
    subplot(1,3,1)
    plot_panel1(t,o,z);


    % offset vs z for t == 0
    subplot(1,3,2);
    hold on
    plot_panel2(t,o,z,prior);



    % offset vs z for t == 0. synthetic data to confirm limiting behavior.
    subplot(1,3,3);
    hold on
    l(1) = plot(d, 4*npdf(d), '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));
    plot([prior.mu, prior.mu], [0 4*npdf(prior.mu)], '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));

    l(2) = plot(zsyn, osyn, '-ob', 'MarkerFaceColor', 'b', 'MarkerSize', 3, 'LineWidth', 2);
    axis square;
    axis tight
    ylabel('o_i', 'FontSize', 20);
    xlabel('nlag(t_i) = z_i', 'FontSize', 20);
    legend(l, 'prior', 't_i = 0');
    set(gca, 'FontSize', 18);


    plotSave('paper/figure1.png');
    close
end

% Figure 2 code
if true
    % initialize prior to pseudocount.
    
    % Rare gene.
    prior.mu = mean(log(t./o + 1)); 
    prior.sig2 = var(log(t./o + 1));
    [ z, pl, l ] = lag_plus_learn_prior( t, o, prior );
    
    figure;
    subplot(1,2,1)
    plot_panel1(t,o,z);
    subplot(1,2,2);
    plot_panel2(t,o,z,pl);
    plotSave('paper/figure2.png');
    close;
    
    
    % Abundant gene.
    prior2.mu = mean(log(t2./o + 1)); 
    prior2.sig2 = mean(log(t2./o + 1));
    [ z2, pl2, l2 ] = lag_plus_learn_prior( t2, o, prior2 );
    
    figure;
    subplot(1,2,1)
    plot_panel1(t2,o,z2);
    subplot(1,2,2);
    plot_panel2(t2,o,z2,pl2);
    plotSave('paper/figure3.png');
    close;
    
    
    
    
    

end
