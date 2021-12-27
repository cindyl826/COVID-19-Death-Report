library("shiny")
library("dplyr")
library("plotly")
library("ggplot2")
library("RColorBrewer")
globalVariables("Date.Of.Death.Year")

deaths_df <- read.csv("data/AH_Monthly_provisional_counts_of_deaths.csv",
                        stringsAsFactors = FALSE)

server <- function(input, output) {
  # Interactive 1
  output$plot1 <- renderPlotly({
    #filtered for 2020 data and grouped by age
    deaths_by_age <- deaths_df %>%
      filter(Date.Of.Death.Year == 2020) %>%
      group_by(AgeGroup) %>%
      summarise(total_deaths = sum(COVID.19..U071..Underlying.Cause.of.Death.,
                                   na.rm = TRUE)) %>%
      mutate(percent = round(prop.table(total_deaths) * 100, 2))

    #bar plot for input "total_deaths"
    if (input$yvar == "total_deaths") {
      plot1 <- plot_ly(
        data = deaths_by_age,
        x = ~AgeGroup,
        y = ~total_deaths,
        type = "bar",
        color = I("steelblue4"),
        hoverinfo = "text",
        text = ~paste("Number of Deaths:", total_deaths)
      ) %>%
        layout(
          title = "Total Number of COVID-19 Deaths by Age",
          xaxis = list(title = "Age Group"),
          yaxis = list(title = "Total Number of COVID-19 Deaths")
        )
    } else {
      #bar plot for input "percent"
      plot1 <- plot_ly(
        data = deaths_by_age,
        x = ~AgeGroup,
        y = ~percent,
        type = "bar",
        color = I("steelblue4"),
        hoverinfo = "text",
        text = ~paste0("Percent of Deaths ", percent, "%")
      ) %>%
        layout(
          title = "Percent of COVID-19 Deaths by Age",
          xaxis = list(title = "Age Group"),
          yaxis = list(title = "Percent of COVID-19 Deaths")
        )
    }
    return(plot1)
  })

  # Interactive 2
  # create and render the output plots
  output$plot2 <- renderPlotly({
    # get the data to be used from the dataframe
    deaths_by_race <- deaths_df %>%
      filter(Date.Of.Death.Year == 2020) %>%
      group_by(Race.Ethnicity) %>%
      summarise(total_deaths = sum(COVID.19..U071..Underlying.Cause.of.Death.,
                                   na.rm = TRUE))
      # using if else statement to determine the graph type based on the input
      if (input$graphInput == "pie") {
        plot2 <- plot_ly(
          data = deaths_by_race,
          labels = ~Race.Ethnicity,
          values = ~total_deaths,
          text = ~ paste("Number of Deaths:", total_deaths),
          hoverinfo = "text",
          type = "pie"
        ) %>%
          layout(title = "Proportions of COVID-19 Deaths By Ethnicity/Race")
      } else {
        plot2 <- ggplot(data = deaths_by_race) +
          geom_col(mapping = aes(
            x = Race.Ethnicity,
            y = total_deaths)) +
          ggtitle("COVID-19 Deaths by Race/Ethnicity") +
          labs(x = "Race/Ethnicity", y = "Total Deaths") +
          theme(axis.text.x = element_text(angle = 20))
      }
      return(plot2)
  })

  # Interactive 3
  # create and render the output plots
  output$plot3 <- renderPlotly({
    # if else statement determines which year's data to use
    deaths_by_sex <- deaths_df
    if (input$yearInput == "2020") {
      deaths_by_sex <- filter(deaths_by_sex, Date.Of.Death.Year == 2020)
    } else {
      deaths_by_sex <- filter(deaths_by_sex, Date.Of.Death.Year == 2021)
    }
    # finish grouping the data by sex and year to plot
    deaths_by_sex <- group_by(deaths_by_sex, Sex) %>%
      summarise(total_deaths = sum(COVID.19..U071..Underlying.Cause.of.Death.,
                                   na.rm = TRUE))

    plot3 <- plot_ly(
      data = deaths_by_sex,
      labels = ~Sex,
      values = ~total_deaths,
      text = ~ paste("Total Deaths:", total_deaths),
      hoverinfo = "text",
      type = "pie"
    ) %>%
      layout(title = "Proportions of COVID-19 Deaths By Sex")
    return(plot3)
  })

  # Conclusion Page

    output$table1 <- renderTable({
      # Filter for deaths only in 2020:
    deaths_2020 <- deaths_df %>%
      filter(Date.Of.Death.Year == 2020)
    table1 <- deaths_2020 %>%
      # Examine only race/ethnicity data from the dataset:
      group_by(Race.Ethnicity) %>%
      # Summarize based on the appropriate (COVID-19-related) columns:
      summarize("COVID-19 as a Multiple Cause of Death" =
                  sum(COVID.19..U071..Multiple.Cause.of.Death., na.rm = TRUE),
                "COVID-19 as the Underlying Cause of Death" =
                  sum(COVID.19..U071..Underlying.Cause.of.Death., na.rm = TRUE))
    return(table1)
  })

  output$table2 <- renderTable({
    # Filter for deaths only in 2020:
    deaths_2020 <- deaths_df %>%
      filter(Date.Of.Death.Year == 2020)
    table2 <- deaths_2020 %>%
    # Examine only age-group data from the dataset:
      group_by(AgeGroup) %>%
    # Summarize based on the appropriate (COVID-19-related) columns:
      summarize("COVID-19 as Multiple Cause of Death" =
                  sum(COVID.19..U071..Multiple.Cause.of.Death., na.rm = TRUE),
                "COVID-19 as Underlying Cause of Death" =
                  sum(COVID.19..U071..Underlying.Cause.of.Death., na.rm = TRUE))
    return(table2)
  })

  output$table3 <- renderTable({
    # Filter for deaths only in 2020:
    deaths_2020 <- deaths_df %>%
      filter(Date.Of.Death.Year == 2020)
    table3 <- deaths_2020 %>%
    # Examine only sex data from the dataset:
      group_by(Sex) %>%
    # Summarize based on the appropriate (COVID-19-related) columns:
      summarize("COVID-19 as Multiple Cause of Death" =
                  sum(COVID.19..U071..Multiple.Cause.of.Death., na.rm = TRUE),
                "COVID-19 as Underlying Cause of Death" =
                  sum(COVID.19..U071..Underlying.Cause.of.Death., na.rm = TRUE))
    return(table3)
  })
}