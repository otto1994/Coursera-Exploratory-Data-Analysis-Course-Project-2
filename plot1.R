setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}
##subset pm by year, cimpute the sums of the Emissions 
subpm <- aggregate(Emissions~year,pm,sum) 

barplot(subpm$Emissions,
        names.arg = subpm$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions(tons)",
        main = "Total Emissions From PM2.5 in the United States",
        col = "blue"
        )
dev.copy(png,file = "plot1.png")
dev.off()