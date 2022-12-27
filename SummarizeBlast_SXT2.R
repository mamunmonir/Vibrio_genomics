####################################
# SXT_ICE elements_Blast_resutls_plot
####################################
setwd("//Users//monirulmemlab//Manuscripts//Manucript_BD_strains//SXT_ICE")

temp <- list.files(pattern = "*.txt")
length(temp)

SXT_types<-NULL

for (k in 1:length(temp))
{
file<-read.table(temp[k],header=FALSE)
colnames(file)<-c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
types<-unique(file[,1]) # types of SXT
Tlenth_types<-NULL # Total sequence length cover for the types

  for (i in 1:length(types))
  {
   Ltypes<-sum(file[which(file[,1]==types[i]),4]) #Total sequence length cover for each types 
   Tlenth_types<-c(Tlenth_types,Ltypes)
  }

Best_match<-types[which(Tlenth_types==max(Tlenth_types))]
SXT_types<-c(SXT_types,Best_match)
}

SXT_out<-cbind(temp,SXT_types)

write.csv(SXT_out,file="SXT_types.csv")

#############################################

setwd("/Users/monirulmemlab/Research_data/Manuscripts/Manucript_BD_strains/MLST_AND_SXT_ICE")
temp <- list.files(pattern = "*.txt")
length(temp)

SXT_types<-NULL
contigs<-NULL
Large_contig_L<-NULL #large contig length
Total_contig_L<-NULL #total contig length
sstart<-NULL
send<-NULL

for (k in 1:length(temp))
{
  file<-read.table(temp[k],header=FALSE)
  #file<-read.table("ANA876.txt",header=FALSE)
  colnames(file)<-c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")
  types<-unique(file[,1]) # types of SXT
  Tlenth_types<-NULL # Total sequence length cover for the types
  Maxlength_types<-NULL
  
  best_match<-file[which(file[,12]==max(file[,12])),1]
  file_types<-file[which(file[,1]==best_match),]
  best_contig<-file_types[which(file_types[,12]==max(file_types[,12])),2]
  file_types_contigs<-file_types[which(file_types[,2]==best_contig),]
  Ltypes<-sum(file_types_contigs[,4]) #Total sequence length cover for each types for best matched contig
  MLtypes<-max(file_types_contigs[,4])
  
  SXT_types<-c(SXT_types,best_match)
  contigs<-c(contigs, best_contig)
  Large_contig_L<-c(Large_contig_L,MLtypes)
  Total_contig_L<-c(Total_contig_L,Ltypes)
  sstart<-c(sstart,min(file_types_contigs[,9]))
  send<-c(send,max(file_types_contigs[,10]))
}

SXT_out<-cbind(temp,SXT_types,Large_contig_L,Total_contig_L,sstart,send)
#colnames(SXT_out)<-c("ID","SXT_types","Large_contig_L","Total_contig_L","sstrat","send")
write.csv(SXT_out,file="SXT_types3.csv")



