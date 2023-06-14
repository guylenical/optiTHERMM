# descriptive stats for optiTHERMM

library(gtsummary)
library(ggmap)
library(gridExtra)
library(ggplot2)


# Read data
data <- readRDS("clean_data.rds")

# basic stats
summary(data)

min(data$survey.timestamp)
max(data$survey.timestamp)

data %>% group_by(ref.id) %>% summarise(count = n()) %>% arrange(desc(count))

table(data$hospital)
data %>% group_by(hospital) %>% summarise(count = n()) %>% arrange(desc(count))
table(data$country)
data %>% group_by(country) %>% summarise(count = n()) %>% arrange(desc(count))
table(data$groups.treated)
table(data$dr.role)
table(data$anaesthetists.intensivists.verus.surgeons)
table(data$hospital.statement)
table(data$max.burn.size.treated)

ggplot(data, aes(x = max.burn.size.treated)) + geom_bar()
table(data$`number.burns.1-20`)
table(data$`number.burns.21-40`)
table(data$`number.burns.41-60`)
table(data$`number.burns.61-80`)
table(data$`number.burns.81-100`)

table(data$level.of.complexity)

table(data$treat.inhalation.injury)
table(data$theatre.type)
table(data$hospital.protocol)
table(data$institution.guidelines)
table(data$max.temp.op.theatre)
table(data$pref.temp.op.theatre)
table(data$max.temp.icu)
table(data$temp.reg.ex.op.theatre)
table(data$hospital.has.icu)
table(data$hospital.has.hdu)
table(data$hospital.has.burns.ward)
table(data$hospital.has.wet.room)
table(data$warm.patient.heated.ot)
table(data$warm.patient.insulation)
table(data$warm.patient.heating.lamp)
table(data$warm.patient.convective)
table(data$warm.patient.conductive)
table(data$warm.patient.iv.fluids)
table(data$warm.patient.topical.fluids)
table(data$warm.patient.intervascular)
table(data$warm.patient.oesophageal)
table(data$warm.patient.haemofiltration)
table(data$warm.patient.other)
table(data$warm.patient.none)
table(data$other.warming.method)
table(data$cool.patient.room.temp)
table(data$cool.patient.remove.dressings)
table(data$cool.patient.convection)
table(data$cool.patient.conduction)
table(data$cool.patient.iv.fluids)
table(data$cool.patient.topical.fluids)
table(data$cool.patient.intervascular)
table(data$cool.patient.oesophageal)
table(data$cool.patient.haemofiltration)
table(data$cool.patient.other)
table(data$cool.patient.none)
table(data$other.cooling.method)
table(data$patient.temp.in.ear.therm)
table(data$patient.temp.non.contact.therm)
table(data$patient.temp.rectal.therm)
table(data$patient.temp.trad.therm)
table(data$patient.temp.aux.therm)
table(data$patient.temp.bladder.probe)
table(data$patient.temp.forehead.therm)
table(data$patient.temp.oropharyngeal)
table(data$patient.temp.skin.probe)
table(data$patient.temp.other)
table(data$patient.temp.none)
table(data$other.temp.method)
table(data$patient.temp.clinically.important)
table(data$min.temp.delay.surg)
table(data$max.temp.delay.surg)
table(data$preferred.min.temp.surg)
table(data$set.max.temp.surg)
table(data$clinical.trial.cool.patient)
sum(!is.na(data$respondent.email))
table(data$comments)
table(data$uk.type.adult.centre)
table(data$uk.type.adult.unit)
table(data$uk.type.paeds.centre)
table(data$uk.type.paeds.unit)
table(data$uk.type.adult.facility)
table(data$uk.type.paeds.facility)

# Table 1 - description of participants 
participants <- data %>%
  dplyr::select(
    country, 
    dr.role, 
    max.burn.size.treated, 
    clinical.trial.cool.patient,
    min.temp.delay.surg,
    max.temp.delay.surg
  )

(table1 <- tbl_summary(
  participants,
  by = country, missing = 'no'
) %>%
    add_n() %>%
    add_p() %>%
    modify_header(label = "**Variable**") %>% # update the column header
    bold_labels()   
)