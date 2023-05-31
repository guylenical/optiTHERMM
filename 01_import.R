# author Guy.stanley@health.wa.gov.au

#Ths is the R scripts provided by REDCap that encodes the data
# need to get emails, who did what, comments, who sent their protocols too!

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


library(tidyverse)

# drop variables so we have the same number of variables then can merge the datasets
data_anz <- data_anz %>% select(-c(redcap_event_name,
                                   redcap_repeat_instrument,
                                   redcap_repeat_instance,
                                   redcap_survey_identifier
))  

data_uk <- data_uk %>% select(-c(redcap_event_name, 
                                 redcap_survey_identifier))  

#summary(comparedf(data_anz, data_uk))

# add two dataframes
data <- rbind(data_uk,data_anz)

# only work with complete data
data <- data %>% filter(optithermm_survey_complete == 'Complete')

#drop incomplete records
data <- data[-168,]
data <- data[-(1:19),]

#add a unique ID, drop the redundant record ID
data <- rowid_to_column(data, "ID")
data <- data %>% select(-record_id)

colnames(data) <- c("ID", "survey.timestamp",                 
                    "ref.id", "hospital",
                    "city", "country",
                    "other.country", "groups.treated",
                    "dr.role", "other.role",
                    "hospital.statement",  "max.burn.size.treated",
                    "number.burns.1-20", "number.burns.21-40", 
                    "number.burns.41-60", "number.burns.61-80", 
                    "number.burns.81-100", "treat.inhalation.injury",
                    "theatre.type", "hospital.protocol", #new
                    "institution.guidelines", "max.temp.op.theatre",  
                    "pref.temp.op.theatre", "max.temp.icu",
                    "temp.reg.ex.op.theatre", "hospital.has.icu",
                    "hospital.has.hdu", "hospital.has.burns.ward",
                    "hospital.has.wet.room", "warm.patient.heated.ot",
                    "warm.patient.insulation", "warm.patient.heating.lamp",
                    "warm.patient.convective", "warm.patient.conductive",
                    "warm.patient.iv.fluids", "warm.patient.topical.fluids",
                    "warm.patient.intervascular", "warm.patient.oesophageal",
                    "warm.patient.haemofiltration", "warm.patient.other",
                    "warm.patient.none", "other.warming.method",
                    "cool.patient.room.temp", "cool.patient.remove.dressings",
                    "cool.patient.convection", "cool.patient.conduction",
                    "cool.patient.iv.fluids", "cool.patient.topical.fluids",
                    "cool.patient.intervascular", "cool.patient.oesophageal",
                    "cool.patient.haemofiltration", "cool.patient.other",
                    "cool.patient.none", "other.cooling.method",
                    "patient.temp.in.ear.therm", "patient.temp.non.contact.therm",
                    "patient.temp.rectal.therm", "patient.temp.trad.therm",
                    "patient.temp.aux.therm", "patient.temp.bladder.probe",
                    "patient.temp.forehead.therm", "patient.temp.oropharyngeal",
                    "patient.temp.skin.probe", "patient.temp.other",
                    "patient.temp.none", "other.temp.method",
                    "patient.temp.clinically.important",  "min.temp.delay.surg",
                    "max.temp.delay.surg", "preferred.min.temp.surg",
                    "set.max.temp.surg", "clinical.trial.cool.patient",
                    "respondent.email","comments",
                    "complete"
)

# create MS EXCEL file for maximum ease of use, then upload to GOOGLE SHEETS for manual editing and review 
install.packages("xlsx")
library("xlsx")
write.xlsx(data,  "data/output.xlsx", sheetName = "Sheet1", 
           col.names = TRUE, row.names = TRUE, append = FALSE)

# TODO 
# check errors
# re-import the manually corrected file
# add new unique identifiers
# ensure factors correct
# hand to Glenn