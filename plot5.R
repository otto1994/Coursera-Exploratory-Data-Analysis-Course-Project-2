setwd("~/Desktop/Ｒ")
scc <- readRDS("./data/PM2.5/Source_Classification_Code.rds")
pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
##Merge data as plot4
MergedData <- merge(pm,scc,
                    by.x = "SCC",
                    by.y = "SCC",
                    all = TRUE)
##Subset into records with "motor" in short names only 
motorpollutant <- MergedData[
  grep("motor",MergedData$Short.Name,ignore.case = TRUE),
  ]
##Subset of Baltimore
motorpollutantBL <- motorpollutant[
  motorpollutant$fips == 24510,
]
##aggregate emissions into sum, by year
motorpollutantbyyear <- aggregate(Emissions~year,motorpollutantBL,sum)
##create barplot
library("ggplot2")
g <- ggplot(data = motorpollutantbyyear,
            aes(factor(year),Emissions)
            )
g <- g+
  geom_bar(stat = "identity")+
  xlab("Year")+
  ylab("PM2.5 Emissions(tons)")+
  ggtitle("Emissions From Motor vehicle Sources in Baltimore City")
g
dev.copy(png,file = "plot5.png")
dev.off()


