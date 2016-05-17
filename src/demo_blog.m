clear;
rng('default');
cd('~/GitHub/bayesian_log'); % Change accordingly
path(genpath(pwd), path);

% Load the data.
load('AT2G43386.mat'); % t and o in memory.

% Define the prior.
% These values were actually those found from an independent set of samples
% measured for this gene.
prior.mu = 0.2554;
prior.sig2 = 0.048;

% Create some fake data to see how z behaves in the case of truly limiting data.
osyn = logspace(1,-4,20)';
tsyn = zeros(length(osyn),1);


z = blog(t, o, prior);
zsyn = blog(tsyn,osyn,prior);


% Generate plots
d = prior.mu - 4*sqrt(prior.sig2) : 0.01 : prior.mu + 4*sqrt(prior.sig2);
npdf = @(x) normpdf(x, prior.mu, sqrt(prior.sig2))/normpdf(prior.mu, prior.mu, sqrt(prior.sig2));
mask = t == 0;

% z vs observed.
subplot(1,3,1)
hold on
plot(d, 2*npdf(d) + log(0.1), '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));

plot(z, log(t./o + 0.1), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 3);
plot(z(mask), log(t(mask)./o(mask) + 0.1), 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
axis square;
axis tight
v = axis;

plot([-3 6], [-3 6], '-r', 'LineWidth', 1.5);
plot(z(~mask), log(t(~mask)./o(~mask) + 0.1), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 3); % replot to cover line.
axis(v);

ylabel('log(t_i/o_i + 0.1)', 'FontSize', 20);
xlabel('z_i', 'FontSize', 20);

set(gca, 'FontSize', 18);



% offset vs z for t == 0
subplot(1,3,2);
hold on
plot(d, 50*npdf(d), '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));
plot([prior.mu, prior.mu], [0 50*npdf(prior.mu)], '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));
om = o(mask);
[zs,sidx] = sort(z(mask));
l = plot(zs, om(sidx), '-ob', 'MarkerFaceColor', 'b', 'MarkerSize', 3, 'LineWidth', 2);
axis square;
axis tight
ylabel('o_i', 'FontSize', 20);
xlabel('z_i', 'FontSize', 20);
legend(l, 't_i = 0');
set(gca, 'FontSize', 18);




% offset vs z for t == 0. synthetic data to confirm limiting behavior.
subplot(1,3,3);
hold on
plot(d, 4*npdf(d), '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));
plot([prior.mu, prior.mu], [0 4*npdf(prior.mu)], '-', 'LineWidth', 2, 'Color', 0.5*ones(1,3));

l = plot(zsyn, osyn, '-ob', 'MarkerFaceColor', 'b', 'MarkerSize', 3, 'LineWidth', 2);
axis square;
axis tight
ylabel('o_i', 'FontSize', 20);
xlabel('z_i', 'FontSize', 20);
legend(l, 't_i = 0');
set(gca, 'FontSize', 18);

plotSave('paper/figure1.png');
close
