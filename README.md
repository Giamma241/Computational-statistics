# Computational-statistics

## Introduction

This reporsitory summarizes some statistica application regarding the following topics:
- Model selection in GLM model (Poisson regression)
- Information criteria
- High dimensional model selection
- Bootstrap
- Random number generator (Monte Carlo)

## Project Architecture

The structure is crafted to guide every data science professional and enthusiast through a streamlined workflow, right from raw data ingestion to deployment of the final model API. The project's folder structure would look like this:

```bash
.
├── bootstrap
│
├── high dimensional model selection
│
├── information criteria
│
├── model selection glm
│
├── monte carlo
│
├── figures
│
├── Report.pdf
│
└── README.md

## Getting Started

Model selection in GLM model - Poisson regression

```matlab
clear; samplesize = 100; simulatePoissonregression
print -dpng fig_glm_n100.png
clear; samplesize = 1000; simulatePoissonregression
print -dpng fig_glm_n1000.png
clear; samplesize = 10000; simulatePoissonregression
print -dpng fig_glm_n10000.png
clear; samplesize = 50000; simulatePoissonregression
print -dpng fig_glm_n50000.png

Information criteria

```matlab
clear; samplesize = 30; STATF408simulationsIC2025
print(1, '-dpng', 'fig1_ic_n30.png')  % true vs observed
print(2, '-dpng', 'fig2_ic_n30.png')  % PE, squared diff, Cp
print(3, '-dpng', 'fig3_ic_n30.png')  % best fit
print(4, '-dpng', 'fig4_ic_n30.png')  % KL vs AIC/BIC
clear; samplesize = 100; STATF408simulationsIC2025
print(1, '-dpng', 'fig1_ic_n100.png')  % true vs observed
print(2, '-dpng', 'fig2_ic_n100.png')  % PE, squared diff, Cp
print(3, '-dpng', 'fig3_ic_n100.png')  % best fit
print(4, '-dpng', 'fig4_ic_n100.png')  % KL vs AIC/BIC
clear; samplesize = 1000; STATF408simulationsIC2025
print(1, '-dpng', 'fig1_ic_n1000.png')  % true vs observed
print(2, '-dpng', 'fig2_ic_n1000.png')  % PE, squared diff, Cp
print(3, '-dpng', 'fig3_ic_n1000.png')  % best fit
print(4, '-dpng', 'fig4_ic_n1000.png')  % KL vs AIC/BIC
clear; samplesize = 10000; STATF408simulationsIC2025
print(1, '-dpng', 'fig1_ic_n10000.png')  % true vs observed
print(2, '-dpng', 'fig2_ic_n10000.png')  % PE, squared diff, Cp
print(3, '-dpng', 'fig3_ic_n10000.png')  % best fit
print(4, '-dpng', 'fig4_ic_n10000.png')  % KL vs AIC/BIC

High dimensional model selection

```matlab
clear; samplesize = 400; fullmodelsize = 2000; illustrateHigDim202503
print -dpng fig_hd_PE_Cp_curves.png
plot(beta, 'r', 'linewidth', 1); hold on; plot(betahat, 'b'); hold off
print -dpng fig_hd_beta_compare.png
plot(mu, 'r', 'linewidth', 1); hold on; plot(muhat, 'b'); hold off
print -dpng fig_hd_mu_compare.png
plot(kappa, log(lambda), 'b', 'linewidth', 1)
print -dpng fig_hd_lambda_path.png
checkKKT = X' * (Y - mean(Y) - X * betahat);
plot(checkKKT(Sopt), 'b', 'linewidth', 1); hold on;
Sprime = setdiff(1:m, Sopt);
plot(checkKKT(Sprime), 'r', 'linewidth', 1); hold off
print -dpng fig_hd_KKT.png
[~, idx_cp_min] = min(Cp1);
[~, idx_pe_min] = min(samplePE1);
lambda_cp = lambda(idx_cp_min);
lambda_pe = lambda(idx_pe_min);
fprintf('Lambda at Cp minimum: %.4f\n', lambda_cp);
fprintf('Lambda at PE minimum: %.4f\n', lambda_pe);

Bootstrap

```matlab
clear; samplesize = 20; STATF408bootstrap2025
print(1, '-dpng', 'fig1_bootstrap_n20.png')
print(2, '-dpng', 'fig2_bootstrap_t_n20.png')
clear; samplesize = 50; STATF408bootstrap2025
print(1, '-dpng', 'fig1_bootstrap_n50.png')
print(2, '-dpng', 'fig2_bootstrap_t_n50.png')
clear; samplesize = 100; STATF408bootstrap2025
print(1, '-dpng', 'fig1_bootstrap_n100.png')
print(2, '-dpng', 'fig2_bootstrap_t_n100.png')


Random number generator (Monte Carlo) - Part 1

```matlab
X = randexpinvsqrt(1, 1e5);  % Generate 100,000 samples
mu_hat = mean(X);
var_hat = var(X);  % Unbiased estimate of Var(X)
nbins = 100;  % number of bins
[counts, centers] = hist(X, nbins);
bar(centers, counts / trapz(centers, counts));  % normalize to approximate density
xlabel('x');
ylabel('Density');
title('Histogram of samples from f_X(x)');
print -dpng fig_mc_hist.png


Random number generator (Monte Carlo) - Part 2

```matlab
clear; studentnumber = 12345; dimension = 2; simulateGibbssamplerN2025
```