setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}

if(!exists("scc")){
  scc <- readRDS("./data/PM2.5/Source_Classification_Code.rds")
}
##Merge data as previous
MergedData <- merge(pm,scc,
                    by.x = "SCC",
                    by.y = "SCC",
                    all = TRUE)
##subset MergedData into cases have motor as part of short names
motorpollutant <- MergedData[
  grep("motor",MergedData$Short.Name,ignore.case = TRUE),
  ]
##aggregate emissions into sum by year
motorpollutantbyyearandfips <- aggregate(Emissions~year+fips,motorpollutant,sum)
##extract the record of LA and BL only
LABL <- motorpollutantbyyearandfips[
  (motorpollutantbyyearandfips$fips == "06037"|motorpollutantbyyearandfips$fips == "24510"),
  ]
##substitute 06037 and 24510 into Los Angeles and Baltimore City
LABL$fips <- sub("06037","Los Angeles",LABL$fips)
LABL$fips <- sub("24510","Baltimore City",LABL$fips)
##make sure LABL$fips is of factor vector
LABL$fips <- factor(LABL$fips)
##create barplot
library(ggplot2)

g <- ggplot(
  data = LABL,
  aes(factor(year),Emissions)
)
##devided by fips
g <- g+
  geom_bar(stat = "identity")+
  facet_grid(.~fips)+
  xlab("Year")+
  ylab("PM2.5 Emissions(tons)")+
  ggtitle("Emissions From Motor Vehicle Sources in Baltimore City and Los Angeles")
g

dev.copy(png, file = "plot6.png")
dev.off()


  
  
  



