library(dplyr)
library(ggplot2)

plot_one <- function(dataframe) {
  twentytwenty_deaths <- dataframe %>%
    filter(Date.Of.Death.Year == 2020) %>%
    group_by(AgeGroup) 
  #filtered data frame to only include 2020 data and grouped everything by age 
  #group.
  scatterplot_age_covid <- ggplot(data = twentytwenty_deaths) +
    geom_point(mapping = aes(x = AgeGroup, 
                             y = COVID.19..U071..Underlying.Cause.of.Death.)) +
    ggtitle("Number of Covid Deaths per Age Group") +
    theme(axis.text.x = element_text(angle =60, hjust = 1)) +
    labs(x = "Age Groups", y = "Covid Deaths")
  #Created scatterplot with x axis as age groups, y axis as Covid deaths. 
  #I added the title of the graph and the axes. Also spaced out the 
  #X axis labels. 
  return(scatterplot_age_covid)
}
  

