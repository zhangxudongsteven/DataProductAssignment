
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
    navbarPage(
        "Human Resource Dashboard",
        tabPanel(
            "Synopsis",
            h3("Human Resource Dashboard Demo"),
            hr(),
            h4("Introduction"),
            helpText("This data was made up by a data analyst, in order to use in a HTML5 Dashboard Building."),
            helpText("During the building, the data will follow the following 7 basic principles"),
            helpText(" - Use a normal distribution with a gradual increase trend to make up data. "),
            helpText(" - Generally, each year will have 7% increasement. "),
            helpText(" - The standard deviation will be one-tenth the mean. "),
            helpText(" - The 6 departments are named A to F, and their member are 100 to 600. "),
            helpText(" - For a larger department, their figures will be lower. To be specific, with 100 more members, there will be 0.5% drop in all figures, which based on 100 members with 100% ratio. "),
            helpText(" - For each month, there will be a standerd fluctuation. "),
            helpText(" - The final figure should be influenced by a random ratio, which follow a N~(1,0.07) distribution."),
            h4("Data Description"),
            p("A data frame with 648 observations on 4 dimensions and 6 measures"),
            p("  [, 1]  year       Year (2008 - 2016)"),
            p("  [, 2]	 quarter    Quarter (Q1, Q2, Q3, Q4)"),
            p("  [, 3]	 month      Month (1 - 12)"),
            p("  [, 4]	 department 6 Department (A - F)"),
            p("  [, 5]	 CapitaIncome           Total Amount of Capita Income"),
            p("  [, 6]	 Profitability          Total Amount of Profit"),
            p("  [, 7]	 NetProfit              Total Amount of Net Profit"),
            p("  [, 8]	 LaborCost              Total Amount of Labor Cost"),
            p("  [, 9]	 LaborCostProfitRatio   Average of Labor Cost"),
            p("  [,10]	 ReturnOnHumanCapital   Average Return on Human Capital"),
            hr(),
            h4(" - December 9, 2016")
        ),
        tabPanel(
            "Analysis",
            h3("Time Serise Analysis"),
            hr(),
            fluidPage(
                sidebarLayout(
                    sidebarPanel(
                        selectInput(
                            "measure", "Measure:",
                            c("Total Amount of Capita Income" = "CapitaIncome",
                              "Total Amount of Profit" = "Profitability",
                              "Total Amount of Net Profit" = "NetProfit",
                              "Total Amount of Labor Cost" = "LaborCost",
                              "Average of Labor Cost" = "LaborCostProfitRatio",
                              "Average Return on Human Capital" = "ReturnOnHumanCapital"
                              )
                            ),
                        selectInput(
                            "department", "Department:",
                            c("Department A" = "A",
                              "Department B" = "B",
                              "Department C" = "C",
                              "Department D" = "D",
                              "Department E" = "E",
                              "Department F" = "F"
                            )
                        )
                    ),
                    mainPanel(
                        h4("Diagram"),
                        hr(),
                        tabsetPanel(
                            type = "tabs",
                            tabPanel(
                                "Forecast Plot", 
                                plotOutput("forecastPlot")
                            ),
                            tabPanel(
                                "Decompose of Time Series", 
                                plotOutput("decomposePlot")
                            ),
                            tabPanel(
                                "Corresponding Data",
                                tableOutput("dataTable")
                            )
                        )
                    )
                )
            )
        ),
        tabPanel(
            "Data Generating Process",
            tags$iframe(
                src="data_generating.html", 
                width="100%", 
                height=600, 
                frameborder=0, 
                seamless=NA)
        )
    )
)

