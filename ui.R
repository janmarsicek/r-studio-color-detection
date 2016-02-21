library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Color Detection"),
  
  sidebarPanel(
    textInput("imgurl", "Paste URL of your JPG image here:", "http://farm8.staticflickr.com/7155/6456586091_4d8036f2ab_z.jpg"),
    
    sliderInput("ncolors", 
                "Number of colors:", 
                min = 2, 
                max = 16, 
                value = 9),
    
    downloadButton('downloadData', 'Download')
    ),
      
  mainPanel(
    plotOutput("plotDetect"),
    plotOutput("plotcolors")
    )
))
