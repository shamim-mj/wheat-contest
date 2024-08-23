source('setup_database.R')
source("helpers.R")

server <- function(input, output, session) {
  data <- reactiveVal(data.frame(
    farm_name = character(),
    producer_name = character(),
    county = character(),
    add = character(),
    zip_code = character(),
    phone = character(),
    mobile = character(),


    Variety = character(),
    sowing_date = as.Date(character()),
    harvest_date = as.Date(character()),
    seed_rate = character(),
    seed_rate1 = numeric(),
    row_width = numeric(),
    tillage = character(),
    tillage_type = character(),
    fall_nitrogen_date = as.Date(character()),
    fall_nitrogen = numeric(),
    winter_nitrogen_date = as.Date(character()),
    winter_nitrogen = numeric(),
    winter_nitrogen_date2 = as.Date(character()),
    winter_nitrogen2 = numeric(),
    p2o5 = numeric(),
    k2o = numeric(),
    other_fertilizer = character(),
    other_fertilizer_rate = character(),
    other_fertilizer_date = character(),
    manure_name = character(),
    manure_amt = character(),
    manure_date = character(),

    bio_name = character(),
    bio_amt = character(),
    bion_date = character(),


    growth_name = character(),
    growth_reg_amt = character(),
    fall_nitrogen_date = character(),


    fall_fun_name = character(),
    fall_fun_rate = character(),

    spring_fun_name = character(),
    spring_fun_rate = character(),

    fall_pest_name = character(),
    fall_pest_rate = character(),
    spring_pest_name = character(),
    spring_pest_rate = character(),

    length = numeric(),
    width = numeric(),
    acres = numeric(),
    seed_moisture = numeric(),
    test_weight = numeric(),
    yield = numeric(),


    agent_name = character(),
    agent_progession = character(),
    agent_phone = character(),
    agent_email = character(),
    agent_date = character(),
    text1 = character(),
    stringsAsFactors = FALSE
  ))
  
  # image dataset
  # 
  data2 <- reactiveVal(data.frame(
    farm_name = as.character(), 
    owner_name = as.character(), 
    name = as.character(),
    image = I(list()), 
    stringsAsFactors = FALSE
  ))
  
  
  con <- dbConnect(SQLite(), "data/database.db")
  
  
  # making sure that agreement is read carefully, checked, and submitted. 
  observe({
    if (input$agreement) {
      shinyjs::enable("submit")
    } else {
      shinyjs::disable("submit")
    }
  })
  
  observeEvent(input$submit, {
    # Add the new row of data
    new_row <- data.frame(
      farm_name = ifelse(is.null(input$farm_name) || input$farm_name == "", NA, input$farm_name),
      producer_name = ifelse(is.null(input$producer_name) || input$producer_name == "", NA, input$producer_name),
      county = ifelse(is.null(input$county) || input$county == "", NA, input$county),
      address = ifelse(is.null(input$address) || input$address == "", NA, input$address),
      zip_code = ifelse(is.null(input$zip) || input$zip == "", NA, input$zip),
      phone = ifelse(is.null(input$phone) || input$phone == "", NA, input$phone),
      mobile = ifelse(is.null(input$mobile) || input$mobile == "", NA, input$mobile),
      Variety = ifelse(is.null(input$variety) || input$variety == "", NA, input$variety),
      sowing_date = ifelse(is.null(input$sowing_date), as.Date(NA), as.Date(input$sowing_date)),
      harvest_date = ifelse(is.null(input$harvest_date), as.Date(NA), input$harvest_date),
      seed_rate = ifelse(is.null(input$seed_rate), NA, input$seed_rate),
      seed_rate1 = ifelse(is.null(input$seed_rate1), NA, input$seed_rate1),
      row_width = ifelse(is.null(input$row_width), NA, input$row_width),
      tillage = ifelse(is.null(input$tillage) || input$tillage == "", NA, input$tillage),
      tillage_type = ifelse(is.null(input$tillage_type) || input$tillage_type == "", NA, input$tillage_type),
      fall_nitrogen_date = ifelse(is.null(input$fall_nitrogen_date), as.Date(NA), input$fall_nitrogen_date),
      fall_nitrogen = ifelse(is.null(input$fall_nitrogen), NA, input$fall_nitrogen),
      winter_nitrogen_date = ifelse(is.null(input$winter_nitrogen_date), as.Date(NA), input$winter_nitrogen_date),
      winter_nitrogen = ifelse(is.null(input$winter_nitrogen), NA, input$winter_nitrogen),
      winter_nitrogen_date2 = ifelse(is.null(input$winter_nitrogen_date2), as.Date(NA), input$winter_nitrogen_date2),
      winter_nitrogen2 = ifelse(is.null(input$winter_nitrogen2), NA, input$winter_nitrogen2),
      p2o5 = ifelse(is.null(input$p2o5), NA, input$p2o5),
      k2o = ifelse(is.null(input$k2o), NA, input$k2o),
      other_fertilizer = ifelse(is.null(input$other_fertilizer) || input$other_fertilizer == "", NA, input$other_fertilizer),
      other_fertilizer_rate = ifelse(is.null(input$other_fertilizer_rate), NA, input$other_fertilizer_rate),
      other_fertilizer_date = ifelse(is.null(input$other_fertilizer_date), as.Date(NA), input$other_fertilizer_date),
      manure_name = ifelse(is.null(input$manure_name) || input$manure_name == "", NA, input$manure_name),
      manure_amt = ifelse(is.null(input$manure_amt), NA, input$manure_amt),
      manure_date = ifelse(is.null(input$manure_date), as.Date(NA), input$manure_date),
      
      bio_name = ifelse(is.null(input$bio_name) || input$bio_name == "", NA, input$bio_name),
      bio_amt = ifelse(is.null(input$bio_amt), NA, input$bio_amt),
      bion_date = ifelse(is.null(input$bion_date), as.Date(NA), input$bion_date),
      
      growth_name = ifelse(is.null(input$growth_name) || input$growth_name == "", NA, input$growth_name),
      growth_reg_amt = ifelse(is.null(input$growth_reg_amt), NA, input$growth_reg_amt),
      grwoth_reg_date = ifelse(is.null(input$grwoth_reg_date), as.Date(NA), input$grwoth_reg_date),
      
      fall_fun_name = ifelse(is.null(input$fall_fun_name) || input$fall_fun_name == "", NA, input$fall_fun_name),
      fall_fun_rate = ifelse(is.null(input$fall_fun_rate), NA, input$fall_fun_rate),
      
      spring_fun_name = ifelse(is.null(input$spring_fun_name) || input$spring_fun_name == "", NA, input$spring_fun_name),
      spring_fun_rate = ifelse(is.null(input$spring_fun_rate), NA, input$spring_fun_rate),
      
      fall_pest_name = ifelse(is.null(input$fall_pest_name) || input$fall_pest_name == "", NA, input$fall_pest_name),
      fall_pest_rate = ifelse(is.null(input$fall_pest_rate), NA, input$fall_pest_rate),
      spring_pest_name = ifelse(is.null(input$spring_pest_name) || input$spring_pest_name == "", NA, input$spring_pest_name),
      spring_pest_rate = ifelse(is.null(input$spring_pest_rate), NA, input$spring_pest_rate),
      
      length = ifelse(is.null(input$length), NA, input$length),
      width = ifelse(is.null(input$width), NA, input$width),
      acres = ifelse(is.null(input$acres), NA, input$acres),
      seed_moisture = ifelse(is.null(input$seed_moisture), NA, input$seed_moisture),
      test_weight = ifelse(is.null(input$test_weight), NA, input$test_weight),
      yield = ifelse(is.null(input$yield), NA, input$yield),
      
      agent_name = ifelse(is.null(input$agent_name) || input$agent_name == "", NA, input$agent_name),
      agent_profession = ifelse(is.null(input$agent_profession) || input$agent_profession == "", NA, input$agent_profession),
      agent_phone = ifelse(is.null(input$agent_phone) || input$agent_phone == "", NA, input$agent_phone),
      agent_email = ifelse(is.null(input$agent_email) || input$agent_email == "", NA, input$agent_email),
      agent_date = ifelse(is.null(input$agent_date), as.Date(NA), input$agent_date),
      text1 = ifelse(is.null(input$text1) || input$text1 == "", NA, input$text1),
      
      stringsAsFactors = FALSE
    )
    
    
    if (!is.null(input$image_upload)) {
      img_path <- input$image_upload$datapath
      img_name <- input$image_upload$name
      img_data <- readBin(img_path, what = "raw", n = file.info(img_path)$size)
      
      # Store the image in the database with farm name and owner name

      new_row2 = data.frame(
        farm_name = ifelse(is.null(input$farm_name) || input$farm_name == "", NA, input$farm_name), 
        owner_name = ifelse(is.null(input$producer_name) || input$producer_name == "", NA, input$producer_name),
        name = img_name, 
        image = I(list(img_data)), 
        
        stringsAsFactors = FALSE
      )
      
      # updated_data2 <- rbind(data2(), new_row2)
      # data(updated_data2)

      dbWriteTable(con, "images", value = new_row2,
      append = TRUE, row.names = FALSE)
    }
    
    
    #Append new row to existing data
    updated_data <- rbind(data(), new_row)
    data(updated_data)
    #print(updated_data)
    
    # Insert the new row into the database
    dbWriteTable(con, "farm_data", value = updated_data, append = TRUE, row.names = FALSE)

    # Show a confirmation message
    showModal(modalDialog(
      title = "Data Submitted",
      "Your data has been successfully submitted!",
      easyClose = TRUE,
      footer = NULL
    ))
    
    # Clear the form fields
    updateTextInput(session, "farm_name", value = "")
    updateTextInput(session, "producer_name", value = "")
    updateTextInput(session, "county", value = "")
    updateTextInput(session, "address", value = "")
    updateTextInput(session, "zip", value = "")
    updateTextInput(session, "phone", value = "")
    updateTextInput(session, "mobile", value = "")
    updateTextInput(session, "variety", value = "")
    updateDateInput(session, "sowing_date", value = NULL)
    updateDateInput(session, "harvest_date", value = NULL)
    updateNumericInput(session, "seed_rate", value = 0)
    updateNumericInput(session, "seed_rate1", value = 0)
    updateNumericInput(session, "row_width", value = 0)
    updateTextInput(session, "tillage", value = "")
    updateTextInput(session, "tillage_type", value = "")
    updateDateInput(session, "fall_nitrogen_date", value = NULL)
    updateNumericInput(session, "fall_nitrogen", value = 0)
    updateDateInput(session, "winter_nitrogen_date", value = NULL)
    updateNumericInput(session, "winter_nitrogen", value = 0)
    updateDateInput(session, "winter_nitrogen_date2", value = NULL)
    updateNumericInput(session, "winter_nitrogen2", value = 0)
    updateNumericInput(session, "p2o5", value = 0)
    updateNumericInput(session, "k2o", value = 0)
    updateTextInput(session, "other_fertilizer", value = "")
    updateTextInput(session, "other_fertilizer_rate", value = 0)
    updateDateInput(session, "other_fertilizer_date", value = NULL)
    updateTextInput(session, "manure_name", value = "")
    updateTextInput(session, "manure_amt", value = 0)
    updateDateInput(session, "manure_date", value = NULL)
    
    updateTextInput(session, "bio_name", value = "")
    updateTextInput(session, "bio_amt", value = NA)
    updateDateInput(session, "bion_date", value = NULL)
    
    updateTextInput(session, "growth_name", value = "")
    updateTextInput(session, "growth_reg_amt", value = NA)
    updateDateInput(session, "grwoth_reg_date", value = NULL)
    
    updateTextInput(session, "fall_fun_name", value = "")
    updateTextInput(session, "fall_fun_rate", value = NA)
    
    updateTextInput(session, "spring_fun_name", value = "")
    updateTextInput(session, "spring_fun_rate", value = NA)
    
    updateTextInput(session, "fall_pest_name", value = "")
    updateTextInput(session, "fall_pest_rate", value = NA)
    updateTextInput(session, "spring_pest_name", value = "")
    updateTextInput(session, "spring_pest_rate", value = NA)
    
    updateNumericInput(session, "length", value = NA)
    updateNumericInput(session, "width", value = NA)
    updateNumericInput(session, "acres", value = NA)
    updateNumericInput(session, "seed_moisture", value = NA)
    updateNumericInput(session, "test_weight", value = NA)
    updateNumericInput(session, "yield", value = NA)
    
    updateTextInput(session, "agent_name", value = "")
    updateTextInput(session, "agent_profession", value = "")
    updateTextInput(session, "agent_phone", value = "")
    updateTextInput(session, "agent_email", value = "")
    updateDateInput(session, "agent_date", value = NULL)
    updateTextInput(session, "text1", value = "")
    
    dbDisconnect(conn = con)
  })
  
  # output$data_table <- renderTable({
  #   data()
  # })
  # 
  # Download data with a password check
  # 
  # 
  # Download data with a password check
  


}







