# Create a new SQLite database (or connect to it if it already exists)
  if (!dir.exists("data")) {
    dir.create("data")
  }
con <- dbConnect(SQLite(), "data/database.db")

  

# Define the schema for the table
dbExecute(con, "
  CREATE TABLE IF NOT EXISTS farm_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    farm_name TEXT,
    producer_name TEXT,
    county TEXT,
    address TEXT,
    zip_code TEXT,
    phone TEXT,
    mobile TEXT,
    Variety TEXT,
    sowing_date DATE,
    harvest_date DATE,
    seed_rate text,
    seed_rate1 NUMERIC,
    row_width NUMERIC,
    tillage TEXT,
    tillage_type TEXT,
    fall_nitrogen_date DATE,
    fall_nitrogen NUMERIC,
    winter_nitrogen_date DATE,
    winter_nitrogen NUMERIC,
    winter_nitrogen_date2 DATE,
    winter_nitrogen2 NUMERIC,
    p2o5 NUMERIC,
    k2o NUMERIC,
    other_fertilizer TEXT,
    other_fertilizer_rate TEXT,
    other_fertilizer_date TEXT,
    manure_name TEXT,
    manure_amt TEXT,
    manure_date TEXT,
    bio_name TEXT,
    bio_amt TEXT,
    bion_date TEXT,
    growth_name TEXT,
    growth_reg_amt TEXT,
    grwoth_reg_date TEXT,
    fall_fun_name TEXT,
    fall_fun_rate TEXT,
    spring_fun_name TEXT,
    spring_fun_rate TEXT,
    fall_pest_name TEXT,
    fall_pest_rate TEXT,
    spring_pest_name TEXT,
    spring_pest_rate TEXT,
    length NUMERIC,
    width NUMERIC,
    acres NUMERIC,
    seed_moisture NUMERIC,
    test_weight NUMERIC,
    yield NUMERIC,
    agent_name TEXT,
    agent_profession TEXT,
    agent_phone TEXT,
    agent_email TEXT,
    agent_date DATE,
    text1 TEXT
  )
")

dbExecute(con, "
  CREATE TABLE IF NOT EXISTS images (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    farm_name TEXT,
    owner_name TEXT,
    name TEXT,
    image BLOB
  )
")



# Close the connection
dbDisconnect(con)
