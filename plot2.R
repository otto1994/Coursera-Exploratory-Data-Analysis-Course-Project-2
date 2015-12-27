setwd("~/Desktop/Ｒ")
if(!exists("pm")){
  pm <- readRDS("./data/PM2.5/summarySCC_PM25.rds")
}
##Subset pm into pm Baltimore,then by year and compute the sum of emissions
pmBaltimore <- pm[pm$fips=="24510",]
subpmBaltimore <- aggregate(Emissions~year,pmBaltimore,sum)
##create barplot
barplot(subpmBaltimore$Emissions,
        names.arg = subpmBaltimore$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions(tons)",
        main = "Total Emissions From PM2.5 in Baltimore",
        col = "purple"
        )
dev.copy(png,file = "plot2.png")
dev.off()
