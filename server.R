library(shiny)

data(mtcars)

'Set factors for the variables in the MT Cars dataset'
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
mtcars$am <- factor(mtcars$am, levels=c(0,1))

mpg_pred<- lm(mpg~., data=mtcars)
summary(mpg_pred)

mpg_pred_opt <- step(mpg_pred, direction = "both")
summary(mpg_pred_opt)

fxnMPG <- function(cyl,hp,wt,am){
  if(am == "Automatic"){
    am <- c(0)
  } else {
    am <- c(1)
  }
  values <- data.frame(as.factor(cyl),as.numeric(hp),as.numeric(wt),as.factor(am))
  colnames(values )= c("cyl","hp","wt","am")
  pred=predict(mpg_pred_opt, newdata=values)
  cat(pred)}

shinyServer(function(input, output) {
  output$inputCyl <- renderPrint({input$radioCYL})
  output$inputHP <- renderPrint({input$sliderHP})
  output$inputWT <- renderPrint({input$sliderWT})
  output$inputTM <- renderPrint({input$radioTM})
  output$modelsummary <- renderPrint(summary(mpg_pred_opt))

  output$predMPG <- renderPrint(fxnMPG(input$radioCYL, input$sliderHP, input$sliderWT, input$radioTM))
  })

