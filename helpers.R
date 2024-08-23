check_password <- function(input_password) {
  stored_password <- Sys.getenv("DB_PASSWORD")
  return(input_password == stored_password)
}




