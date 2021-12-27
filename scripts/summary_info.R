get_summary_info <- function(dataframe) {
  # Create an empty list to store the results
  result <- list()

  # Create a new column of total COVID death to be used in later calculation
  dataframe$covid_deaths <- (dataframe$COVID.19..U071..Multiple.Cause.of.Death +
                          dataframe$COVID.19..U071..Underlying.Cause.of.Death.)

  # Get the total covid deaths in 2019
  result$year_2019_covid_deaths <- dataframe %>%
    group_by(Date.Of.Death.Year) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(Date.Of.Death.Year == "2019") %>%
    pull(total_covid_deaths)

  # Get the total covid deaths in 2020
  result$year_2020_covid_deaths <- dataframe %>%
    group_by(Date.Of.Death.Year) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(Date.Of.Death.Year == "2020") %>%
    pull(total_covid_deaths)

  # Get the total deaths for all causes in 2020 in order to calculate
  # for percentage
  death_total_2020 <- dataframe %>%
    group_by(Date.Of.Death.Year) %>%
    summarize(AllCause = sum(AllCause, na.rm = TRUE)) %>%
    filter(Date.Of.Death.Year == "2020") %>%
    pull(AllCause)

  # Get the percentage of covid death in 2020
  result$covid_death_percent_2020 <- round(result$year_2020_covid_deaths
                                    / death_total_2020, 2) * 100

  # Get the month with the most covid death
  result$month_with_max_covid_death <- dataframe %>%
    filter(Date.Of.Death.Year == "2020") %>%
    group_by(Date.Of.Death.Month) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(total_covid_deaths == max(total_covid_deaths, na.rm = TRUE)) %>%
    pull(Date.Of.Death.Month)

  # Get the number of covid deaths for the month with most covid death
  result$max_covid_death_month <- dataframe %>%
    filter(Date.Of.Death.Year == "2020") %>%
    group_by(Date.Of.Death.Month) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(Date.Of.Death.Month == result$month_with_max_covid_death) %>%
    pull(total_covid_deaths)

  # Get age group with the largest number of covid deaths
  result$age_with_most_covid_deaths <- dataframe %>%
    filter(Date.Of.Death.Year == "2020") %>%
    group_by(AgeGroup) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(total_covid_deaths == max(total_covid_deaths, na.rm = TRUE)) %>%
    pull(AgeGroup)

  # Get the covid deaths that are with underlying medical conditions
  # in order to calculate for percentage
  underlying_condition_death <- dataframe %>%
    group_by(Date.Of.Death.Year) %>%
    summarize(deaths_underlying_condition = sum
              (COVID.19..U071..Multiple.Cause.of.Death., na.rm = TRUE)) %>%
    filter(Date.Of.Death.Year == "2020") %>%
    pull(deaths_underlying_condition)

  # Calculate the covid death rate that are with underlying medical conditions
  result$underlying_con_rate <- round(underlying_condition_death /
                                 result$year_2020_covid_deaths, 2) * 100

  # Get the race/ethnicity with the largest number of covid deaths
  result$race_with_most_covid_deaths <- dataframe %>%
    filter(Date.Of.Death.Year == "2020") %>%
    group_by(Race.Ethnicity) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(total_covid_deaths == max(total_covid_deaths, na.rm = TRUE)) %>%
    pull(Race.Ethnicity)

  # Get the number of covid deaths for race with largest number of covid deaths
  result$most_covid_deaths_for_race <- dataframe %>%
    filter(Date.Of.Death.Year == "2020") %>%
    group_by(Race.Ethnicity) %>%
    summarize(total_covid_deaths = sum(covid_deaths, na.rm = TRUE)) %>%
    filter(Race.Ethnicity ==  result$race_with_most_covid_deaths) %>%
    pull(total_covid_deaths)

  # Get the covid death percentage of the race with most covid death
  result$race_most_death_rate <- round(result$most_covid_deaths_for_race /
                                         result$year_2020_covid_deaths, 2) * 100

  return(result)
}