library("shiny")
library("tidyverse")
library("plotly")
library("bslib")

my_theme <- bs_theme(bg = "#E9D8E4", 
                     fg = "black", 
                     primary = "#343F71")

intro_page <- tabPanel(
  "Introduction",
   h1("Kidz Bop Censorship"),
   h2("Purpose of Project"),
   p("Kidz Bop is an organization that promises to deliver mainstream songs
     that are kid friendly. The Kiz Bop dataset, provided by The Pudding,
     shows hundreds of rows comparing censorships between the Kidz Bop lyrics
     and original lyrics. With this dataset, we wanted to analyze the
     categories used for censorship, the number of censorships per year,
     and how much value the censorships carry. Furthermore, we want to find out
     if the censorships offend any marginalized groups and if censorships have
     had more weight throughout the years. Understanding what is censored and
     how frequently those words are censored will give us a better
     understanding of how Kidz Bop views specific topics and can allow us
     to understand the reasons behind the censorship."),
  img(height = 250, width = 286.885245,src = "Kidz-bop-logo.png", align = "right"),
  h2("Main Questions"),
  p("For our analysis, we are answering three main questions:"),
  p("• Has the number of censorships per year grown since the start of 
     this organization?"),
  p("• How often were the categories used as a reason for censorship? Were
     any of these categories wrongly used?"),
  p("• What kind of words are present in song lyrics but not censored
     in Kidz Bop songs? What are these specific words?"),
  h3("Datasets Information"),
  p("The datasets we are analyzing are “Kidz Bop Censored Lyrics”
    and “Kidz Bop Words Overview;” they are both from a GitHub repository
    provided by The Pudding. The Pudding is a digital publication that
    explains ideas debated in culture and visually displays data to support
    those debates. This data was collected because The Pudding wanted to know
    how censorship in Kidz Bop has revolutionized throughout the years.
    They managed this data by first accessing the lyrics of Kidz Bop and
    original songs using the Genius API. The release year of both versions
    of the song was collected by using Spotify’s API. From there, they devised
    a list of common “bad words” and searched them through the original pieces."),
  p("The Kidz Bop Censored lyrics dataset details the comparison
    of the original song lyric and Kidz Bop lyric and why it was censored.
    This dataset includes 1353 observations and ten features. 
    These features include:"),
  p("• ogArtist - the artist of the original song"),
  p("• songName - the original song name"),
  p("• badword - the word that is censored"),
  p("• count - the amount of times this word was censored in the song"),
  p("• category - the category used to censor the word"),
  p("• year - the year the KidzBop song was made"),
  p("• isCensored - a numerical value to represent if the word is censored"),
  p("• isPresent - a numerical value to represent if the word is present"),
  p("• ogLyric - the original lyric"),
  p("• kbLyric - the modified lyric from KidzBop. "),
  p("The Kidz Bop Words Overview dataset provides an overview of the
    specific words in the original and modified songs. This dataset has 227
    observations and four features. These features include:"),
  p("• category – the category used to censor the word"),
  p("• inSongs - number of original songs where a word in 
     this category is present"),
  p("• censored - number of Kidz Bop songs where a word in 
     this category is censored"),
  p("• pctCensored - rate of censorship by category"),
  a("Kidz Bop Censored Lyrics Dataset", href = "https://github.com/the-pudding/
    data/blob/master/kidz-bop/KB_censored-lyrics.csv"),
  p(""),
  a("\n Kidz Bop Overview Dataset", href = "https://github.com/the-pudding/data/
    blob/master/kidz-bop/KB_word-overview.csv"),
  h2("Ethical Questions and Limitations"),
  p("While viewing the dataset, we found a big ethical problem within
    censorship, specifically how it censors LGBTQ+ terms. For example,
    we noticed how Kidz Bop edited the word “gay” in the song “born this way”
    by Lady Gaga. We thought this was unethical towards the LGBTQ+ community
    because kids should know about these terms; it’s general knowledge,
    especially in our current generation. It shouldn’t be labeled as something
    inappropriate because it’s a very common sexuality during an age.
    More LGBTQ+ terms are censored in these datasets, and we are questioning
    the Kidz Bop organization if they support other sexualities.")
  
                                                            
)
   
       

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
         the audience the number of words that were censored each year
         from the data set of Kidz Bop Censorship. We decided to use a
         line chart because it best shows the ups and downs of censorship
         from year to year. We also decided to find the different amount
         of censorship each year because we can try to find out if censorship
         changes based on when different laws were passed and depended on the
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
                   selected = c("addict", "blow", "bottle"),
                   multiple = TRUE)),
     
     mainPanel(
       h1("How Often are the Words Censored"),
       plotlyOutput("frequency_plot"),
       h3("Visualization Summary"),
       p("The above scatterplot is showing the amount of times a word that
         could be censored appears in a song against how often it is censored.
         The line in the middle is showing a line of best fit, suggesting that
         songs above the line are more censored more frequently than expected,
         while those below are censored less frequently than expected. Once
         this visualization was created, one of the things that jumped out
         at me was that cuss words were almost all censored everytime.
         All points that plot profanity sit above the expected line.
         Interestingly enough, the words “man”, “kiss”, and “god” were
         4th, 5th, and 6th respectively in most times censored.
         Sexual references can be seen sitting below the expected line
         quite frequently, suggesting that the context of the sexual references
         matters a lot. Words pertaining to violence can be seen on both sides
         of the expected line, which also suggests that context does matter a
         lot to the censorship decisions made. Words fitting into the other
         and identity categories often sit below the expected line, with two
         exceptions, those being “man” (identity) and “god” (other).")
     )
   ))

conclusion <- tabPanel(
  "Conclusion",
  img(height = 175, width = 200.8196721311475,src = "Kidz-bop-logo.png", align = "right"),
  h1("What To Take Away From This Dataset"),
  p("As we took a final look into this data, we had some key takeaways of our 
    own that answered parts of our questions."),
  
  p("Our first question was asking if the number of censorship has grown. 
    Well when we took a look at 2001, the start of our dataset, the number
    of censored words was 4. Meanwhile the most recent year 2019, the number
    of censored words was 450. A whopping 100X difference. That itself
    answers pretty much the whole question."),
  
  p("Our next question was how often our categories were used as the reason
    for censorship. Since each censored is part of a category, most might ask
    isn't the answer 100%? Well, there is one category that is called other,
    which takes censored words that weren't censored because of any categories
    but still got censored anyway. Taking that into account, this would mean that
    instead of 100%, it would be a 92% rate where categories were reasons for
    censorship. It is still a very high rate, however, just pointing out
    this part of the data allowed us to find an answer that we may not
    have found beforehand."),
  
  p("Finally, our last question for our dataset was what kind of words are
    present in the original lyrics that were not censored? To answer this,
    we looked at the dataset inside the tab Words VS Frequency. Out of all
    the categories, we noticed that the other category had the most instances
    of words in songs that were never censored with 14. I think this makes
    sense as the other categories have specific reasons for censorship while
    others aren't specifying any of the specific censored categories."),
  
  p("All in all, there is so much we can get out of this data. Not only that, 
    we are able to use our findings from this data to search even deeper with
    outside searches. Were specific political movements and actions a causing
    factor? Was there an increase in songs of profanity? This dataset allows
    us to not just find answers, but to find deeper and more meaningful questions 
    that will help create even better answers in the future.")
)
  

ui <- navbarPage("Kidz Bop Censorship",
                 theme = my_theme,
                 intro_page,
                 chart_1,
                 chart_2,
                 chart_3,
                 conclusion
)
