library(shiny)
shinyUI(fluidPage(
  titlePanel("Neonatal Sepsis Calculator"),
  sidebarLayout(
    sidebarPanel(
      # Commented out pending implementation of correcting for incidence
      #selectInput("PRIOR", "GBS Sepsis Incidence (per 1000 live births)",
      #             choices=list("0.1"=1, "0.2"=2, "0.3 (CDC US Incidence)"=3,"0.4"=4,
      #                         "0.5"=5, "0.6"=6), selected=3),
      selectInput("PRIOR", "GBS Sepsis Incidence (per 1000 live births)",
                  choices=list("0.6"=6)),
      strong('Gestational Age'),
      fluidRow(
        column(4,
          numericInput("GAw", "Weeks", 40, min=34, max=41, step=1)
          ),
        column(4,
          numericInput("GAd", "Days", 0, min=0, max=6, step=1)
          ),
        column(4,
          radioButtons("GBS", "GBS status",
                        choices=list("Unknown"=1, "Positive" = 2, "Negative" = 3),
                        selected=1
          )
          )
        ),
      fluidRow(
        column(9,
               conditionalPanel(condition="input.CEL == 1",
                    sliderInput("MAT.FEVc", HTML("Highest Maternal Antepartum Temp."),
                      min=36, max=42, value=37, step=0.1)),
              conditionalPanel(condition="input.CEL == 0",
                    sliderInput("MAT.FEVf", HTML("Highest Maternal Antepartum Temp."),
                      min=97, max=106, value=98.6, step=0.1))
         ),
         column(3,
              radioButtons("CEL", label="", choices=list("C" = 1, "F"=0), selected=1)
          )
      ),
      sliderInput("ROM", "Rupture of Membranes Time (hours)", 
                  min=0, max=240, value=0
      ),
      radioButtons("ABX", "Antibiotic treatment during labor",
                         choices=list("None"=1,
                                      "GBS specific (ie penicillin/ampicillin)"=2,
                                      "Broad Spectrum"=3), selected=1
      ),
      conditionalPanel(condition="input.ABX != 1",
        textInput("ABX.t", "Duration of treatment before delivery (hours)",
                value="0")
      )
    ),
    mainPanel(
      strong("Instructions:"),p("Enter clinical information at sidebar. Calculated sepsis risk will appear below."),
      h2("Clinical Information"),
      textOutput("clinInfo1"),
      textOutput("clinInfo2"),
      textOutput("clinInfo3"),
      textOutput("clinInfo4"),
      textOutput("clinInfo5"),
      textOutput("clinInfo6"),
      h2("Early-onset Sepsis Risk"),
      strong(textOutput("risk")),
      tags$br(),
      tags$br(),
      tags$br(),
      tags$hr(),
      p("Disclaimer: This application was created as part
        of an exercise on usng Shiny. It has not been validated
        and should under no circumstances be used for clinical decision making"),
      p("The original research on which this calculator was based -
        including the original calculator - can be found here:"),
      a(href="http://www.dor.kaiser.org/external/DORExternal/research/infectionprobabilitycalculator.aspx", "http://www.dor.kaiser.org")
      
    )
    
  )))