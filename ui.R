library(shiny)

shinyUI(fluidPage(
  titlePanel("Miles Per Gallon Prediction"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("radioCYL", "How many cylinders?", 4, choices = c(4, 6, 8)),
      sliderInput("sliderHP", "How many horsepower?", 52, 335, value = 123),
      sliderInput("sliderWT", "How much weight is the car? (in pounds)", 3.325, min = 1.513, max = 5.424),
      radioButtons("radioTM", "What kind of transmission", "Automatic", choices = c("Automatic", "Manual")),
      submitButton("Submit")   
    ),
    mainPanel(
      tabsetPanel(type ="tabs",
                  tabPanel("Background", br(), 
                           h3("Overview"), p("This application is a shiny app created in R.
                                             The purpose of the app is to predict miles per gallon based on
                                             an optimized linear regression model performed on the MTcars dataset.
                                             This algorithm is utilizing an optimized model based on the MTCars dataset found in the r datasets package.
                                             For more information on the construction of the model, please see the algorithm tab."),
                           h3("Instructions"), p("Click on the prediction tab and choose the parameters on the left.  Hit the submit button
                                                       to show the predicted miles per gallon based on the car type specifications chosen.", br(), br(),
                            h3("Developer"), h4("Frederick Cabasa (Data Scientist)"), p("Built on September 23, 2018"))),
                  tabPanel("Prediction", h3("Parameters chosen for model"),
                           h4("Cylinders: "), verbatimTextOutput("inputCyl"), br(),
                           h4("Horsepower: "), verbatimTextOutput("inputHP"), br(),
                           h4("Car Weight: "), verbatimTextOutput("inputWT"), br(),
                           h4("Transmission: "), verbatimTextOutput("inputTM"), br(),br(),
                           h3("Predicted Miles Per Gallon:"),
                           textOutput("predMPG")),
                  tabPanel("Algorithm", h3("Linear Model Summary"),
                           verbatimTextOutput(outputId = "modelsummary"),
                           p("The summary of our predictive model is shown above.  This model was developed in three parts:"),
                           br(), p("A) The LM function was performed on the MTcars dataset with mpg as the dependent variable and
                                   the remaining variables as the independent variables."), br(),
                                  p("B) The STEP function was then used to optimize the model created from LM to produce the lowest AIC score possible.
                                    The result in the most accurate regression model possible from this method."), br(),
                                  p("C) The PREDICT function would then take the parameters chosen and used as the basis to predict the miles per gallon
                                    based on the equation produced by the STEP function."))
      )
    )
  )
))
