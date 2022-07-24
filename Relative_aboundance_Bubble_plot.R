setwd("E:\\Manuscripts\\Manuscript3")
data<-read.csv("strains_count_lineage.csv",header=TRUE)
library(ggplot2)
library(reshape2)

pcm = melt(data, id = c("Year"))
colours = c( "#2986cc",  "#0FFF50", "#8fce00", "#4CBB17","#ff0000")
pcm$Year <- factor(pcm$Year,levels=unique(pcm$Year))

xx = ggplot(pcm, aes(x = Year, y = variable)) + 
  geom_point(aes(size = value, fill = variable), alpha = 0.75,  shape = 21) + 
  scale_size_continuous(limits = c(0.000001, 100), range = c(1,17), breaks = c(1,10,50,75)) + 
  labs( x= "", y = "", size = "Relative frequency (%)", fill = "black")  + 
  theme(legend.key=element_blank(), 
  axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
  axis.text.y = element_text(colour = "black", face = "bold", size = 11), 
  legend.text = element_text(size = 10, face ="bold", colour ="black"), 
  legend.title = element_text(size = 12, face = "bold"), 
  panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
  legend.position = "right") +  
  scale_fill_manual(values = colours, guide = FALSE) + 
  scale_y_discrete(limits = rev(levels(pcm$variable))) 

tiff(filename = "Relative_aboundance_3.tif",
     width = 12, height = 5, units = "in", pointsize = 12,
     compression = c("lzw"),
     bg = "white", res = 300)
xx

dev.off()