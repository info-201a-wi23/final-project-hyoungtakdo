library("shiny")
library("tidyverse")
library("plotly")

intro_page <- tabPanel("Introduction",
                       h1("Kidz Bop Censorship"))

chart_1 <- tabPanel(
  "Censored Words Per Year",
   sidebarLayout(
    sidebarPanel(
      h3("Select Your Year Range:"),
      sliderInput(inputId = "year_selection",
                  label = "Years",
                  min = 2001,
                  max = 2019,
                  value = c(2001, 2019),
                  round = TRUE)),
    mainPanel(
      h1("Kidz Bop Censorship through the Years"),
      plotlyOutput("year_plot"),
      h3("Visualization Summary"),
      p("The chart above gives us a line chart to represent and show
         the audience the amount of words that were censored each year
         from the data set of Kidz Bop Censorship. We decided to use a
         line chart because it best shows the ups and downs of censorship
         from year to year. We also decided to find the different amount
         of censorship each year because we can try to find out if censorship
         changes based on when different laws were passes and depended on the
         time periods."),
      p("This data set has revealed to us when the most and least amount of
         censorship has happened in some of the years. For example, we found
         that in 2015, Kidz Bop had the most censored words of any year while
         2001 had the least. Findings like this from our data will
         help us look closer into why this could be the case by seeing other
         aspects of what happened in those years such as political, social,
         and environmental events in other outside research."))
      
 )
)
  
chart_2 <- tabPanel(
  "Category Censorship",
   sidebarLayout(
     sidebarPanel(
       h3("Category Frequency"),
       selectInput(inputId = "category_frequency",
                   label = "Categories of Censorship",
                   choices = number_of_times_category$category,
                   selected = c("profanity", "other"),
                   multiple = TRUE)),
     
     mainPanel(
       h1("Category Censorship Frequency"),
       plotlyOutput("category_plot"),
       h3("Visualization Summary"),
       p("The bar chart above describes the number of times each category
         was used as a reason for censorship in a song. This was an essential
         visualization because the numbers can show which category the Kidz Bop
         corporation prioritizes more regarding censorship. After creating this
         visualization, the most common category used was profanity, which
         wasn’t surprising because most songs contain profanity anyway."),
       
       p("The second most used category was sexual references, which surprised
         us because we would think alcohol & drugs would be the second highest.
         However, after overviewing the dataset, some words censored under the
         “sexual” category were unnecessary. For instance, the song 
         “Love Yourself” by Justin Bieber edited the word “sleep” under the
         sexual reference category. Looking at the original lyric, there was no
         need for censorship. Another unnecessary instance was from the song
         “Mercy” by Shawn Mendes, and the censored word in the song was “skin.”
         After looking at the original lyric, censorship was unnecessary,
         especially under the sexual category. These examples of extreme
         censorship under the sexual category may have flawed this data.")
     )
   ))

chart_3 <- tabPanel(
  "Words Vs Frequency",
   sidebarLayout(
     sidebarPanel(
       h3("Words VS Frequency"),
       selectInput(inputId = "frequency_selection",
                   label = "Choice of Word",
                   choices = bad_words$badword,
                   selected = "addict",
                   multiple = TRUE)),
     mainPanel(
       h1("How Often are the Words Censored"),
       plotlyOutput("frequency_plot")
     )
   ))

conclusion <- tabPanel("Conclusion")

ui <- navbarPage("Kidz Bop Censorship",
                 intro_page,
                 chart_1,
                 chart_2,
                 chart_3,
                 conclusion
)
