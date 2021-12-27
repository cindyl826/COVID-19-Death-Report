# Turned table into a function:
summary_table <- function(dataframe) {
  # Changed the column name to look better:
  colnames(dataframe)[4] <- "Race/Ethnicity"
  # Filtered the data to only show deaths from 2020:
  deaths_2020 <- dataframe %>%
    filter(Date.Of.Death.Year == 2020)
  summary <- deaths_2020 %>%
    # Grouped by column "Race/Ethnicity" as the demographic to focus on:
    group_by(`Race/Ethnicity`) %>%
    # Summarized the data of most relevant columns displaying cause of death data:
    summarize(
      "All Cause" = sum(AllCause, na.rm = TRUE), 
      "Natural Cause" = sum(NaturalCause, na.rm = TRUE),
      "COVID-19 as a Multiple Cause of Death" = 
        sum(COVID.19..U071..Multiple.Cause.of.Death., na.rm = TRUE),
      "COVID-19 as the Underlying Cause of Death" = 
        sum(COVID.19..U071..Underlying.Cause.of.Death., na.rm = TRUE)
    )
}

