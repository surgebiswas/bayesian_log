function  plot_panel1( t, o, z )
    
    hold on
    mask = t == 0;
    plot(z + log(o), log(t + 1), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 3);
    plot(z(mask) + log(o(mask)), log(t(mask) + 1), 'ob', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
    axis square;
    axis tight
    v = axis;

    plot([-3 12], [-3 12], '-r', 'LineWidth', 1.5);
    plot(z(~mask) + log(o(~mask)), log(t(~mask) + 1), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 3); % replot to cover line.
    axis(v);

    ylabel('log(t_i + 1)', 'FontSize', 20);
    xlabel('lag(t_i) = z_i + log(o_i)', 'FontSize', 20);

    set(gca, 'FontSize', 18);
end

