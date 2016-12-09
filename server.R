
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
    library(dplyr)
    library(zoo)
    library(forecast)
    
    df <- read.csv("hr.data.csv")
    
    dpo <- tbl_df(df) %>% 
        group_by(year, quarter, department) %>% 
        summarise(
            CapitaIncome = sum(CapitaIncome),
            Profitability = sum(Profitability),
            NetProfit = sum(NetProfit),
            LaborCost = sum(LaborCost),
            LaborCostProfitRatio = mean(LaborCostProfitRatio),
            ReturnOnHumanCapital = mean(ReturnOnHumanCapital)
        )
    
    output$forecastPlot <- renderPlot({
        dp <- dpo %>% filter(department == input$department)
        finalColumn <- dp[,input$measure]
        ts1 <- ts(finalColumn, frequency = 4, start = c(2008, 1))
        ts1Train <- window(ts1, start = 2008, end = 2012)
        ts1Test <- window(ts1, start = 2012, end = 2017)
        ets1 <- ets(ts1Train, model = "MMM")
        fcast <- forecast(ets1)
        plot(fcast)
        lines(ts1Test, col = "red")
    })
    
    output$decomposePlot <- renderPlot({
        dp <- dpo %>% filter(department == input$department)
        finalColumn <- dp[,input$measure]
        ts1 <- ts(finalColumn, frequency = 4, start = c(2008, 1))
        plot(decompose(ts1), xlab = "Year+1")
    })
    
    output$dataTable <- renderTable({
        dpo %>% 
            filter(department == input$department) %>%
            select(year, quarter, CapitaIncome, Profitability, NetProfit, 
                   LaborCost, LaborCostProfitRatio, ReturnOnHumanCapital)
    })
})
