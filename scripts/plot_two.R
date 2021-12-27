plot_two <- function(dataframe) {
  # filtering data frame for year 2020 and grouping by sex for # of deaths:
  covid_2020_df <- dataframe %>%
    filter(Date.Of.Death.Year == 2020) %>%
    group_by(Sex) %>%
    summarise(deaths = sum(COVID.19..U071..Underlying.Cause.of.Death.,
                           na.rm = TRUE))
  # using plotly to create pie chart that shows number of deaths and
  # proportions for each category (males & females)
  pie_chart <- plot_ly(
    data = covid_2020_df,
    labels = ~Sex,
    values = ~deaths,
    hoverinfo = "text",
    text = ~ paste("Number of Deaths:", deaths),
    type = "pie"
  ) %>%
    layout(title = "Proportions of COVID-19 Deaths By Sex")
  return(pie_chart)
}