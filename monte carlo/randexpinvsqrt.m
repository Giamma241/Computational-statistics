function X = randexpinvsqrt(m,n)

% generates X ~ K*exp[-1/sqrt(1-x^2))]


R = m*n;
A = 0.55;
X = zeros(1,R);
reject = (1:R);
a = 2; b = 2;
while R > 0,
   S = -log(rand(a+b,R));
   U = sum(S(1:a,1:R))./sum(S);
   V = 2*U-1;
   X(reject) = V;
   U = rand(size(V));
   f = exp(-1 ./ sqrt(1 - V.^2));     % f(x)
   g = 1 - V.^2;                      % g(x)
   M = 0.55;                          % empirically safe upper bound
   fXoverMgX = f ./ (M * g);          % acceptance ratio
   % Rejection step
   reject = reject(U > fXoverMgX);    % keep only those to retry
   R = length(reject);
end
X = reshape(X,m,n);
