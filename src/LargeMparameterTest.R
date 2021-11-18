library(ggplot2)
library(reshape2)
args = commandArgs(trailingOnly=TRUE)

data<-read.table(paste0(args[1],"/LargeMparameter.tsv"))
data$M<-1:8
colnames(data)<-c("nLoci","nVariantLoci","coverage","M")

meltedData<-melt(data,id.vars="M")
ggplot(meltedData,aes(y=value,x=M,col=variable))+geom_line()+facet_wrap(.~variable,scales="free_y")+
  ggsave(paste0(args[1],"/LargeMparameter.png"))