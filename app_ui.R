library("shiny")
library("dplyr")
library("plotly")
library("shinyWidgets")
library("ggplot2")
library("RColorBrewer")

# Intro Page

intro_main_panel <- fluidPage(
  #add CSS elements
  includeCSS("style.css"),
  #Add introductory paragraph and data background.
  h1("Introduction"),
  p("The basic overview of our project is we investigated US",
    strong("Covid 19"), "death data to answer various questions about
    demographic relationships to mortality rates. The importance of this
    analysis is that we are synthesizing raw death data and analyzing
    demographic trends that may reflect discrpensies in mortality rates by
    various groups. Our goal is to investigate these trends to see if there are
    any significant differences between various demographic groups and analyze
    the implications from our findings."),
  p("Our data source is a CDC provided breakdown of Covid-19 deaths by
    demographic groups. This data was collected by the National Center for
    Health Statistics, who compiled US resident death certificates starting on
    January 1st, 2019."),

 #Add outline of investigation questions.
 h2("Investigation Questions"),
 p("We structured our project based on 3 questions we had about the data."),
 h3("How do Covid 19 deaths vary by age group?"),
 p("To answer this question, we compared grouped the total death rates data by
 age group. "),
 h3("What is the proportion of Covid 19 deaths by Race/Ethnicity?"),
  p("The basic overview of our project is we investigated", strong("Covid 19"),
 "death data to answer various questions about demographic relationships to
  mortality rates. We focused on answering 3 questions with our data."),
 h3("How do Covid 19 deaths vary by sex?"),
 p("To answer this question, we grouped the total death rates by sex.")
)
# Add images on the side of the summary page:
intro_side_panel <- sidebarPanel(
  img("", src
      = "https://www.apa.org/images/article-covid-19_tcm7-277085_w1024_n.jpg",
      width = 400, height = 250)
)
#Creating layout of intro page.
  intro_tab <- tabPanel(
    "Introduction",
    titlePanel = "Project Overview",
    mainPanel(intro_main_panel),
    sidebarPanel(intro_side_panel)
  )

# Interactive Page 1
age_side_panel <- sidebarPanel(
  h1("COVID-19 Deaths by Age Groups"),
  radioButtons(
    inputId = "yvar",
    label = h4("Select to graph either the total number of COVID-19 deaths or
    the percent of COVID-19 deaths per age group:"),
    choices = list("Total number of COVID-19 Deaths" = "total_deaths",
                   "Percent of COVID-19 deaths" = "percent")
  ),
  p("These bar plots attempt to answer our question of how do COVID-19 deaths
  vary among age groups. They provide the number of deaths and the percentages
  of deaths caused by COVID-19 in each age group. From the plots, we can see a
  clear increasing trend in the numbers and percents of deaths as age increases.
  This implies that some groups, particularly older adults, are inevitably more
  susceptible to COVID-19 than others. A bar graph is an appropriate way to
  visualize this information because it allows for easy comparison between
  different categories of age groups by simply comparing the bar heights.")
)

age_main_panel <- mainPanel(
  plotlyOutput("plot1")
)

age_tab <- tabPanel(
  "Age",
  titlePanel = "Deaths By Age Groups",
  sidebarLayout(age_main_panel, age_side_panel)
)

#Interactive Page 2
# store the main panel of race/ethnicity tab
race_main_panel <- mainPanel(
  plotlyOutput("plot2"),
)
# store the side bar panel of the race/ethnicity tab
race_side_panel <- sidebarPanel(
  h1("COVID-19 Deaths By Ethnicity/Race"),
  radioGroupButtons(
    inputId = "graphInput",
    label = h4("Select a type of chart to see the discrepancies among groups:"),
    choices = c("Pie Chart" = "pie", "Bar Chart" = "bar"),
    justified = TRUE
  ),
  p("The pie chart focus more on an overview that shows the proportion the
   deaths of each group takes up to while the bar chart focus more on
   performance on each group. Both of these charts can be used to see the
   discrepancies of deaths among the groups. We can see that Non-Hispanic White
    has the largest number of deaths, however, we should also consider some
    implications such that this racial/ethic group takes up the majority of
    the society in the United States.")
)
# create and store layout of interactive page 2
ethnicity_tab <- tabPanel(
  "Ethnicity",
  sidebarLayout(race_side_panel, race_main_panel)
)

# Interactive Page 3
sex_main_panel <- mainPanel(
  plotlyOutput("plot3")
)
sex_side_panel <- sidebarPanel(
  h1("COVID-19 Deaths by Sex"),
  radioGroupButtons(
    inputId = "yearInput",
    label = h4("Select a year's data to graph:"),
    choices = list("2020" = "2020", "2021 (Until April 1st)" = "2021"),
    justified = TRUE
  ),
  p("These charts attempt to understand the change in male vs. female death
    rates in relation to COVID-19. In both 2020 and 2021, males had a higher
    death rate, and although there were more overall deaths in 2020, the
    fraction of male deaths in 2021 were higher out of the total deaths that
    year, The small difference between the two pie charts explains that the
    male-female ratio for death rates were mostly consistent during the
    pandemic. A pie chart was the best way to visualize this minute change,
    because it's very simple, especially when clicking back and forth between
    the years, to tell how much changes between them.")
)

sex_tab <- tabPanel(
  "Sex",
  titlePanel = "Death Rate Comparison Between Sexes",
  sidebarLayout(sex_main_panel, sex_side_panel)
)

# Conclusion Page
summary_main_panel <- fluidPage(
  # Add CSS elements:
  includeCSS("style.css"),
  h1("Summarizing the Data"),
  p("After conducting our data examination and analysis, we have developed
    some key, major", strong("takeaways"), "from our project regarding causes
    of death, specifically COVID-19, related to various demographic factors.
    These takeaways are specifically based on the aspects of our analysis
    depicted in the previous pages.Our takeaways are based off of our
    findings/observations related to", em("race and ethnicity, age,"), "and",
    em("sex.")),
  # Takeaway 1: Age
  h2("Age"),
    p("Through the data, we were able to observe an overall trend/pattern
    specifically in terms of the", em("relationship/correlation between age and
    COVID-19 deaths."), "As conveyed through the data,", strong("older age
    groups correlate with greater deaths due to COVID-19.")),
  # Insert table summarizing age-group data:
  tableOutput("table2"),
  p("In terms of why this pattern is important to acknowledge and recognize,
    there are broader implications of this that we must consider.",
    em("It is vital that we as a society recognize the age groups most
    vulnerable to certain disorders and diseases such as COVID-19, especially
       during a pandemic."), "We must mitigate the ignorance surrounding those
       most affected; just because younger generations have a higher survival
       rate and a significantly lower death rate of COVID-19 does not mean that
       this disease is not dangerous. Some age groups are evidently more
       impacted than others,so it is important to recognize COVID-19 as a major
       risk to society and implement appropriate measures (social distancing,
       wearing masks, etc.) and take these measures seriously."),
  # Takeaway 2: Race/Ethnicity
  h2("Race & Ethnicity"),
  p("The data conveyed the", em("racial/ethnic groups with greater COVID-19
  death rates."), "The data demonstrated that", strong("Non-Hispanic White
  individuals experienced greater deaths due to COVID-19,"), "followed by
  Hispanic individuals, Non-Hispanic Black individuals, Non-Hispanic Asian
    individuals, Non-Hispanic American Indian or Alaska Native individuals,
    and others, respectively."),
  # Insert table summarizing race/ethnicity data:
  tableOutput("table1"),
  p("The data overall highlights the racial discrepancies in terms of the
  racial/ethnic groups most impacted (death-rate-wise) by COVID-19. However,
  there are broader implications of this data and observable trend/pattern to
  consider. Non-Hispanic Whites are the majority in society and therefore it is
  understandable that they would have the greatest COVID-19 death rate among
  this data set that is examining the", strong("proportions"), "of COVID-19
    deaths. Perhaps it is vital that we as a society recognize the
    representation various racial/ethnic groups are receiving in not only
    research studies, but all aspects of life. Many other studies may even
    convey that minority groups are more prone to COVID-19 deaths due to
    a variety of systematic factors, so it is important to examine and
    observe data with caution, as well as an open mind."),
  # Takeaway 3: Sex
  h2("Sex"),
  p("The last main takeaway regards the", em("relationship between sex and
  COVID-19 death rates."), "The data conveys that there is no large, significant
  difference in the COVID-19 death rate between males and females. Despite a
    lack of a major disparity among the sexes, the data depicts that males tend
    to have a higher COVID-19 death rate than females."),
  # Insert table summarizing sex data:
  tableOutput("table3"),
  p("This difference among sexes may be due to the discrepancies in numbers of
  males vs. females part of this data (it makes sense that more male
  participants could lead to more male deaths). However, this data could also
  potentially have broader implications in that we as a society may need to
  consider the environment(s) males are often put in that could lead to contract
    COVID-19 and ultimately die from it. The lack of a large disparity among
    the sexes does not necessarily call for an immediate need for change/
    action, but it is a reminder to maintain an open, analytical mind when
    examining data because proportional data can sometimes be misleading
    but there are also outside factors to consider. As demonstrated through
    the rest of the data, it is nevertheless important to examine data from
    a broad perspective to see the whole picture to help mitigate any
    ignorance surrounding certain topics, such as the COVID-19 pandemic
    and those most affected.")
)
# Add images on the side of the summary page:
summary_side_panel <- sidebarPanel(
  img("", src = "https://www.wolterskluwer.com/-/media/project/wolterskluwer/
      oneweb/www/health/division/campaigns/2020/covid19-split-hero.
      jpg?rev=350708cfe6fa446d84aa9341be717b7c",
      width = 400, height = 250),
  img("", src = "https://news.mit.edu/sites/default/files/images/202005/covid-19-MITGOVLAB.png",
      width = 400, height = 250),
  img("", src = "https://dph.georgia.gov/sites/dph.georgia.gov/files/styles/3_2_2106px_x_1404px/public/2021-04/GettyImages-1210455332.jpg?h=32b23554&itok=1VqRSPk7",
      width = 400, height = 250)
)

# Organize the layout of the summary/conclusion page:
conclusion_tab <- tabPanel(
  "Summary",
  titlePanel = "Summarizing the Data",
  mainPanel(summary_main_panel),
  sidebarPanel(summary_side_panel)
)

# Ui:
ui <- navbarPage(
  "COVID-19 Deaths by Selected Demographics",
  intro_tab,
  age_tab,
  ethnicity_tab,
  sex_tab,
  conclusion_tab
)
