# To set up the data, we want to parse and evaluate the script file 
# with the primary goal of removing the appended .factor. 
# The function redcap_to_r_data_set does just that. 
# It takes two arguments; The first is redcap_data_file, which is the path 
# to the REDCap data set. The second is redcap_script_file, which is the path to the REDCap script file.

# from https://www.waderstats.com/redcap-to-r-data-set/

redcap_to_r_data_set <- function(redcap_data_file, redcap_script_file) {
  # Read in the data and script file.
  redcap_data <- read.csv(file = redcap_data_file, stringsAsFactors = FALSE)
  redcap_script <- readLines(redcap_script_file)
  
  # We want to remove the appended .factor, but since releveling the numerically coded data erases the labels, we need to reorder the file so that the labels are last.
  # Every line in the script file that uses the factor() function
  redcap_factor <- redcap_script[grep("factor\\(", redcap_script)]
  
  # Every line in the script file that uses the levels() function
  redcap_levels <- redcap_script[grep("levels\\(", redcap_script)]
  
  # Every line in the script file that begins with the label function
  redcap_label <- redcap_script[grep("^label\\(", redcap_script)]
  
  # Reorder the chunks in the script file.
  redcap_reorder <- c(redcap_factor, "", redcap_levels, "", redcap_label)
  
  # Remove the appended .factor.
  redcap_no_append <- gsub("\\.factor", "", redcap_reorder)
  
  # REDCap defaults to calling the data 'data'.  Before evaluating, we need to change this to what the data is named here.
  redcap_rename <- gsub("data\\$", "redcap_data\\$", redcap_no_append)
  
  # Now we can safely evaluate the script file.
  eval(parse(text = redcap_rename))
  
  return(redcap_data)
}

data_uk <- redcap_to_r_data_set(
  redcap_data_file = "data/TemperatureControlSu_DATA_2023-05-31_1154.csv", 
  redcap_script_file = "TemperatureControlSu_R_2023-05-31_1154.r"
  )
data_anz <- redcap_to_r_data_set(
  redcap_data_file = "data/TemperatureControlSu_DATA_2023-05-31_1959.csv", 
  redcap_script_file = "TemperatureControlSu_R_2023-05-31_1959.r"
)






