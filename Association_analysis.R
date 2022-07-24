setwd("E:\\Manuscripts\\Manuscript3\\GWAS")
require(foreign)
require(nnet)
require(ggplot2)
require(reshape2)

data<-read.csv("ANA_vibrio_1084selected_2.csv", header=TRUE)
IID<-names(data)
Lineages<-read.csv("Strains_lineages.csv", header=TRUE)
SNPs<-data$SNP


LineageName<-unique(Lineages[,2])

Strains<-NULL

for(i in 1:length(Lineages$Strain))
{
	id<- which(IID==Lineages$Strain[i])
	Strains<-c(Strains,id)
}

data2<-data[,Strains]

data3<-t(data2)
data3<-cbind(Lineages,data3)
data3$Lineage

BD<-NULL
Var<-data3

snp<-as.factor(Var[,5434])
fq_alt<-as.data.frame(prop.table(table(Var[,2],snp)))
fq_alt[which(fq_alt[,2]==1),][,3]

z<-chisq.test(Var[,2],snp)

pvalue<-NULL
Freq<-NULL

	for(k in 1:(length(Var[1,])-2))
	{
	snp<-as.factor(Var[,k+2])
	tt<-unique(Var[,k+2])
		if(length(tt)==1){
		pvalue<-c(pvalue,-9)
		}else{
		z <- chisq.test(Var[,2],snp)
		pvalue<-c(pvalue,z$p.value)
		}
	fq_alt<-as.data.frame(table(Var[,2],snp))
	fq<-fq_alt[which(fq_alt[,2]==1),][,3]
	if(length(fq)==15){
	Freq<-rbind(Freq,fq)}else{
	Freq<-rbind(Freq,c(rep(0,15)))
	}
	}

Results<-cbind(Freq,pvalue)
write.csv(Results, file="Results_chi2up.csv")

data<-read.csv("Lineage_fq2snp.csv",header=TRUE)

data2<-data[,-c(1,2)]
rownames(data2)<-data[,1]

if (!require("gplots")) {
   install.packages("gplots", dependencies = TRUE)
   library(gplots)
   }
if (!require("RColorBrewer")) {
   install.packages("RColorBrewer", dependencies = TRUE)
   library(RColorBrewer)
   }


mat_data<-data2


my_palette <- colorRampPalette(c("green", "yellow", "red"))(n = 299)

# (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(0,33,length=100),  # for green
  seq(34,67,length=100),           # for yellow
  seq(68,100,length=100))             # for red

tiff(filename = "SNP_plot.tiff",
     width = 15, height = 20, units = "in", pointsize = 12,
     compression = c("lzw"),
     bg = "white", res = 300)

heatmap.2(data.matrix(mat_data),
  main = "Correlation", # heat map title
  notecol="black",      # change font color of cell labels to black
  density.info="none",  # turns off density plot inside color legend
  trace="none",         # turns off trace lines inside the heat map
  margins =c(12,9),     # widens margins around plot
  col=my_palette,       # use on color palette defined earlier
  breaks=col_breaks,    # enable color transition at specified limits
  dendrogram="row",     # only draw a row dendrogram
  Colv="NA")            # turn off column clustering

dev.off()               # close the PNG device


distance = dist(mat_data, method = "manhattan")
cluster = hclust(distance, method = "ward")



setwd("E:\\Manuscripts\\Manuscript3\\GWAS")

data<-read.csv("AMR.csv",header=TRUE)

data2<-data[,-c(1)]
rownames(data2)<-data[,1]

if (!require("gplots")) {
   install.packages("gplots", dependencies = TRUE)
   library(gplots)
   }
if (!require("RColorBrewer")) {
   install.packages("RColorBrewer", dependencies = TRUE)
   library(RColorBrewer)
   }


mat_data<-data2


my_palette <- colorRampPalette(c("green", "yellow", "red"))(n = 299)

# (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(0,33,length=100),  # for green
  seq(34,67,length=100),           # for yellow
  seq(68,100,length=100))             # for red

tiff(filename = "AMR_plot.tiff",
     width = 8, height = 10, units = "in", pointsize = 12,
     compression = c("lzw"),
     bg = "white", res = 300)

heatmap.2(data.matrix(mat_data),
  main = "Correlation", # heat map title
  notecol="black",      # change font color of cell labels to black
  density.info="none",  # turns off density plot inside color legend
  trace="none",         # turns off trace lines inside the heat map
  margins =c(12,9),     # widens margins around plot
  col=my_palette,       # use on color palette defined earlier
  breaks=col_breaks,    # enable color transition at specified limits
  dendrogram="row",     # only draw a row dendrogram
  Colv="NA")            # turn off column clustering

dev.off()               # close the PNG device


