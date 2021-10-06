library(ggplot2)
library(reshape2)
data<-read.table("output/parameterTest/SmallMparameter.tsv")
data$M<-3:7
colnames(data)<-c("nLoci","nVariantLoci","coverage","M")

meltedData<-melt(data,id.vars="M")
ggplot(meltedData,aes(y=value,x=M,col=variable))+geom_line()+facet_wrap(.~variable,scales="free_y")+
  ggsave("output/parameterTest/SmallMParameter.png")