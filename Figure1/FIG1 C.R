library(ggplot2)
library(reshape2)

data=read.csv("data.csv")

data2=melt(data, id = 'Genome')

group=read.csv("group.csv")

data3 <- merge(data2, group, by = 'Genome', all.x = TRUE)

p=ggplot(data3, aes(x=value, y=variable, fill=group)) +
  geom_boxplot(outlier.size=0.2,outlier.alpha=0.7)+ scale_x_continuous(limits = c(0, 2))


library(ggpubr)


##计算各组之间的显著性
library(rstatix)
df <- data3 %>% 
    group_by(variable) %>% 
    wilcox_test(value ~ group, detailed = T)

write.csv(df,"generesult.csv")