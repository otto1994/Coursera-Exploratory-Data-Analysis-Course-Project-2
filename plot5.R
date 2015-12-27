setwd("~/Desktop/Ｒ")
scc <- readRDS("./data/PM2.5/Source_Classification_Code.rds")
pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")

MergedData <- merge(pm,scc,
                    by.x = "SCC",
                    by.y = "SCC",
                    all = TRUE)
motorpollutant <- MergedData[
  grep("motor",MergedData$Short.Name,ignore.case = TRUE),
  ]
motorpollutantBL <- motorpollutant[
  motorpollutant$fips == 24510,
]
motorpollutantbyyear <- aggregate(Emissions~year,motorpollutantBL,sum)

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


