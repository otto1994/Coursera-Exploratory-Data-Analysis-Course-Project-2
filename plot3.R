setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}
pmBaltimore <- pm[pm$fips=="24510",]

##compute the sum of emissions, by = type+year, data = pmBaltimore
typeBaltimore <- aggregate(Emissions~type+year,pmBaltimore,sum)

library("ggplot2")
##Compare Emissions through years, divided by type into 4, data = subbytypeandyear
g <- ggplot(data = typeBaltimore,
            aes(year,Emissions,color = type)
            )
##Use line graph to describe the relationship of emissions between types 
g <- g+
  geom_line()+
  xlab("Year")+
  ylab("PM2.5 Emissions(tons)")+
  ggtitle("Total Emissions From PM2.5 in Baltimore of Different Types")
g
dev.copy(png,file = "plot3.png")
dev.off()


