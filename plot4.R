setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}

if(!exists("scc")){
  scc <- readRDS("./data/PM2.5/Source_Classification_Code.rds")
}
##Merge pm and scc by "SCC", to reveal the details
MergedData <- merge(pm,scc,
                by.x = "SCC",
                by.y = "SCC",
                all = TRUE)
##Subset MergedData with those record whose short names have somthing to do with coal 
subset <- MergedData[
  grep("Coal",MergedData$Short.Name,ignore.case = TRUE),
  ]
##split subset into SumSubset, compute sum of Emissions, by = year 
SumSubset <- aggregate(Emissions~year,subset,sum)
##create barplot
library("ggplot2")
##need to specify year as a factor vector to make the mark of x axis correct
g <- ggplot(data = SumSubset,
            aes(factor(year),Emissions)
            )
g <- g+
  geom_bar(stat = "identity")+
  xlab("Year")+
  ylab("PM2.5 Emissions(tons)")+
  ggtitle("Emissions From Coal Combustion-Related Sources Across the United States")
g

dev.copy(png,file = "plot4.png")
dev.off()
  
  


