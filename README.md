# CASCADE-study: Analysis Stroke outcomes during the COVID-19 pandemic
The objective of this project is to determine the impact of COVID-19 pandemic on troke outcomes in Zanjan province in Iran. This study is a preliminary analysis from one of CASCADE international centers.

Library(ggplot2)
library(rstan)
library(brms)
library(ConsReg)


1-Smooth curve to plot the stroke hospitalization rate: smoothed curve generates trends of total hospitalization rate from Feb 18, 2019 to Jul 18, 2020 in both Ischemic cases and Hemorrhagic stroke for Zanjan Province in Iran. stroke hospitalization trend.R uses this data to generate an trend of stroke hospitalization cases across the Zanjan province.

2-Density plot to compare the distribution of stroke outcomes before and after COVID_19 outbrake 

3- Correlation Matrix to pairwise comparation of stroke outcomes across time period

4- Stan code to determine the effect of COVID-19 on Stroke outcomses
