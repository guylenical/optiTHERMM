# author Guy.stanley@health.wa.gov.au

library(tidyverse)
library(readxl)
library(Hmisc)
library(forcats)
library(xlsx)
library(lubridate)
library(xlsx)


# re-import the manually cleaned file
data <- read_excel("optithermm_cleaned.xlsx", 
                                 col_types = c("text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "numeric", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "text", "text", "text", 
                                               "text", "text", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric", "numeric", 
                                               "numeric", "numeric"), na = "#N/A")

#add a unique ID, drop the redundant record ID
data <- rowid_to_column(data, "id")

# make the data types correct
data <- data %>% 
  mutate(
    
    #make date object
    survey.timestamp = ymd_hms(survey.timestamp),
    
    # make factors
    hospital = as.factor(hospital),
    city = as.factor(city),
    country = as.factor(country),
    groups.treated = as.factor(groups.treated),
    dr.role = as.factor(dr.role),
    hospital.statement = as.factor(hospital.statement),
   max.burn.size.treated =  as.factor(max.burn.size.treated),
   `number.burns.1-20` = factor(`number.burns.1-20`, levels = c("0", "1-5", "6-10", "11-15", "16-20", ">20", "Dont know")),
   `number.burns.21-40` = factor(`number.burns.21-40`, levels = c("0", "1-5", "6-10", "11-15", "16-20", ">20", "Dont know")),
   `number.burns.41-60` = factor(`number.burns.41-60`, levels = c("0", "1-5", "6-10", "11-15", "16-20", ">20", "Dont know")),
   `number.burns.61-80` = factor(`number.burns.61-80`, levels = c("0", "1-5", "6-10", "11-15", "16-20", ">20", "Dont know")),
   `number.burns.81-100` = factor(`number.burns.81-100`, levels = c("0", "1-5", "6-10", "11-15", "16-20", ">20", "Dont know")),
   treat.inhalation.injury = case_when(treat.inhalation.injury == "Yes" ~ TRUE, treat.inhalation.injury == "No" ~ FALSE),
     as.factor(treat.inhalation.injury),
   theatre.type = as.factor(theatre.type),
   hospital.protocol = as.factor(hospital.protocol),
   institution.guidelines = as.factor(institution.guidelines),
   max.temp.op.theatre = factor(max.temp.op.theatre, levels = c("Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","I dont know")),
  pref.temp.op.theatre = factor(pref.temp.op.theatre, levels =c("Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","We do not have a target operating theatre temperature for burns cases")),
  max.temp.icu = factor(max.temp.icu, levels=c("My hospital does not have an intensive care unit","Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","I dont know")),
  temp.reg.ex.op.theatre = as.factor(temp.reg.ex.op.theatre),
  hospital.has.icu = ifelse(hospital.has.icu == "Checked",TRUE,FALSE),
  hospital.has.hdu = ifelse(hospital.has.hdu == "Checked", TRUE, FALSE),
  hospital.has.burns.ward = ifelse(hospital.has.burns.ward == "Checked", TRUE, FALSE),
  hospital.has.wet.room = ifelse(hospital.has.wet.room == "Checked", TRUE, FALSE),
 
  warm.patient.heated.ot = ifelse(warm.patient.heated.ot == "Checked", TRUE, FALSE),
  warm.patient.insulation = ifelse(warm.patient.insulation == "Checked",  TRUE, FALSE),
  warm.patient.heating.lamp = ifelse(warm.patient.heating.lamp == "Checked", TRUE, FALSE),
  warm.patient.convective = ifelse(warm.patient.convective == "Checked",TRUE, FALSE),
  warm.patient.conductive = ifelse(warm.patient.conductive == "Checked",TRUE, FALSE),
  warm.patient.iv.fluids = ifelse(warm.patient.iv.fluids == "Checked", TRUE, FALSE),
  warm.patient.topical.fluids = ifelse(warm.patient.topical.fluids == "Checked", TRUE, FALSE),
  warm.patient.intervascular = ifelse(warm.patient.intervascular == "Checked", TRUE, FALSE),
  warm.patient.oesophageal = ifelse(warm.patient.oesophageal == "Checked", TRUE, FALSE),
  warm.patient.haemofiltration = ifelse(warm.patient.haemofiltration == "Checked",TRUE, FALSE),
  warm.patient.other = ifelse(warm.patient.other == "Checked", TRUE, FALSE),
  warm.patient.none = ifelse(warm.patient.none == "Checked", TRUE, FALSE),
  
  cool.patient.room.temp = ifelse(cool.patient.room.temp == "Checked", TRUE, FALSE),
  cool.patient.remove.dressings = ifelse(cool.patient.remove.dressings == "Checked", TRUE, FALSE),
  cool.patient.convection = ifelse(cool.patient.convection == "Checked", TRUE, FALSE),
  cool.patient.conduction = ifelse(cool.patient.conduction == "Checked", TRUE, FALSE),
  cool.patient.iv.fluids = ifelse(cool.patient.iv.fluids == "Checked", TRUE, FALSE),
  cool.patient.topical.fluids = ifelse(cool.patient.topical.fluids == "Checked", TRUE, FALSE),
  cool.patient.intervascular = ifelse(cool.patient.intervascular == "Checked", TRUE,  FALSE),
  cool.patient.oesophageal = ifelse(cool.patient.oesophageal == "Checked", TRUE, FALSE),
  cool.patient.haemofiltration = ifelse(cool.patient.haemofiltration == "Checked" , TRUE, FALSE),
  cool.patient.other = ifelse(cool.patient.other == "Checked",TRUE, FALSE),
  cool.patient.none = ifelse(cool.patient.none == "Checked" , TRUE, FALSE),
   
  patient.temp.in.ear.therm = ifelse(patient.temp.in.ear.therm == "Checked" , TRUE, FALSE),
  patient.temp.non.contact.therm = ifelse(patient.temp.non.contact.therm == "Checked" , TRUE, FALSE),
  patient.temp.rectal.therm = ifelse(patient.temp.rectal.therm == "Checked" , TRUE,  FALSE),
  patient.temp.trad.therm = ifelse(patient.temp.trad.therm == "Checked" , TRUE, FALSE),
  patient.temp.aux.therm = ifelse(patient.temp.aux.therm == "Checked" ,TRUE,  FALSE),
  patient.temp.bladder.probe = ifelse(patient.temp.bladder.probe == "Checked" , TRUE, FALSE),
  patient.temp.forehead.therm = ifelse(patient.temp.forehead.therm == "Checked" ,TRUE, FALSE),
  patient.temp.oropharyngeal = ifelse(patient.temp.oropharyngeal == "Checked" , TRUE, FALSE),
  patient.temp.skin.probe = ifelse(patient.temp.skin.probe == "Checked" , TRUE, FALSE),
  patient.temp.other = ifelse(patient.temp.other == "Checked" , TRUE,  FALSE),
  patient.temp.none = ifelse(patient.temp.none == "Checked" , TRUE, FALSE),
  
  patient.temp.clinically.important = as.factor(patient.temp.clinically.important),
  min.temp.delay.surg = factor(min.temp.delay.surg, levels = c("We do not have a set minimum patient body temperature before starting burn surgery","Less than 32ºC (Less than 90ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","35ºC (95ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","More than 39ºC (More than 102ºF)")),
  max.temp.delay.surg =factor(max.temp.delay.surg, levels = c("Less than 36ºC (Less than 97ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","40ºC (104ºF)","41ºC (106ºF)","More than 41ºC (More than 106ºF)","We do not have a set maximum patient body temperature before starting burn surgery")),

  preferred.min.temp.surg = factor(preferred.min.temp.surg, levels = c("Less than 32ºC (Less than 90ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","35ºC (95ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","More than 39ºC (More than 102ºF)","We do not have a set minimum patient body temperature during burn surgery","I dont know")),
  set.max.temp.surg = factor(set.max.temp.surg, levels = c("Less than 36ºC (Less than 97ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","40ºC (104ºF)","41ºC (106ºF)","More than 41ºC (More than 106ºF)","We do not have a set maximum patient body temperature during burn surgery","I dont know")),
  clinical.trial.cool.patient = as.factor(clinical.trial.cool.patient),
  
  uk.type.adult.centre = as.logical(uk.type.adult.centre),
  uk.type.adult.unit = as.logical(uk.type.adult.unit),
  uk.type.paeds.centre = as.logical(uk.type.paeds.centre),
  uk.type.paeds.unit = as.logical(uk.type.paeds.unit),
  uk.type.adult.facility = as.logical(uk.type.adult.facility),
  uk.type.paeds.facility = as.logical(uk.type.paeds.facility),
  
  # ensure high precision doubles used here
  latitude = as.double(latitude),
  longitude = as.double(longitude)
    )
   

# add the questions to the dataset
label(data$id)="Record ID"
label(data$survey.timestamp)="Survey Timestamp"
label(data$ref.id)="Whats the referral ID?"
label(data$hospital)="Please enter the name of your hospital"
label(data$city)="In which city or town is your hospital located?"
label(data$country)="In which country is your hospital located?"
label(data$other.country)="Which OTHER country?"
label(data$groups.treated)="Which groups do you treat in your hospital?"
label(data$dr.role)="Please select your role within the burns team:"
label(data$other.role)="Which other role?"
label(data$hospital.statement)="Which of the following statements about your hospital is true:"
label(data$max.burn.size.treated)="Please enter the maximum burn size that can be treated by your hospital as a percentage of total body surface area (TBSA). For example, if your maximum burned area is 15% TBSA, enter the number 15 in the space below."
label(data$`number.burns.1-20`)="1-20%"
label(data$`number.burns.21-40`)="21-40%"
label(data$`number.burns.41-60`)="41-60%"
label(data$`number.burns.61-80`)="61-80%"
label(data$`number.burns.81-100`)="81-100%"
label(data$treat.inhalation.injury)="Does your hospital admit and treat patients with suspected inhalation injury?"
label(data$theatre.type)="Which of the following statements is true?"
label(data$hospital.protocol)="Do you have any existing protocols or guidelines at your hospital relating to the perioperative temperature management of any burn patients?"
label(data$institution.guidelines)="We would be very grateful if you could please attach a copy of your institutional guidelines. Alternatively, you can send them to info@optithermm.org"
label(data$max.temp.op.theatre)="What is the maximum temperature that can be attained in the operating theatre used for burns in your hospital?"
label(data$pref.temp.op.theatre)="What would be yourprefererred operating theatre target temperaturefor a major burn case in your operating theatre?"
label(data$max.temp.icu)="What is themaximum room temperaturethat can be attained in theintensive care unit,or equivalent unit,used for major burns patients in your hospital?"
label(data$temp.reg.ex.op.theatre)="Does your hospital have any facilities with temperature regulation outside of the operating theatre?"
label(data$hospital.has.icu)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Intensive care or critical care unit (highest level of support))"
label(data$hospital.has.hdu)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=High dependency unit (or equivalent intermediate level of support))"
label(data$hospital.has.burns.ward)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Patient room or bed space area on burns ward (basic level of support))"
label(data$hospital.has.wet.room)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Wet room or equivalent room used for dressing changes)"
label(data$warm.patient.heated.ot)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Heated operating theatre e.g. by means of a temperature regulated airflow)"
label(data$warm.patient.insulation)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Additional insulating layers on patient e.g. drapes, gamgee® or blankets)"
label(data$warm.patient.heating.lamp)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Heating lamp or equivalent radiant heaters)"
label(data$warm.patient.convective)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Convective forced-air patient warming devices e.g. Bair Hugger®)"
label(data$warm.patient.conductive)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Conductive heating device e.g. warmed mattress, pads or garment in direct contact with patient)"
label(data$warm.patient.iv.fluids)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Warmed intravenous fluids)"
label(data$warm.patient.topical.fluids)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Warmed topical fluids e.g. skin antiseptic or wound irrigation solutions)"
label(data$warm.patient.intervascular)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Intravascular temperature controlling devices such as heated central venous line e.g. Thermogard XP®)"
label(data$warm.patient.oesophageal)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Oesophageal heat exchanger e.g. ensoETM®)"
label(data$warm.patient.haemofiltration)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Haemofiltration via vascular route with circuit set to warming)"
label(data$warm.patient.other)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Other)"
label(data$warm.patient.none)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=None of the above)"
label(data$other.warming.method)="Which other warming method(s)?"
label(data$cool.patient.room.temp)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Decreasing room temperature e.g. thermostat down to minimum)"
label(data$cool.patient.remove.dressings)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Removing dressings)"
label(data$cool.patient.convection)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Convective forced air cooling device e.g. cooling fan)"
label(data$cool.patient.conduction)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Conductive cooling device e.g. cooling mattress)"
label(data$cool.patient.iv.fluids)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Cooled intravenous fluids)"
label(data$cool.patient.topical.fluids)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Cooled topical fluids e.g. skin antiseptics, wound irrigation or tepid sponging)"
label(data$cool.patient.intervascular)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Intravascular temperature controlling devices set to cooling e.g. Coolgard ®)"
label(data$cool.patient.oesophageal)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Oesphageal heat exchanger set to cooling)"
label(data$cool.patient.haemofiltration)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Haemofiltration via vascular route with circuit set to cooling)"
label(data$cool.patient.other)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=Other)"
label(data$cool.patient.none)="Which methods do you use inyour hospital tocoolburn patients in the operating room? (choice=None of the above)"
label(data$other.cooling.method)="Which other cooling method(s)?"
label(data$patient.temp.in.ear.therm)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=In-ear tympanic membrane thermometer)"
label(data$patient.temp.non.contact.therm)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Non-contact or infrared thermometer)"
label(data$patient.temp.rectal.therm)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Rectal thermometer or probe)"
label(data$patient.temp.trad.therm)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Traditional glass intra-oral thermometer)"
label(data$patient.temp.aux.therm)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Axillary thermometer or probe)"
label(data$patient.temp.bladder.probe)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Urinary bladder probe)"
label(data$patient.temp.forehead.therm)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Forehead strip thermometer)"
label(data$patient.temp.oropharyngeal)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Oropharyngeal or endotracheal temperature probe)"
label(data$patient.temp.skin.probe)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Skin temperature probe)"
label(data$patient.temp.other)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Other)"
label(data$patient.temp.none)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=None of the above)"
label(data$other.temp.method)="Which other measurement method(s)?"
label(data$patient.temp.clinically.important)="Considering the measurement and management of patient body temperature, which of the following variables do you consider to be most clinically important?"
label(data$min.temp.delay.surg)="Consider a patient at your hospital who is due to undergo burn surgery. Is there aminimum body temperaturebelow which you would delay burn surgery?"
label(data$max.temp.delay.surg)="Consider a patient at your hospital who is due to undergo burn surgery. Is there a maximum body temperature above which you would delay burn surgery?"
label(data$preferred.min.temp.surg)="At your hospital do you have a preferred minimum patient body temperature during burns surgery?"
label(data$set.max.temp.surg)="Do you have a set maximum patient body temperature during burn surgery?"
label(data$clinical.trial.cool.patient)="There is emerging evidence that perioperative cooling of a patient with burns may have a beneficial effect. Would you be willing to be involved in a future clinical trial testing an intervention to cool a patient?"
label(data$respondent.email)="If you would like to be sent the results of our study, please enter your email. This is entirely optional. Your email would not be used for any purpose other than to send you the results of the study.  If you would prefer not to provide your email, please skip this question.  Your email address will be kept according to General Data Protection Regulation (GDPR) and privacy regulations. Your data will only be used to communicate with you about this study. At the end of the study your details will be erased. You can remove yourself from the email list at any point by emailing info@optithermm.org"
label(data$comments)="If you have any comments, feedback or further information, please enter it in the box to the right. Thank you for contributing."
label(data$complete)="Complete?"
label(data$uk.type.adult.centre)="Is this a UK adult burn centre?"
label(data$uk.type.adult.unit)="Is this a UK adult burn unit?"
label(data$uk.type.paeds.centre)="Is this a UK paediatric burn centre?"
label(data$uk.type.paeds.unit)="Is this a UK paediatric burn unit?"
label(data$uk.type.adult.facility)="Is this a UK adult facility?"
label(data$uk.type.paeds.facility)="Is this a UK paeds facility?"
label(data$latitude)="What is the latitude of this hospital?"
label(data$longitude)="What is the longitude of this hospital?"

#update the intervascular to INTRAvascular to correct a typo
data <- data %>% 
  rename("cool.patient.intravascular" = cool.patient.intervascular,
         "warm.patient.intravascular" = warm.patient.intervascular )

# drop the 'complete' column as it's no longer needed
data <- data %>% select(-complete)

# create new categorical variables based on the data
# create a new factor for 'anesthetist or intensivist' vs 'any kind of surgeon'
# if they stated 'Anaesthetist and Intensivist' as 'other.role' then they get classed as 'anaesthetist or intensivist'
# create a new factor for 'high level care' vs 'lower level care' based on complexity of burns treated
# high level care = where max.burn.size.treated >= 40% TBSA and they treat inhalation burns 
data <- data %>% mutate(
  
  anaesthetists.intensivists.verus.surgeons = as.factor(case_when(dr.role == 'Plastic surgeon' ~ "surgeon",
            dr.role == 'Surgeon in another surgical speciality' ~ "surgeon",
            dr.role == 'General surgeon' ~ "surgeon",
           dr.role == 'Anaesthetist' ~ "anaesthetist.intensivist",
            dr.role == 'Intensivist or critical care doctor' ~ "anaesthetist.intensivist",
            dr.role == 'Other' ~ NA,
           other.role == 'Anaesthetist and Intensivist' ~ "anaesthetist.intensivist"
  )),
  
  level.of.complexity = as.factor(
    ifelse(
      (treat.inhalation.injury == TRUE & 
         max.burn.size.treated %in% c("40","50","60")),
      'high.level','low.level'))
  )

# save a clean dataset
saveRDS(data, "clean_data.rds")  