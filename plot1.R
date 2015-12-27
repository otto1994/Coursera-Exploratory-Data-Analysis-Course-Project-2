setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}
##subset pm by year, compute the sums of the Emissions 
subpm <- aggregate(Emissions~year,pm,sum) 
##Since we care most about emissions over years, which is actually one dimensional, use barplot
barplot(subpm$Emissions,
        names.arg = subpm$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions(tons)",
        main = "Total Emissions From PM2.5 in the United States",
        col = "blue"
        )
dev.copy(png,file = "plot1.png")
dev.off()