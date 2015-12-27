##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}

if(!exists("scc")){
  scc <- readRDS("./data/PM2.5/Source_Classification_Code.rds")
}


MergedData <- merge(pm,scc,
                    by.x = "SCC",
                    by.y = "SCC",
                    all = TRUE)

motorpollutant <- MergedData[
  grep("motor",MergedData$Short.Name,ignore.case = TRUE),
  ]
motorpollutantbyyearandfips <- aggregate(Emissions~year+fips,motorpollutant,sum)
LABL <- motorpollutantbyyearandfips[
  (motorpollutantbyyearandfips$fips == "06037"|motorpollutantbyyearandfips$fips == "24510"),
  ]

LABL$fips <- sub("06037","Los Angeles",LABL$fips)
LABL$fips <- sub("24510","Baltimore City",LABL$fips)
LABL$fips <- factor(LABL$fips)

library(ggplot2)

g <- ggplot(
  data = LABL,
  aes(factor(year),Emissions)
)
g <- g+
  geom_bar(stat = "identity")+
  facet_grid(.~fips)+
  xlab("Year")+
  ylab("PM2.5 Emissions(tons)")+
  ggtitle("Emissions From Motor Vehicle Sources in Baltimore City and Los Angeles")
g

dev.copy(png, file = "plot6.png")
dev.off()


  
  
  



