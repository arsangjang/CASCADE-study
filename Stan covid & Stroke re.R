# visualization of the time series data.
plot(stroke_data$rate[startdate:enddate], type = "l", col = "gray", main ="COVID-19 on stroke hospitalization", xlab ="Date", ylab = "y rate")
abline(v=length(stroke_data$rate[startdate:enddate]) - 100, col="blue", lty = 2, lwd = 3)




library('rstan')

stroke_covid <- stan(
  file = "strokestan.stan",  # Stan program
  data = stroke_data,    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 2000,          # number of warmup iterations per chain
  iter = 52000,            # total number of iterations per chain
  cores = 4,              # number of cores (could use one per chain)
  refresh = 1,             # no progress shown
  control = list(adapt_delta = 0.99)
)