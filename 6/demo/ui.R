shinyUI(
  navbarPage(
    "Reliability Model",
    tabPanel(
      "Upload",
      sidebarLayout(
        sidebarPanel(
          fileInput(
            'file',
            'Choose CSV File',
            accept=c(
              'text/csv', 
              'text/comma-separated-values,text/plain', 
              '.csv')
            ),
          tags$hr(),
          radioButtons(
            'sep',
            'Separator',
            c(
              Comma=',',
              Semicolon=';',
              Tab='\t'
              ),
            ','
            ),
          radioButtons('quote', 'Quote',
                       c(None='',
                         'Double Quote'='"',
                         'Single Quote'="'"),
                       '"')
        ),
        mainPanel(
          textOutput('text_view'),
          tableOutput('contents')
        )
      )
    ),
    tabPanel(
      "Plot",
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            "animation",
            "Looping Animation:",
            1,
            100,
            1,
            step = 1, 
            animate=animationOptions(interval=300, loop=T))
          ),
        mainPanel(
          plotOutput("plot1"),
          plotOutput("plot2")
        )
      )
    )
  ))