/*Stan file for Tourist Visits Data*/


functions {
}
data {
  int<lower=1> N;  // number of observations
  vector[N] Y;  // response variable
  int<lower=1> K;  // number of population-level effects
  matrix[N, K] X;  // population-level design matrix
  // data needed for ARMA correlations
  int<lower=0> Kar;  // AR order
  int<lower=0> Kma;  // MA order
  // number of lags per observation
  int<lower=0> J_lag[N];
  int prior_only;  // should the likelihood be ignored?
}
transformed data {
  int Kc = K - 1;
  matrix[N, Kc] Xc;  // centered version of X without an intercept
  vector[Kc] means_X;  // column means of X before centering
  int max_lag = max(Kar, Kma);
  for (i in 2:K) {
    means_X[i - 1] = mean(X[, i]);
    Xc[, i - 1] = X[, i] - means_X[i - 1];
  }
}
parameters {
  vector[Kc] b;  // population-level effects
  real Intercept;  // temporary intercept for centered predictors
  vector[Kar] ar;  // autoregressive coefficients
  real<lower=0> sigma;  // residual SD
}
transformed parameters {
}
model {
  // objects storing residuals
  matrix[N, max_lag] Err = rep_matrix(0, N, max_lag);
  vector[N] err;
  // initialize linear predictor term
  vector[N] mu = Intercept + Xc * b;
  // include ARMA terms
  for (n in 1:N) {
    err[n] = Y[n] - mu[n];
    for (i in 1:J_lag[n]) {
      Err[n + 1, i] = err[n + 1 - i];
    }
    mu[n] += Err[n, 1:Kar] * ar;
  }
  // priors including all constants
  target += student_t_lpdf(Intercept | 3, 0.1, 2.5);
  target += student_t_lpdf(sigma | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
  // likelihood including all constants
  if (!prior_only) {
    target += normal_lpdf(Y | mu, sigma);
  }
}
generated quantities {
  // actual population-level intercept
  real b_Intercept = Intercept - dot_product(means_X, b);
}