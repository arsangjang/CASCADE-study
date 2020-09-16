stroke_hospitalization <- ggplot(data=stroke_data, aes(x = Date, y = hospitalization_rate, group=1)) +
  geom_line(aes(x = Date, y = hospitalization_rate), colour="#F0E442",size=0.5) +
  geom_vline(xintercept =as.Date("2020-02-17"),linetype="dashed",col="red", size=0.55)+
  geom_point(shape=21, color="black", fill="#69b3a2", size=2)+
  geom_smooth(aes(x = Date, y = hospitalization_rate),method = 'loess',fill="lightblue1", level = .99,colour="red", linetype="dashed", size=0.5)+
  geom_text(aes(label = hospitalization_rate), position = position_dodge(width = 0.15),hjust=1, vjust=1.45, angle = 45, color = "gray20", size=1.75)+
  labs(x="Date (week)", y = "Stroke hospitalization rate: Total stroke (per 100000)")+
  theme_bw ()+
  theme(axis.title.x = element_text(face='bold',size=8,angle = 0, hjust=.5),
        axis.title.y = element_text(face=2,size=6,vjust=1),
        axis.text.x = element_text(face=1,size=6,color='black', angle = 45, hjust = 1 ),
        axis.text.y = element_text(face=1,size=6,color='black'),
        legend.text = element_text(face=1, color="black", size=5),
        legend.position = "FALSE",legend.background = element_rect(fill=FALSE),legend.title = element_blank(),
        legend.key.width = unit(0.35,"cm"),legend.key.height = unit(0.35,"cm"),
        strip.text = element_text(),
        strip.background = element_rect(fill="khaki",size=.1),
        strip.text.x = element_text(size = 4, color = "black", face =2))

S_H_trend <- stroke_hospitalization +scale_x_date(date_breaks = "3 week")+
  annotate(geom="text",x=as.Date("2020-03-16"),y=0.3,label="First case of\n COVID-19",fontface=2,colour="red",size=2.25)
