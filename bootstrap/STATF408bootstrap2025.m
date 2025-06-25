
screensize = get(0,'screensize');
figwidth0 = screensize(3); figsize = [figwidth0 420];
papersize = figsize/96; figpaperpos = [0 0 papersize];
if exist('samplesize') ~= 1, samplesize = 20; end
if exist('realrandom') ~= 1, realrandom = false; end
if realrandom==false, randn('state',0); rand('state',0); end
n = samplesize; % samplesize
ns = 1000; % number of samples

M = 3;
p = rand(1,M);
r = 2.3;
X = zeros(n,ns);
for m=1:M, X = X+randnegbin(size(X),p(m),r); end
d = sum((1./p).*(1./p-1))/sum(1./p-1);
mu = r*sum(1./p-1);

B = 10000;
tstaralfa = zeros(ns,2);
ustaralfa = zeros(ns,2);
alfa = 0.05;
qq = round([alfa/2 1-alfa/2]*B);
muhat = mean(X); T = muhat';
S = sqrt(muhat'*d);
% Main bootstrap loop
for s=1:ns
    Xs = X(:,s);
    % Generate B bootstrap samples of size n
    r_idx = ceil(rand(n,B)*n);
    Xstar = Xs(r_idx);

    % --- Basic Bootstrap ---
    muhatstar_vec = mean(Xstar);
    mustar = T(s); % This is mu_hat for the s-th sample
    tstaralfa(s,:) = quantile(muhatstar_vec, [alfa/2, 1-alfa/2]);

    % --- Bootstrap-t ---
    % Standard error for each bootstrap sample mean
    Sstar = sqrt(muhatstar_vec * d / n);
    % Bootstrap-t statistic (avoid division by zero)
    Sstar(Sstar < 1e-6) = 1e-6;
    Ustar = (muhatstar_vec - mustar) ./ Sstar;
    % Quantiles of the t-statistic
    ustaralfa(s,:) = quantile(Ustar, [alfa/2, 1-alfa/2]);
end

% Construct Confidence Intervals
basicCI = [2*T - tstaralfa(:,2), 2*T - tstaralfa(:,1)];
bootstraptCI = [T - ustaralfa(:,2).*S, T - ustaralfa(:,1).*S];

figure(1)
[i1 b1] = plotasblocks(basicCI(1:ns,1));
[i2 b2] = plotasblocks(basicCI(1:ns,2));
nn = length(i2);
ii = [i1; i2(nn:-1:1)];
bb = [b1; b2(nn:-1:1)];
fill(ii,bb,'y')
hold on
plotasblocks(T,'k')
plot([1 ns],[mu mu],'r')
hold off
figpos = get(gcf,'position'); figpos(3:4) = figsize;
set(gcf,'position',figpos,'papersize',papersize,'paperposition',figpaperpos)

figure(2)
[i1 b1] = plotasblocks(bootstraptCI(1:ns,1));
[i2 b2] = plotasblocks(bootstraptCI(1:ns,2));
nn = length(i2);
ii = [i1; i2(nn:-1:1)];
bb = [b1; b2(nn:-1:1)];
fill(ii,bb,[1 0.7 1])
hold on
plotasblocks(T,'k')
plot([1 ns],[mu mu],'r')
hold off
figpos = get(gcf,'position'); figpos(3:4) = figsize;
set(gcf,'position',figpos,'papersize',papersize,'paperposition',figpaperpos)

coverbasicCI = sum((basicCI(1:ns,1)<mu)&(mu<basicCI(1:ns,2)))/ns
coverbootstraptCI = sum((bootstraptCI(1:ns,1)<mu)&(mu<bootstraptCI(1:ns,2)))/ns
widthbasicCI = basicCI(1:ns,2)-basicCI(1:ns,1);
widthbootstraptCI = bootstraptCI(1:ns,2)-bootstraptCI(1:ns,1);
meanwidthbasicCI = mean(widthbasicCI)
meanwidthbootstraptCI = mean(widthbootstraptCI)
