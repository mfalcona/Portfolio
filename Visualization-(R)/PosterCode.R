# Matthew Falcona
# IST-719
# Final Poster Code

# Aggregating Total Change in Value by Neighborhood

tot_chg_val <- aggregate(pgh_sales_2010$ChgPerYear, by = list(pgh_sales_2010$Neighborhood), FUN = sum)

# Aggregating Total Value by Neighborhood

tot_val <- aggregate(pgh_sales_2010$CurValue, by = list(pgh_sales_2010$Neighborhood), FUN = sum)

# Aggregating Avg % Change / Year by Neighborhood

avg_ann_chg <- aggregate(pgh_sales_2010$PctChgPerYear, by = list(pgh_sales_2010$Neighborhood), FUN = mean)

# Aggregating Value Per Sq Ft by Neighborhood

avg_val_per_sqft <- aggregate(pgh_sales_2010$ValuePerSqFt, by = list(pgh_sales_2010$Neighborhood), FUN = mean)

# Subsetting table for rising property values only

rising_values <- subset.data.frame(pgh_sales_2010, ValueChg > 0)
rising_values$pctChange <- rising_values$ValueChg / rising_values$SALEPRICE

rising_values_by_nbhd <- aggregate(rising_values$pctChange, by = list(rising_values$Neighborhood), FUN = mean)

library(RJSONIO)
library(stringr)
library(rgdal)
library(raster)

pghJSON <- readOGR("http://pghgis-pittsburghpa.opendata.arcgis.com/datasets/a99f25fffb7b41c8a4adf9ea676a3a0b_0.geojson")
plot(pghJSON)

# creating single dimension descriptive plots

boxplot(pgh_sales_2010$CurValue, ylab = "Current Property Value ($)", horizontal = TRUE, col = "darkgray")
boxplot(pgh_sales_2010$ValuePerSqFt, ylab = "Value per Square Foot ($)", horizontal = TRUE, col = "darkgray")

densVal <- density(pgh_sales_2010$CurValue)
plot(densVal, main = "Kernel Density of Current Property Values ($)", xlab = "Property Value ($)")
polygon(densVal, col = "gold", border = "black")

densVpSF <- density(pgh_sales_2010$ValuePerSqFt)
plot(densVpSF, main = "Kernel Density of Value per Square Foot ($)", xlab = "Value per Square Foot ($)")
polygon(densVpSF, col = "gold", border = "black")

# avg rise in property value map

rising_values_by_zip <- aggregate(rising_values$pctChange, by = list(rising_values$PROPERTYZIP), FUN = mean)

# fitting rising values by zip df to zip_choropleth specs

colnames(rising_values_by_zip) <- c("region","value")

# installing necessary packages for choroplethZip

install.packages("devtools")
library(devtools)
install_github('arilamstein/choroplethrZip@v1.5.0', force = TRUE)
install.packages("choroplethrZip")

library(choroplethrZip)

rising_values_by_zip$region <- as.character(rising_values_by_zip$region)

zip_choropleth(rising_values_by_zip,
               title = "Average Rise in Property Values by Zip Code",
               legend = "Percent Rise in Property Value",
               num_colors = 3,
               zip_zoom = rising_values_by_zip$region)

# best value neighborhoods plot

library(ggplot2)

colnames(avg_val_per_sqft) <- c("Neighborhood","AvgValPerSqft")

avg_val_per_sqft <- avg_val_per_sqft[order(avg_val_per_sqft$AvgValPerSqft, decreasing = TRUE),]

avg_val_per_sqft$Neighborhood <- factor(avg_val_per_sqft$Neighborhood,
                                        levels = avg_val_per_sqft$Neighborhood[order(avg_val_per_sqft$AvgValPerSqft, decreasing = TRUE)])

row.names(avg_val_per_sqft) <- 1:nrow(avg_val_per_sqft)

ggplot(avg_val_per_sqft) + aes(x = Neighborhood, y = AvgValPerSqft) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90),
                                                                                                        axis.text.y = element_text(angle = 90))

# rising values by neighborhood plot

colnames(rising_values_by_nbhd) <- c("Neighborhood","AvgPctIncInValue")

rising_values_by_nbhd <- rising_values_by_nbhd[order(rising_values_by_nbhd$Neighborhood, decreasing = TRUE),]

rising_values_by_nbhd$Neighborhood <- factor(rising_values_by_nbhd$Neighborhood,
                                             levels = rising_values_by_nbhd$Neighborhood[order(rising_values_by_nbhd$AvgPctIncInValue, decreasing = TRUE)])                                                     

row.names(rising_values_by_nbhd) <- 1:nrow(rising_values_by_nbhd)

ggplot(rising_values_by_nbhd) + aes(x = Neighborhood, y = AvgPctIncInValue) + geom_bar(stat = 'identity') + theme(axis.text.x = element_text(angle = 90),
                                                                                                                  axis.text.y = element_text(angle = 90))
