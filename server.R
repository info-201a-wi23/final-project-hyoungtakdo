library("dplyr")
library("plotly")

kidz_data <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/kidz-bop/KB_censored-lyrics.csv")

KidzBop <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/kidz-bop/KB_word-overview.csv")

sum_censored_words <- kidz_data %>% group_by(year) %>% 
  summarise(count = sum(count))

number_of_times_category <- kidz_data %>% group_by(category) %>%
                                          summarise(count = sum(count))

bad_words <- KidzBop %>% select(category, badword, inSongs, censored)
                                          




server <- function(input, output) {
  
  # This will be the output for the line chart of censored words per year
  output$year_plot <- renderPlotly({
    
    year_data <- sum_censored_words %>% filter(year >= input$year_selection[1] &
                                                 year <= input$year_selection[2])
                              
    
    chart1_graph <- ggplot(data = year_data) +
      geom_point(mapping = aes(
        x = year,
        y = count,
        text = paste("\n Year:", year,
                     "\n Censored Count:", count))) +
      geom_line(mapping = aes(
        x = year,
        y = count)) +
      
      scale_y_continuous(labels = scales::comma) +
      
      labs(title = "Censored Words Per Year From 2001-2019",
           x = "Year of Censorship",
           y = "Censored Word Count") +
      theme(plot.title = element_text(hjust = .5))
    
    return(ggplotly(chart1_graph, tooltip = c("text")))
    
  })
  
  # This will be the output for our category frequency chart
  output$category_plot <- renderPlotly({
    
    category_data <- number_of_times_category %>% filter(category %in% input$category_frequency)
     
    category_plot <- ggplot(category_data) + 
      geom_col(aes(x = category,
                   y = count,
                   fill = category,
                   text = paste("\n Censored Category:", category,
                                "\n Censored Count:", count))) + 
      
      labs(title = "Censored Category Frequency From 2001-2019", 
           x = "Category", 
           y = "The Frequency of a Category",
           fill = "Category Name"
           ) + 
      theme(plot.title = element_text(hjust = .5)) +
      scale_fill_brewer(palette = "Dark2") 
    return(ggplotly(category_plot, tooltip = c("text")))
    
  })
  
  # This is the output for our Words VS Frequency Chart
  output$frequency_plot <- renderPlotly({
    
    frequency_data <- bad_words %>% filter(badword %in% input$frequency_selection)
    
    frequency_plotted <- ggplot(data = frequency_data) +
      geom_point(mapping = aes(
        x = inSongs, 
        y = censored, 
        color = badword,
        text = "\n Word:", badword,
               "Original Count:", inSongs,
               "Censored Count:", censored)) +
      geom_smooth(mapping = aes(
        x = inSongs, 
        y = censored), 
        method = "lm") +
      labs(title = "How Often A Word Has Been Censored",
           x = "Word Frequency",
           y = "Censor Frequency")
    
    return(ggplotly(frequency_plotted, tooltip = c("text")))
    
  })
}
