x = linspace(-0.999, 0.999, 1000);  % Avoid division by zero at edges
f = @(x) exp(-1 ./ sqrt(1 - x.^2));
g = @(x) 1 - x.^2;

fx = f(x);
gx = g(x);
ratio = fx ./ gx;

% Find sup of f(x)/g(x)
M_ratio = max(ratio);

% Assume K and L are normalisation constants
% For the plot, set K = L = 1 (you can rescale later)
K = 1; L = 1;
M = (K/L) * M_ratio;

% Plotting
figure;
plot(x, fx, 'r-', 'LineWidth', 2); hold on;
plot(x, M * gx, 'b--', 'LineWidth', 2);
legend('f_X(x)', 'M \cdot g_X(x)');
title(['Visual bounding: M = ', num2str(M)]);
xlabel('x'); ylabel('Density');
grid on;

