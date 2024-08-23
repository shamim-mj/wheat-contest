
county_names <- fread(input = "county_names.txt")

ui <- dashboardPage(
  dashboardHeader(title = "Wheat Data Collection"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidPage(
      titlePanel("KENTUCKY WHEAT YIELD CONTEST REGISTRATION FORM"),
      
      fluidRow(
        box(
          title = "PRODUCER INFORMATION", status = "primary", solidHeader = TRUE, width = 12,
          column(4, textInput("farm_name", "FARM")),
          column(4, textInput("producer_name", "PRODUCER")),
          column(4, selectInput("county", "COUNTY", choices = county_names$County, selected = "Adair")),
          column(4, textInput("address", "ADDESS")),
          column(4, textInput("zip", "ZIP CODE")),
          column(4, textInput("phone", "PHONE")),
          column(4, textInput("mobile", "MOBILE"))
        )
      ),
      
      fluidRow(
        box(
          title = "VARIETY ADN TILLAGE INFORMATION", status = "primary", solidHeader = TRUE, width = 12,
          column(4, textInput("variety", "VARIETY NAME")),
          column(4, dateInput("sowing_date", "SOWING DATE")),
          column(4, dateInput("harvest_date", "HARVEST DATE")), 
          column(4, selectInput("seed_rate", "SEEDING RATE", choices = c("seed/ac",
                                                                         "lb/ac"))),
          column(4, numericInput("seed_rate1", "SEEDING RATE", value = 1800000)),
          column(4, numericInput("row_width", "ROW WIDTH (IN)", value = 7.5)),
          column(4, selectInput('tillage', label = "TILLAGE", choices = c("NO-TILL",
                                                                          "CONVENTIONAL",
                                                                          "MINIMAL"))),
          column(4, textInput("tillage_type", "TILLAGE TYPE [if other than no-till]")),
        )
      ),
      
      fluidRow(
        box(
          title = "FERTILIZER", status = "primary",
          solidHeader = TRUE, width = 12,
          h5("Please include all fertilizers in the [OTHER FERTLIZER] section and sepate them with a comma"),
          fluidRow(
            column(6,
                   h3("NITROGEN"),
                  dateInput("fall_nitrogen_date", "FALL"),
                  numericInput("fall_nitrogen", "RATE (lb/ac)", value = 0),
                  dateInput("winter_nitrogen_date", "WINTER/SPRING  (First)"),
                  numericInput("winter_nitrogen", "RATE (lb/ac)", value = 0),
                  dateInput("winter_nitrogen_date2", "WINTER/SPRING (Second)"),
                  numericInput("winter_nitrogen2", "RATE (lb/ac)", value = 0)
                  ),
            column(6,
                   h3("PHOSPHORUS"),
                  numericInput("p2o5", "P2O5 (lb/ac)", value = 0)
                  ),
            column(6,
                   h3("POTASSIUM"),
                  numericInput("k2o", "K2O (lb/ac)", value = 0)
                  ),
            column(6,
                   h3("OTHER"),
                textInput('other_fertilizer',
                                    label = "FERTILIZER "),
                textInput('other_fertilizer_rate',
                                    label = "RATE"),
                textInput("other_fertilizer_date", "DATE [yyyy-mm-dd]")
                )
                
          )
        )
        ),
      
      fluidRow(
        box(
          title = "MANURE", status = "primary", solidHeader = TRUE, width = 12,
          h5("Please include all manure applicaitons within the last 18 months. If you have used more than one item or if you have applied the same item more than once, please separate it with a comma"),
          column(4, textInput('manure_name',
                              label = "NAME")),
          column(4, textInput("manure_amt", "AMOUNT (tons/ac)")),
          column(4, textInput("manure_date", "DATE [yyyy-mm-dd]")),
          
        )
      ),
      
      fluidRow(
        box(
          title = "BIOSTIMULANTS & BIOLOGICALS", status = "primary", solidHeader = TRUE, width = 12,
          h5("If you have used more than one growth regulators, please separate them with a comma"),
          
          column(4, textInput('bio_name',
                              label = "NAME")),
          column(4, textInput("bio_amt", "AMOUNT (oz/ac)")),
          column(4, textInput("bion_date", "DATE [yyyy-mm-dd]")),
          
        )
      ),
      
      
      fluidRow(
        box(
          title = "GROWTH REGULATORS", status = "primary", solidHeader = TRUE, width = 12,
          h5("If you have used more than one growth regulators, please separate them with a comma"),
          
          column(4, textInput('growth_name',
                              label = "NAME")),
          column(4, textInput("growth_reg_amt", "AMOUNT (oz/ac)", value = 0)),
          column(4, textInput("growth_reg_date", "DATE [yyyy-mm-dd]")),
          
        )
      ),
      
      
      fluidRow(
        box(
          title = "FUNGICIDES", status = "primary", solidHeader = TRUE, width = 12,
          h5("If you have used more than one fungicide, please separate them with a comma"),
          
          fluidRow(
            column(6, 
                   h3("FALL"),
                   textInput("fall_fun_name", "NAME"),
                   textInput("fall_fun_rate", "RATE (oz/ac)", value = 0)
            ),
            column(6, 
                   h3("SPRING"),
                   textInput("spring_fun_name", "NAME"),
                   textInput("spring_fun_rate", "RATE (oz/ac)", value = 0)
            )
          )
        )
      ),
      
      
      fluidRow(
        box(
          title = "PESTICIDES", status = "primary", solidHeader = TRUE, width = 12,
          h5("If you have used more than one pesticide, please separate them with a comma"),
          
          fluidRow(
            column(6, 
                   h3("FALL"),
                   textInput("fall_pest_name", "NAME"),
                   textInput("fall_pest_rate", "RATE (oz/ac)", value = 0)
            ),
            column(6, 
                   h3("SPRING"),
                   textInput("spring_pest_name", "NAME"),
                   textInput("spring_pest_rate", "RATE (oz/ac)", value = 0)
            )
          )
        )
      ),
      
      
      
      fluidRow(
        box(
          title = "HARVESTED INFORMATION", status = "primary", solidHeader = TRUE, width = 12,
          
          # Structured Notes
          tags$ul(
            tags$li("Calculate acreage using the formula and enter the number in the ACRES field:"),
            tags$ul(
              tags$li("Acreage = (Length x Width) / 43,560")
            ),
            tags$li("Calculate yield using the formula and enter the information in the YIELD field:"),
            tags$ul(
              tags$li("Yield (bu/ac) = (Yield (lb) from Harvested area x [(100 - Grain Moisture%) / 86.5]) / 60 / harvested acres")
            )
          ),
          
          fluidRow(
            column(4, numericInput("length", "LENGTH (ft; one decimal)", value = 0)),
            column(4, numericInput("width", "WIDTH (ft; one decimal)", value = 0)),
            column(4, numericInput("acres", "ACRES (2 decimals)", value = 0)),
            column(4, numericInput("seed_moisture", "Moisture (%; 1 decimal)", value = 0)),
            column(4, numericInput("test_weight", "TEST WEIGHT (1 decimal)", value = 0)),
            column(4, numericInput("yield", "YIELD (bu/ac) (2 decimals)", value = 0))
          )
        )
      ),
      
      
      fluidRow(
        box(
          title = "SUPERVISOR INFORMATION", status = "primary", solidHeader = TRUE, width = 12,
          column(4, textInput("agent_name", "NAME")),
          column(4, textInput("agent_profession", "PROFESSION")),
          column(4, textInput("agent_phone", "PHONE")),
          column(4, textInput("agent_email", "EMAIL")),
          column(4, dateInput("agent_date", "DATE")),
          column(4, textAreaInput('text1', label = "COMMENTS", value = "")),
          
        )
      ),
      # actionButton("submit", "Submit"),
      # hr(),
      # tableOutput("data_table"),
      
      
      # fluidRow(
      #   box(
      #     title = "Admin Use Only", status = "danger", solidHeader = TRUE, width = 12,
      #     h5("This section is for administrative tasks only."),
      #     passwordInput("download_password", "Enter Password to Download Data"),
      #     downloadButton("download_data", "Download Data")
      #   )
      # )
      # 
      # 
      # 
      fluidRow(
        box(
          title = "Upload Image", status = "primary", solidHeader = TRUE, width = 12),
        h5("Please upload images of the following documents:"),
        tags$ul(
          tags$li("Field map"),
          tags$li("Calculations"),
          tags$li("Weight ticket")
        ),
        h5("Instructions:"),
        tags$ul(
          tags$li("Your calculations must be clearly written beneath the field map."),
          tags$li("The map does not need to be fancy; a simple sketch showing the dimensions of the harvested area will suffice."),
          tags$li("Draw your field map and perform calculations on a sheet of paper."),
          tags$li("Place your weight ticket at the bottom of the paper and take a picture of it.")
        ),
        
        
        fluidRow(
          column(6, 
                 fileInput("image_upload", "Choose an Image", accept = c('image/png', 'image/jpeg'))
          ),
        #   column(6, 
        #          h3("Calculation & Field Maps"),
        #          fileInput("image_upload2", "Choose an Image", accept = c('image/png', 'image/jpeg'))
        # )
      )
    ),
      # 
      # 
      # 
      useShinyjs(),
      fluidRow(
        box(
          title = "Submission", status = "primary", solidHeader = TRUE, width = 12,
          
          # Statement with a checkbox
          checkboxInput("agreement", label = HTML("I, the undersigned, supervised the harvesting, weighing, moisture testing and reporting as prescribed in the rules and regulations of the 2024 Kentucky Extension Wheat Contest. To the best of my knowledge, these figures are accurate. I do not have financial or direct business ties to a company that sells agribusiness supplies or services to this operation."), value = FALSE),
          
          # Submit button, disabled until checkbox is ticked
          actionButton("submit", "Submit", disabled = TRUE)
        )
      )
      
    )
  )
)
