# Script to tidy the optiTHERMM data by Guy Stanley

library(tidyverse)
library(stringdist)

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

#rename columns/variables (NOT YET WORKING)
colnames(data) <- c("ID",
                    "survey.timestamp",
                    "ref.id",
                    "hospital",
                    "city",
                    "country",
                    "other.country",
                    "groups.treated",
                    "dr.role",
                    "other.role",
                    "hospital.statement",
                    "max.burn.size.treated",
                    "number.burns.1-20",
                    "number.burns.21-40",
                    "number.burns.41-60",
                    "number.burns.61-80",
                    "number.burns.81-100",
                    "treat.inhalation.injury",
                    "theatre.type",
                    "hospital.protocol", #new
                    "instruction.provided",#new
                    
                    "perioperative.temp.manage",
                    "institution.guidelines",
                    "max.temp.op.theatre",
                    "pref.temp.op.theatre",
                    "max.temp.icu",
                    "temp.reg.ex.op.theatre",
                    "hospital.has.icu",
                    "hospital.has.hdu",
                    "hospital.has.burns.ward",
                    "hospital.has.wet.room",
                    "warm.patient.heated.ot",
                    "warm.patient.insulation",
                    "warm.patient.heating.lamp",
                    "warm.patient.convective",
                    "warm.patient.conductive",
                    "warm.patient.iv.fluids",
                    "warm.patient.topical.fluids",
                    "warm.patient.intervascular",
                    "warm.patient.oesophageal",
                    "warm.patient.haemofiltration",
                    "warm.patient.other",
                    "warm.patient.none",
                    "other.warming.method",
                    "cool.patient.room.temp",
                    "cool.patient.remove.dressings",
                    "cool.patient.convection",
                    "cool.patient.conduction",
                    "cool.patient.iv.fluids",
                    "cool.patient.topical.fluids",
                    "cool.patient.intervascular",
                    "cool.patient.oesophageal",
                    "cool.patient.haemofiltration",
                    "cool.patient.other",
                    "cool.patient.none",
                    "other.cooling.method",
                    "patient.temp.in.ear.therm",
                    "patient.temp.non.contact.therm",
                    "patient.temp.rectal.therm",
                    "patient.temp.trad.therm",
                    "patient.temp.aux.therm",
                    "patient.temp.bladder.probe",
                    "patient.temp.forehead.therm",
                    "patient.temp.oropharyngeal",
                    "patient.temp.skin.probe",
                    "patient.temp.other",
                    "patient.temp.none",
                    "other.temp.method",
                    "patient.temp.clinically.important",
                    "min.temp.delay.surg",
                    "max.temp.delay.surg",
                    "preferred.min.temp.surg",
                    "set.max.temp.surg",
                    "clinical.trial.cool.patient",
                    "complete"
)

# make hospital names consistent
data %>% group_by(hospital) %>% summarise(count = n())
grepl("alder hey", str_trim(tolower(data$hospital)) )
stringdist("alder hey", str_trim(tolower(data$hospital)))


# correct for UK centre vs unit

# merge the datasets

# make new variables to make the datasets identifiable

# add a region factor with UK or ANZ