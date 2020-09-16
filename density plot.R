
##density ridges plot

ggplot(stroke_data, aes(x =x , y=period, fill=period))+
  geom_density_ridges_gradient(quantile_lines = TRUE, quantiles = c(0.5, 0.25, 0.75),rel_min_height = .001) +
  scale_fill_viridis_d (alpha = 1)+xlab(expression(""))+ ylab("")+theme_bw()+
  theme(axis.title.x = element_text(face='bold',size=10,hjust=.5),
        axis.title.y = element_text(face='bold',size=10,vjust=.1,hjust=.5),
        axis.text.x = element_text(size=8, angle = 0, color='gray18'),
        axis.text.y = element_text(face=2,size=6,color='black', angle = 45),
        legend.text = element_text(face="bold", color="black", size=8),
        legend.position = "FALSE",legend.background = element_rect(fill="gray100"),
        legend.title = element_blank(),
        strip.text = element_text(),
        strip.background = element_rect(fill="lightblue1",size=.5),
        strip.text.x = element_text(size = 8, color = "black", face ="bold"))
