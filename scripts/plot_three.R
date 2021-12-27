library(ggplot2)

chart3 <- function(dataset = data) {
  dataset <- dataset %>%
    filter(Date.Of.Death.Year == 2020)
  
  ggplot(data = dataset) +
    geom_col(mapping = aes(x = substr(Start.Date, 1, 2), 
                           y = COVID.19..U071..Underlying.Cause.of.Death.)) +
    ggtitle("COVID-19 as Underlying Cause of Death Rates in 2020") +
    labs(x = "Month", y = "Deaths")
}