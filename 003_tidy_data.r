# Script to tidy the optiTHERMM data by Guy Stanley

library(tidyverse)
library(arsenal)

# drop variables so we have the same number of variables then can merge the datasets
data_anz <- data_anz %>% select(-c(redcap_event_name, redcap_event_name.factor,
                                   redcap_repeat_instrument, redcap_repeat_instrument.factor,
                                   redcap_repeat_instance,
                                   redcap_survey_identifier
                                   ))  

data_uk <- data_uk %>% select(-c(redcap_event_name, 
                                 redcap_event_name.factor,
                                 redcap_survey_identifier))  

#summary(comparedf(data_anz, data_uk))

# add two dataframes
data <- rbind(data_uk,data_anz)

# only work with complete data
data <- data %>% filter(optithermm_survey_complete.factor == 'Complete')

#drop incomplete records
data <- data[-168,]
data <- data[-(1:19),]

#add a unique ID, drop the redundant record ID
data <- rowid_to_column(data, "ID")
data <- data %>% select(-record_id)

#rename columns
colnames(data) <- c("record.id",
                    "event.name",
                    "repeat.instrument",
                    "repeat.instance",
                    "survey.id",
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
                    "email.for.results",
                    "comments",
                    "complete"
)

# correct for UK centre vs unit

# merge the datasets

# make new variables to make the datasets identifiable

# add a region factor with UK or ANZ