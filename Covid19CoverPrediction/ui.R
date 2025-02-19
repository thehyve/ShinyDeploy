# @file Ui.R
#
# Copyright 2018 Observational Health Data Sciences and Informatics
#
# This file is part of PatientLevelPrediction
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

library(shiny)
library(plotly)
library(shinycssloaders)
library(shinydashboard)
if(!require(shiny.i18n)){install.packages('shiny.i18n')}
# require(shiny.i18n)
addInfo <- function(item, infoId) {
  infoTag <- tags$small(class = "badge pull-right action-button",
                        style = "padding: 1px 6px 2px 6px; background-color: steelblue;",
                        type = "button", 
                        id = infoId,
                        "i")
  item$children[[1]]$children <- append(item$children[[1]]$children, list(infoTag))
  return(item)
}

#translation
# i18n <- Translator$new(translation_csvs_path = "./data/translation/")
# i18n$set_translation_language("en")
translationFiles <-  list.files("./www/languages/translation")
translationChoices <- c("en")
translationChoices <- append(translationChoices, gsub(".*_|.c.*", "", translationFiles))
translationChoices <- translationChoices[translationChoices != "Xx"]
ui <- shinydashboard::dashboardPage(skin = 'black',
                                    
                                    shinydashboard::dashboardHeader(title = "Multiple PLP Viewer", 
                                                                    
                                                                    tags$li(div(img(src = 'logo.png',
                                                                                    title = "OHDSI PLP", height = "40px", width = "40px"),
                                                                                style = "padding-top:0px; padding-bottom:0px;"),
                                                                            class = "dropdown")
                                                                    
                                                                    
                                    ), 
                                    
                                    shinydashboard::dashboardSidebar(
                                      shinydashboard::sidebarMenu(
                                        addInfo(shinydashboard::menuItem("Description", tabName = "Description", icon = shiny::icon("home")), "DescriptionInfo"),
                                        addInfo(shinydashboard::menuItem("Calculate Risk", tabName = "Risk", icon = shiny::icon("heartbeat")), "RiskInfo"),
                                        addInfo(shinydashboard::menuItem("Summary", tabName = "Summary", icon = shiny::icon("table")), "SummaryInfo"),
                                        addInfo(shinydashboard::menuItem("Performance", tabName = "Performance", icon = shiny::icon("bar-chart")), "PerformanceInfo"),
                                        addInfo(shinydashboard::menuItem("Model", tabName = "Model", icon = shiny::icon("clipboard")), "ModelInfo"),
                                        addInfo(shinydashboard::menuItem("Log", tabName = "Log", icon = shiny::icon("list")), "LogInfo"),
                                        addInfo(shinydashboard::menuItem("Data Info", tabName = "DataInfo", icon = shiny::icon("database")), "DataInfoInfo"),
                                        addInfo(shinydashboard::menuItem("Help", tabName = "Help", icon = shiny::icon("info")), "HelpInfo")
                                      )
                                    ),
                                    
                                    shinydashboard::dashboardBody(
                                      shinydashboard::tabItems(
                                        
                                        # help tab
                                        shinydashboard::tabItem(tabName = "Help",
                                                                shiny::h2("Information"),
                                                                shiny::p("Click on a row to explore the results for that model.  When you wish to explore a different model, then select the new result row and the tabs will be updated."),
                                                                shiny::a("Demo Video", href = 'https://youtu.be/StpV40yl1UE', target='_blank')
                                        ),
                                        
                                        # First tab content
                                        shinydashboard::tabItem(tabName = "Description",
                                                                shiny::includeMarkdown(path = "./www/shinyDescription.md")
                                                                
                                        ),
                                        shinydashboard::tabItem(tabName = "Risk", 
                                                                shiny::selectInput("language",'Language', choices = translationChoices),
                                                                shiny::uiOutput("risktabside"),                                                                
                                                                shiny::uiOutput("risktabmain")
                                                                
                                                                # sidebarPanel(
                                                                #   shiny::p(i18n$t('Use this tool to calculate the risk of COVID outcomes: ')),
                                                                #   shiny::p(' '),
                                                                #   shiny::sliderInput("age", i18n$t("Age:"),
                                                                #                      min = 18, max = 94,
                                                                #                      value = 50),
                                                                #   shiny::selectInput("sex",i18n$t("Sex"), choices = c(i18n$t("Male"), i18n$t("Female"))),
                                                                #   shiny::checkboxInput("cancer", i18n$t("History of Cancer")),
                                                                #   shiny::checkboxInput("copd", i18n$t("History of COPD")),
                                                                #   shiny::checkboxInput("diabetes", i18n$t("History of Diabetes")),
                                                                #   shiny::checkboxInput("hd", i18n$t("History of Heart disease")),
                                                                #   shiny::checkboxInput("hl", i18n$t("History of Hyperlipidemia")),
                                                                #   shiny::checkboxInput("hypertension", i18n$t("History of Hypertension")),
                                                                #   shiny::checkboxInput("kidney",i18n$t("History of Kidney Disease")),
                                                                #   shiny::actionButton("calculate",i18n$t("Calculate Risk")),
                                                                #   hr()
                                                                # 
                                                                # ),
                                                                # mainPanel(
                                                                #   conditionalPanel('input.calculate', {
                                                                #     shinydashboard::box(width = 12,
                                                                #                         title = tagList(shiny::icon("bar-chart"),i18n$t("Predicted Risk (%)")), status = "info", solidHeader = TRUE,
                                                                # 
                                                                #                         plotly::plotlyOutput("contributions"))}
                                                                # 
                                                                #   ),
                                                                #   shinydashboard::box(
                                                                #     status = "primary", solidHeader = TRUE,
                                                                #     width = 12,
                                                                #     shiny::h2("Description"),
                                                                #     # shiny::p("The Observational Health Data Sciences and Informatics (OHDSI) international community is hosting a COVID-19 virtual study-a-thon this week (March 26-29) to inform healthcare decision-making in response to the current global pandemic."),
                                                                #     shiny::p("This calculator presents the results of a prediction study that developed 3 prediction models."),
                                                                #     shiny::p("The three models predicted: requiring hospital admission (COVER-H), requiring intensive services (COVER-I), or fatality (COVER-F) in the month following COVID-19 diagnosis"),
                                                                #     shiny::p(' '),
                                                                #     shiny::h3("Disclaimer"),
                                                                #     shiny::p('Should not be considered Medical Advice.
                                                                #          By using the app, you acknowledge that the content does not constitute medical advice and does not create a Healthcare Professional - Patient relationship and does not constitute medical opinion or advice.
                                                                #          Access to general information is provided for research and educational purposes only.
                                                                #          Content is not recommended or endorsed by any doctor or healthcare provider.
                                                                #          The information provided is not a substitute for medical or professional care,
                                                                #          and you should not use the information in place of an appointment or the advice of your physician or other healthcare provider.
                                                                #          You are liable or responsible for any action taken through use of information in this site.'), #Todo: add disclaimer
                                                                #   ),                                                                  )
                                                                
                                        ),                     
                                        
                                        shinydashboard::tabItem(tabName = "DataInfo",
                                                                shiny::includeMarkdown(path = "./www/dataInfo.md")
                                                                
                                        ),
                                        shinydashboard::tabItem(tabName = "Summary",
                                                                
                                                                shiny::fluidRow(
                                                                  shiny::column(2, 
                                                                                shiny::h4('Filters'),
                                                                                shiny::selectInput('modelSettingName', 'Model:', c('All',unique(as.character(summaryTable$Model)))),
                                                                                shiny::selectInput('devDatabase', 'Development Database', c('All',unique(as.character(summaryTable$Dev)))),
                                                                                shiny::selectInput('valDatabase', 'Validation Database', c('All',unique(as.character(summaryTable$Val)))),
                                                                                shiny::selectInput('T', 'Target Cohort', c('All',unique(as.character(summaryTable$`T`)))),
                                                                                shiny::selectInput('O', 'Outcome Cohort', c('All',unique(as.character(summaryTable$`O`)))),
                                                                                shiny::selectInput('riskWindowStart', 'Time-at-risk start:', c('All',unique(as.character(summaryTable$`TAR start`)))),
                                                                                shiny::selectInput('riskWindowEnd', 'Time-at-risk end:', c('All',unique(as.character(summaryTable$`TAR end`))))
                                                                  ),  
                                                                  shiny::column(10, style = "background-color:#F3FAFC;",
                                                                                
                                                                                # do this inside tabs:
                                                                                shiny::tabsetPanel(
                                                                                  
                                                                                  shiny::tabPanel("Results",
                                                                                                  shiny::div(DT::dataTableOutput('summaryTable'), 
                                                                                                             style = "font-size:70%")),
                                                                                  
                                                                                  shiny::tabPanel("Model Settings",
                                                                                                  shiny::h3('Model Settings: ', 
                                                                                                            shiny::a("help", href="https://ohdsi.github.io/PatientLevelPrediction/reference/index.html", target="_blank") 
                                                                                                  ),
                                                                                                  DT::dataTableOutput('modelTable')),
                                                                                  
                                                                                  shiny::tabPanel("Population Settings",
                                                                                                  shiny::h3('Population Settings: ', 
                                                                                                            shiny::a("help", href="https://ohdsi.github.io/PatientLevelPrediction/reference/createStudyPopulation.html", target="_blank") 
                                                                                                  ),
                                                                                                  DT::dataTableOutput('populationTable')),
                                                                                  
                                                                                  shiny::tabPanel("Covariate Settings",
                                                                                                  shiny::h3('Covariate Settings: ', 
                                                                                                            shiny::a("help", href="http://ohdsi.github.io/FeatureExtraction/reference/createCovariateSettings.html", target="_blank") 
                                                                                                  ),
                                                                                                  DT::dataTableOutput('covariateTable'))
                                                                                )
                                                                                
                                                                  )
                                                                  
                                                                )),
                                        # second tab
                                        shinydashboard::tabItem(tabName = "Performance", 
                                                                
                                                                shiny::fluidRow(
                                                                  tabBox(
                                                                    title = "Performance", 
                                                                    # The id lets us use input$tabset1 on the server to find the current tab
                                                                    id = "tabset1", height = "100%", width='100%',
                                                                    tabPanel("Summary", 
                                                                             
                                                                             shiny::fluidRow(
                                                                               shiny::column(width = 4,
                                                                                             shinydashboard::box(width = 12,
                                                                                                                 title = tagList(shiny::icon("question"),"Prediction Question"), status = "info", solidHeader = TRUE,
                                                                                                                 shiny::textOutput('info')
                                                                                             ),
                                                                                             shinydashboard::box(width = 12,
                                                                                                                 title = tagList(shiny::icon("gear"), "Input"), 
                                                                                                                 status = "info", solidHeader = TRUE,
                                                                                                                 shiny::splitLayout(
                                                                                                                   cellWidths = c('5%', '90%', '5%'),
                                                                                                                   shiny::h5(' '),
                                                                                                                   shiny::sliderInput("slider1", 
                                                                                                                                      shiny::h4("Threshold value slider: ", strong(shiny::textOutput('threshold'))), 
                                                                                                                                      min = 1, max = 100, value = 50, ticks = F),
                                                                                                                   shiny::h5(' ')
                                                                                                                 ),
                                                                                                                 shiny::splitLayout(
                                                                                                                   cellWidths = c('5%', '90%', '5%'),
                                                                                                                   shiny::h5(strong('0')),
                                                                                                                   shiny::h5(' '),
                                                                                                                   shiny::h5(strong('1'))
                                                                                                                 ),
                                                                                                                 shiny::tags$script(shiny::HTML("
                                                                                                                                                $(document).ready(function() {setTimeout(function() {
                                                                                                                                                supElement = document.getElementById('slider1').parentElement;
                                                                                                                                                $(supElement).find('span.irs-max, span.irs-min, span.irs-single, span.irs-from, span.irs-to').remove();
                                                                                                                                                }, 50);})
                                                                                                                                                "))
                                                                                             )
                                                                                             
                                                                               ),
                                                                               
                                                                               
                                                                               shiny::column(width = 8,
                                                                                             shinydashboard::box(width = 12,
                                                                                                                 title = "Dashboard",
                                                                                                                 status = "warning", solidHeader = TRUE,
                                                                                                                 shinydashboard::infoBoxOutput("performanceBoxThreshold"),
                                                                                                                 shinydashboard::infoBoxOutput("performanceBoxIncidence"),
                                                                                                                 shinydashboard::infoBoxOutput("performanceBoxPPV"),
                                                                                                                 shinydashboard::infoBoxOutput("performanceBoxSpecificity"),
                                                                                                                 shinydashboard::infoBoxOutput("performanceBoxSensitivity"),
                                                                                                                 shinydashboard::infoBoxOutput("performanceBoxNPV")
                                                                                                                 
                                                                                             ),
                                                                                             shinydashboard::box(width = 12,
                                                                                                                 title = "Cutoff Performance",
                                                                                                                 status = "warning", solidHeader = TRUE,
                                                                                                                 shiny::tableOutput('twobytwo')
                                                                                                                 #infoBoxOutput("performanceBox"),
                                                                                             )
                                                                               )
                                                                             )
                                                                             
                                                                             
                                                                    ),
                                                                    tabPanel("Discrimination", 
                                                                             
                                                                             shiny::fluidRow(
                                                                               shinydashboard::box( status = 'info',
                                                                                                    title = actionLink("rocHelp", "ROC Plot", icon = icon("info")),
                                                                                                    solidHeader = TRUE,
                                                                                                    shinycssloaders::withSpinner(plotly::plotlyOutput('roc'))),
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("prcHelp", "Precision recall plot", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   side = "right",
                                                                                                   shinycssloaders::withSpinner(plotly::plotlyOutput('pr')))),
                                                                             
                                                                             shiny::fluidRow(
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("f1Help", "F1 Score Plot", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   shinycssloaders::withSpinner(plotly::plotlyOutput('f1'))),
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("boxHelp","Box Plot", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   side = "right",
                                                                                                   shinycssloaders::withSpinner(shiny::plotOutput('box')))),
                                                                             
                                                                             shiny::fluidRow(
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("predDistHelp","Prediction Score Distribution", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   shinycssloaders::withSpinner(shiny::plotOutput('preddist'))),
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("prefDistHelp","Preference Score Distribution", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   side = "right",
                                                                                                   shinycssloaders::withSpinner(shiny::plotOutput('prefdist'))))
                                                                             
                                                                             
                                                                    ),
                                                                    tabPanel("Calibration", 
                                                                             shiny::fluidRow(
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("calHelp","Calibration Plot", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   shinycssloaders::withSpinner(shiny::plotOutput('cal'))),
                                                                               shinydashboard::box(status = 'info',
                                                                                                   title = actionLink("demoHelp","Demographic Plot", icon = icon("info")),
                                                                                                   solidHeader = TRUE,
                                                                                                   side = "right",
                                                                                                   shinycssloaders::withSpinner(shiny::plotOutput('demo')))
                                                                             )
                                                                    )
                                                                  ))),
                                        
                                        # 3rd tab
                                        shinydashboard::tabItem(tabName = "Model", 
                                                                shiny::fluidRow(
                                                                  shinydashboard::box( status = 'info',
                                                                                       title = "Binary", solidHeader = TRUE,
                                                                                       shinycssloaders::withSpinner(plotly::plotlyOutput('covariateSummaryBinary'))),
                                                                  shinydashboard::box(status = 'info',
                                                                                      title = "Measurements", solidHeader = TRUE,
                                                                                      side = "right",
                                                                                      shinycssloaders::withSpinner(plotly::plotlyOutput('covariateSummaryMeasure')))),
                                                                shiny::fluidRow(width=12,
                                                                                shinydashboard::box(status = 'info', width = 12,
                                                                                                    title = "Covariates", solidHeader = TRUE,
                                                                                                    DT::dataTableOutput('modelCovariateInfo'))),
                                                                shiny::fluidRow(width=12,
                                                                                shinydashboard::box(status = 'info', width = 12,
                                                                                                    title = "Model Table", solidHeader = TRUE,
                                                                                                    shiny::downloadButton("downloadData", "Download Model"),
                                                                                                    DT::dataTableOutput('modelView')))
                                        ),
                                        
                                        # 4th tab
                                        shinydashboard::tabItem(tabName = "Log", 
                                                                shiny::verbatimTextOutput('log')
                                        )
                                        
                                        
                                      )
                                    )
)