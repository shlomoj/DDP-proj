library(shiny)

shinyServer(function(input, output) {
  output$clinInfo1 <- renderText({
    prior <- as.numeric(input$PRIOR) / 10
    paste("GBS incidence:", prior)
  })
  
  output$clinInfo2 <- renderText({
    paste("Gestational age:", input$GAw, " weeks and ", input$GAd, " days.")
  })
  
  output$clinInfo3 <- renderText({
    GBS.stat <- factor(input$GBS, levels=c(1,2,3), labels=c("Unkown", "Positive", "Negative"))
    paste("GBS status:", GBS.stat)
  })
  output$clinInfo4 <- renderText({
    if (input$CEL == 1)
      mat.fev <- as.numeric(input$MAT.FEVc)
    if (input$CEL == 0)
      mat.fev <- round((as.numeric(input$MAT.FEVf) - 32) * 5 / 9,1)
    paste("Maternal fever: ", mat.fev, "Celsius")
  
  })
  output$clinInfo5 <- renderText({
    paste("ROM Time:", input$ROM, " hours")
  })
  output$clinInfo6 <- renderText({
    abx <- factor(input$ABX, levels=c(1,2,3), labels=c("None", "GBS specific", "Broad Spectrum"))
    abx.t <- as.numeric(input$ABX.t)
    a <- "Antibiotic treatment:"
    if (abx == "None")
      paste(a, abx)
    else
      paste(a, abx, " ", abx.t, " hours before delivery")
    
  })
  output$risk <- renderText({
    ga.w <- as.numeric(input$GAw) + as.numeric(input$GAd)/7
    GBS.stat <- factor(input$GBS, levels=c(1,2,3), labels=c("Unkown", "Positive", "Negative"))
    if (input$CEL == 1)
      mat.fev <- as.numeric(input$MAT.FEVc) * 9/5 + 32
    if (input$CEL == 0)
      mat.fev <- as.numeric(input$MAT.FEVf)
    abx <- factor(input$ABX, levels=c(1,2,3), labels=c("None", "GBS specific", "Broad Spectrum"))
    abx.t <- as.numeric(input$ABX.t)
    
    
    intercept <- 47.8398
    coef.temp <- 0.8680
    coef.ga <- -6.9325
    coef.ga2 <- 0.0877
    coef.rom <- 1.2256
    coef.iap1 <- -1.0488
    coef.iap2 <- -1.1861
    coef.gbspos <- 0.5771
    coef.gbsu <- 0.0427
    int.adj <- -7.128
    rom.t <- (as.numeric(input$ROM) + 5/60)^(0.2)
    b <- intercept + coef.temp*mat.fev + coef.ga*ga.w + coef.ga2*ga.w^2 + coef.rom*rom.t +
      coef.iap1 * as.numeric(abx=="GBS Specific" && abx.t>=4) + 
      coef.iap1 * as.numeric(abx=="Broad Spectrum" && abx.t<4) +
      coef.iap2 * as.numeric(abx=="Broad Spectrum" && abx.t>=4) +
      coef.gbspos * as.numeric(GBS.stat == "Positive") +
      coef.gbsu   * as.numeric(GBS.stat == "Unkown") + int.adj
    p <- 1/(1+exp(-b))
    #print(intercept)
    #print(coef.temp*mat.fev)
    #print(coef.ga*ga.w)
    #print(coef.ga2*ga.w)
    #print(coef.rom*rom.t)
    #print(coef.iap1 * as.numeric(abx=="GBS Specific" && abx.t>=4))
    #print(coef.iap1 * as.numeric(abx=="Broad Spectrum" && abx.t<4))
    #print(coef.iap2 * as.numeric(abx=="Broad Spectrum" && abx.t>=4))
    #print(coef.gbspos * as.numeric(GBS.stat == "Positive"))
    #print(coef.gbsu   * as.numeric(GBS.stat == "Unkown"))
    #print(int.adj)
    #print(b)
    paste("Calculated risk:", format(round(p,3), nsmall=3),
          "or", floor(p*1000), "per 1000 live births")
  
  })
})