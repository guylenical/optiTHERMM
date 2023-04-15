# Code by Glenn Boardman, Guy Stanley
# to analyse the UK and Australia & New Zealand OptiTHERMM.org data

# TO DO
# 1. Make the hospital name just one UNIQUE hospital name for each hospital in spreadsheet BEFORE analysis 
#   e.g. 'Alfred' 'The Alfred' 'Alfred  '
#
# 2. Add two fields - check that there isn't already a PAEDS / ADULTS indicator!
#   1. adult_or_paeds - 0 = adult, 1 = paeds to indicate the speciality of the centre in question.
#   2. uk_centre_or_unit - 0 = centre, 1 = unit to indicate the UK hospitals are the more major 'centres' or more minor 'units'.

library(tidyverse)
library(readxl)
library(rstatix)
library(coin)
library(MASS)
library(Hmisc)
library(gtsummary)
rm(list = ls())

# READ DATA
#location <- "W:\\Executive\\FRE\\SMHS Research\\Research Statistical Support\\Projects 2022\\"
#project <- "35 - optitherm - guy stanley\\"
anz_file <- "data/optithermm_anz_data_2022-12-13_0601.csv" # ANZ data
uk_file <- "data/optithermm_uk_data_2023-04-14.csv" # UK data
  
data <- read_csv(anz_file) # read a country's data using the tidyverse method
#anz_data <- read_csv(anz_file)
#uk_data <- read_csv(uk_file)
#data <- read_csv(paste(location,project,file,sep = ''))


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

# currently only works on ANZ dataset - 15 April 2023
data <- data %>%
  filter(complete == 2) %>%
  mutate(country = as.factor(case_when(country == 1 ~ "australia",
                                       country == 2 ~ "uk",
                                       country == 3 ~ "new.zealand"
  )),
  groups.treated = as.factor(case_when(groups.treated == 1 ~ "adults",
                                       groups.treated == 2 ~ "children",
                                       groups.treated == 3 ~ "adults.children"
  )),
  dr.role = as.factor(case_when(dr.role == 1 ~ "plastic.surgeon",
                                dr.role == 2 ~ "general.surgeon",
                                dr.role == 3 ~ "other.surgeon",
                                dr.role == 4 ~ "anaesthetist",
                                dr.role == 5 ~ "ic.doctor",
                                dr.role == 6 ~ "other"
  )),
  hospital.statement = as.factor(case_when(hospital.statement == 1 ~ "below.certain.burn.size",
                                           hospital.statement == 2 ~ "any.burn.size"
  )),
  `number.burns.1-20` = as.factor(case_when(`number.burns.1-20` == 1 ~ "a.0",
                                            `number.burns.1-20` == 2 ~ "b.1-5",
                                            `number.burns.1-20` == 3 ~ "c.6-10",
                                            `number.burns.1-20` == 4 ~ "d.11-15",
                                            `number.burns.1-20` == 5 ~ "e.16-20",
                                            `number.burns.1-20` == 6 ~ "f.>20",
                                            `number.burns.1-20` == 7 ~ "g.dont.know"
  )),
  `number.burns.21-40` = as.factor(case_when(`number.burns.21-40` == 1 ~ "a.0",
                                             `number.burns.21-40` == 2 ~ "b.1-5",
                                             `number.burns.21-40` == 3 ~ "c.6-10",
                                             `number.burns.21-40` == 4 ~ "d.11-15",
                                             `number.burns.21-40` == 5 ~ "e.16-20",
                                             `number.burns.21-40` == 6 ~ "f.>20",
                                             `number.burns.21-40` == 7 ~ "g.dont.know"
  )),
  `number.burns.41-60` = as.factor(case_when(`number.burns.41-60` == 1 ~ "a.0",
                                             `number.burns.41-60` == 2 ~ "b.1-5",
                                             `number.burns.41-60` == 3 ~ "c.6-10",
                                             `number.burns.41-60` == 4 ~ "d.11-15",
                                             `number.burns.41-60` == 5 ~ "e.16-20",
                                             `number.burns.41-60` == 6 ~ "f.>20",
                                             `number.burns.41-60` == 7 ~ "g.dont.know"
  )),
  `number.burns.61-80` = as.factor(case_when(`number.burns.61-80` == 1 ~ "a.0",
                                             `number.burns.61-80` == 2 ~ "b.1-5",
                                             `number.burns.61-80` == 3 ~ "c.6-10",
                                             `number.burns.61-80` == 4 ~ "d.11-15",
                                             `number.burns.61-80` == 5 ~ "e.16-20",
                                             `number.burns.61-80` == 6 ~ "f.>20",
                                             `number.burns.61-80` == 7 ~ "g.dont.know"
  )),
  `number.burns.81-100` = as.factor(case_when(`number.burns.81-100` == 1 ~ "a.0",
                                              `number.burns.81-100` == 2 ~ "b.1-5",
                                              `number.burns.81-100` == 3 ~ "c.6-10",
                                              `number.burns.81-100` == 4 ~ "d.11-15",
                                              `number.burns.81-100` == 5 ~ "e.16-20",
                                              `number.burns.81-100` == 6 ~ "f.>20",
                                              `number.burns.81-100` == 7 ~ "g.dont.know"
  )),
  treat.inhalation.injury = as.factor(case_when(treat.inhalation.injury == 1 ~ "yes",
                                                treat.inhalation.injury == 0 ~ "no"
  )),
  theatre.type = as.factor(case_when(theatre.type == 1 ~ "burns.only",
                                     theatre.type == 2 ~ "burns.plastics",
                                     theatre.type == 3 ~ "burns.other"
  )),
  perioperative.temp.manage = as.factor(case_when(perioperative.temp.manage == 1 ~ "yes",
                                                  perioperative.temp.manage == 0 ~ "no",
                                                  perioperative.temp.manage == 2 ~ "dont.know",
  )),
  max.temp.op.theatre = as.factor(case_when(max.temp.op.theatre ==1 ~ "a.under.24c.75f",
                                            max.temp.op.theatre ==2 ~ "b.24c.75f",
                                            max.temp.op.theatre ==3 ~ "c.25c.77f",
                                            max.temp.op.theatre ==4 ~ "d.26c.79f",
                                            max.temp.op.theatre ==5 ~ "e.27c.81f",
                                            max.temp.op.theatre ==6 ~ "f.28c.82f",
                                            max.temp.op.theatre ==7 ~ "g.29c.84f",
                                            max.temp.op.theatre ==8 ~ "h.30c.86f",
                                            max.temp.op.theatre ==9 ~ "i.31c.88f",
                                            max.temp.op.theatre ==10 ~ "j.32c.90f",
                                            max.temp.op.theatre ==11 ~ "k.33c.91f",
                                            max.temp.op.theatre ==12 ~ "l.34c.93f",
                                            max.temp.op.theatre ==13 ~ "m.over.34c.93f",
                                            max.temp.op.theatre ==14 ~ "n.dont.know"
  )),
  pref.temp.op.theatre = as.factor(case_when(pref.temp.op.theatre ==1 ~ "a.under.24c.75f",
                                             pref.temp.op.theatre ==2 ~ "b.24c.75f",
                                             pref.temp.op.theatre ==3 ~ "c.25c.77f",
                                             pref.temp.op.theatre ==4 ~ "d.26c.79f",
                                             pref.temp.op.theatre ==5 ~ "e.27c.81f",
                                             pref.temp.op.theatre ==6 ~ "f28c.82f",
                                             pref.temp.op.theatre ==7 ~ "g.29c.84f",
                                             pref.temp.op.theatre ==8 ~ "h.30c.86f",
                                             pref.temp.op.theatre ==9 ~ "i.31c.88f",
                                             pref.temp.op.theatre ==10 ~ "j.32c.90f",
                                             pref.temp.op.theatre ==11 ~ "k.33c.91f",
                                             pref.temp.op.theatre ==12 ~ "l.34c.93f",
                                             pref.temp.op.theatre ==13 ~ "m.over.34c.93f",
                                             pref.temp.op.theatre ==14 ~ "n.dont..know"
  )),
  max.temp.icu = as.factor(case_when(max.temp.icu ==1 ~ "a.no.icu",
                                     max.temp.icu ==2 ~ "b.under.24c.75f",
                                     max.temp.icu ==3 ~ "c.24c.75f",
                                     max.temp.icu ==4 ~ "e.25c.77f",
                                     max.temp.icu ==5 ~ "f.26c.79f",
                                     max.temp.icu ==6 ~ "g.27c.81f",
                                     max.temp.icu ==7 ~ "h.28c.82f",
                                     max.temp.icu ==8 ~ "i.29c.84f",
                                     max.temp.icu ==9 ~ "j.30c.86f",
                                     max.temp.icu ==10 ~ "k.31c.88f",
                                     max.temp.icu ==11 ~ "l.32c.90f",
                                     max.temp.icu ==12 ~ "m.33c.91f",
                                     max.temp.icu ==13 ~ "n.34c.93f",
                                     max.temp.icu ==14 ~ "o.over.34c.93f",
                                     max.temp.icu ==15 ~ "p.dont.know"
  )),
  temp.reg.ex.op.theatre = as.factor(case_when(temp.reg.ex.op.theatre == 1 ~ "yes",
                                               temp.reg.ex.op.theatre == 0 ~ "no",
                                               temp.reg.ex.op.theatre == 2 ~ "dont.know",
  )),
  patient.temp.clinically.important = as.factor(case_when(patient.temp.clinically.important == 1 ~ "core.temp",
                                                          patient.temp.clinically.important == 2 ~ "peripheral.temp",
                                                          patient.temp.clinically.important == 3 ~ "don't.know",
  )),                                         
  clinical.trial.cool.patient = as.factor(case_when(clinical.trial.cool.patient == 1 ~ "a.adults",
                                                    clinical.trial.cool.patient == 2 ~ "b.adults.children",
                                                    clinical.trial.cool.patient == 3 ~ "c.children",
                                                    clinical.trial.cool.patient == 4 ~ "c.not.interested",
                                                    
  ))
  )

####################### DOCTOR ROLE
aus.nz.role.min.temp.delay <- data %>%
  filter(country %in% c("australia","new.zealand")) %>% 
  dplyr::select(dr.role,
                min.temp.delay.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other")),
         new.min.temp = if_else(min.temp.delay.surg == 11,1,min.temp.delay.surg + 1)
         ) %>%
  na.omit() %>%
  mutate(min.temp.delay.surg = as.ordered(case_when(min.temp.delay.surg == 1 ~ "a no.min",
                                                    min.temp.delay.surg == 2 ~ "b <32C",
                                                    min.temp.delay.surg == 3 ~ "c 32C",
                                                    min.temp.delay.surg == 4 ~ "d 33C",
                                                    min.temp.delay.surg == 5 ~ "e 34C",
                                                    min.temp.delay.surg == 6 ~ "f 35C",
                                                    min.temp.delay.surg == 7 ~ "g 36C",
                                                    min.temp.delay.surg == 8 ~ "h 37C",
                                                    min.temp.delay.surg == 9 ~ "i 38C",
                                                    min.temp.delay.surg == 10 ~ "j 39C",
                                                    min.temp.delay.surg == 11 ~ "k >39C"
                                         )))


aus.nz.role.max.temp.delay <- data %>%
  filter(country %in% c("australia","new.zealand")) %>% 
  dplyr::select(dr.role,
                max.temp.delay.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other"))) %>%
  na.omit() %>%
  mutate(max.temp.delay.surg = as.ordered(case_when(max.temp.delay.surg == 1 ~ "a <36C",
                                         max.temp.delay.surg == 2 ~ "b 36C",
                                         max.temp.delay.surg == 3 ~ "c 37C",
                                         max.temp.delay.surg == 4 ~ "d 38C",
                                         max.temp.delay.surg == 5 ~ "e 39C",
                                         max.temp.delay.surg == 6 ~ "f 40C",
                                         max.temp.delay.surg == 7 ~ "g 41C",
                                         max.temp.delay.surg == 8 ~ "h >41C",
                                         max.temp.delay.surg == 9 ~ "i no.max"
                                         )))


aus.nz.role.pref.min.temp <-  data %>%
  filter(country %in% c("australia","new.zealand")) %>% 
  dplyr::select(dr.role,
                preferred.min.temp.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other")),
         new.min.temp = case_when(preferred.min.temp.surg == 12 ~ 12,
                                  preferred.min.temp.surg == 11 ~ 1,
                                  TRUE ~ preferred.min.temp.surg + 1
                                  )
          ) %>%
  na.omit() %>%
  mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
                                             new.min.temp == 2 ~ "b <32C",
                                             new.min.temp == 3 ~ "c 32C",
                                             new.min.temp == 4 ~ "d 33C",
                                             new.min.temp == 5 ~ "e 34C",
                                             new.min.temp == 6 ~ "f 35C",
                                             new.min.temp == 7 ~ "g 36C",
                                             new.min.temp == 8 ~ "h 37C",
                                             new.min.temp == 9 ~ "i 38C",
                                             new.min.temp == 10 ~ "j 39C",
                                             new.min.temp == 11 ~ "k >39C",
                                             new.min.temp == 12 ~ "l not.know"
                                              )))


aus.nz.role.set.max.temp <-   data %>%
  filter(country %in% c("australia","new.zealand")) %>% 
  dplyr::select(dr.role,
                set.max.temp.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other"))) %>%
  na.omit() %>%
  mutate(set.max.temp.surg = as.ordered(case_when(set.max.temp.surg == 1 ~ "a <36C",
                                       set.max.temp.surg == 2 ~ "b 36C",
                                       set.max.temp.surg == 3 ~ "c 37C",
                                       set.max.temp.surg == 4 ~ "d 38C",
                                       set.max.temp.surg == 5 ~ "e 39C",
                                       set.max.temp.surg == 6 ~ "f 40C",
                                       set.max.temp.surg == 7 ~ "g 41C",
                                       set.max.temp.surg == 8 ~ "h >41C",
                                       set.max.temp.surg == 9 ~ "i no.max",
                                       set.max.temp.surg == 10 ~ "j not.known"
                                       )))




xtabs(~dr.role + min.temp.delay.surg,data = aus.nz.role.min.temp.delay)
xtabs(~dr.role + max.temp.delay.surg,data = aus.nz.role.max.temp.delay)
xtabs(~dr.role + new.min.temp,data = aus.nz.role.pref.min.temp)
xtabs(~dr.role + set.max.temp.surg,data = aus.nz.role.set.max.temp)


## Try with wilcox test

coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.min.temp.delay)
coin::wilcox_test(as.numeric(max.temp.delay.surg) ~ dr.role,data = aus.nz.role.max.temp.delay)
coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.pref.min.temp)
coin::wilcox_test(as.numeric(set.max.temp.surg) ~ dr.role,data = aus.nz.role.set.max.temp)


## Proportional Odds model

m1 <- polr(max.temp.delay.surg ~ dr.role,data = aus.nz.role.max.temp.delay,Hess = TRUE)
m1.ctable <- coef(summary(m1))
m1.p <- pnorm(abs(m1.ctable[, "t value"]), lower.tail = FALSE) * 2
m1.ctable <- cbind(m1.ctable, "p value" = m1.p)
m1.ctable
confint(m1)



m2 <- polr(min.temp.delay.surg ~ 1,data = aus.nz.role,Hess = TRUE)


## Test proportional odds assumption

sf <- function(y) {
  c('Y>=1' = qlogis(mean(y >= 1)),
    'Y>=2' = qlogis(mean(y >= 2)),
    'Y>=3' = qlogis(mean(y >= 3)),
    'Y>=4' = qlogis(mean(y >= 4)),
    'Y>=5' = qlogis(mean(y >= 5)),
    'Y>=6' = qlogis(mean(y >= 6)),
    'Y>=7' = qlogis(mean(y >= 7)),
    'Y>=8' = qlogis(mean(y >= 8))
  )
}

(s <- with(aus.nz.role.min.temp.delay, summary(as.numeric(min.temp.delay.surg) ~ dr.role, fun=sf)))
plot(s, which=1:8, pch=1:4, xlab='logit', main=' ', xlim=range(s[,6:9]))

#################### DOCTORS ROLE WITH MAX/MIN GROUPS COMBINED

aus.nz.role.min.temp.delay.v2 <- data %>%
                                  filter(country %in% c("australia","new.zealand")) %>% 
                                  dplyr::select(dr.role,
                                                min.temp.delay.surg
                                  ) %>%
                                  mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other")),
                                         new.min.temp = if_else(min.temp.delay.surg == 11|min.temp.delay.surg == 1,1,min.temp.delay.surg + 1)
                                  ) %>%
                                  na.omit() %>%
                                  mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
                                                                             new.min.temp == 3 ~ "c 32C",
                                                                             new.min.temp == 4 ~ "d 33C",
                                                                             new.min.temp == 5 ~ "e 34C",
                                                                             new.min.temp == 6 ~ "f 35C",
                                                                             new.min.temp == 7 ~ "g 36C",
                                                                             new.min.temp == 8 ~ "h 37C",
                                                                             new.min.temp == 9 ~ "i 38C",
                                                                             new.min.temp == 10 ~ "j 39C",
                                                                             new.min.temp == 11 ~ "k >39C"
                                  )))



xtabs(~dr.role + new.min.temp,aus.nz.role.min.temp.delay.v2)
coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.min.temp.delay.v2)


aus.nz.role.max.temp.delay.v2 <- data %>%
                              filter(country %in% c("australia","new.zealand")) %>% 
                              dplyr::select(dr.role,
                                            max.temp.delay.surg
                              ) %>%
                              mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other")),
                                     new.max.temp = if_else(max.temp.delay.surg == 8|max.temp.delay.surg == 9,as.integer(8),max.temp.delay.surg)
                                     ) %>%
                              na.omit() %>%
                              mutate(new.max.temp = as.ordered(case_when(new.max.temp == 1 ~ "a <36C",
                                                                         new.max.temp == 2 ~ "b 36C",
                                                                         new.max.temp == 3 ~ "c 37C",
                                                                         new.max.temp == 4 ~ "d 38C",
                                                                         new.max.temp == 5 ~ "e 39C",
                                                                         new.max.temp == 6 ~ "f 40C",
                                                                         new.max.temp == 7 ~ "g 41C",
                                                                         new.max.temp == 8 ~ "h >41C"
                                                                                
                              )))

xtabs(~dr.role + new.max.temp,aus.nz.role.max.temp.delay.v2)
coin::wilcox_test(new.max.temp ~ dr.role,data = aus.nz.role.max.temp.delay.v2)


aus.nz.role.pref.min.temp.v2 <-  data %>%
                                filter(country %in% c("australia","new.zealand")) %>% 
                                dplyr::select(dr.role,
                                              preferred.min.temp.surg
                                              ) %>%
                                mutate(dr.role = as.factor(if_else(dr.role == "anaesthetist","anaesthetist","other")),
                                       new.min.temp = case_when(preferred.min.temp.surg == 11|preferred.min.temp.surg == 1 ~ as.integer(1),
                                                                preferred.min.temp.surg == 12 ~ as.integer(11),
                                                                TRUE ~ preferred.min.temp.surg
                                                                )
                                      ) %>%
                                na.omit() %>%
                                mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
                                                                           new.min.temp == 2 ~ "c 32C",
                                                                           new.min.temp == 3 ~ "d 33C",
                                                                           new.min.temp == 4 ~ "e 34C",
                                                                           new.min.temp == 5 ~ "f 35C",
                                                                           new.min.temp == 6 ~ "g 36C",
                                                                           new.min.temp == 7 ~ "h 37C",
                                                                           new.min.temp == 8 ~ "i 38C",
                                                                           new.min.temp == 9 ~ "j 39C",
                                                                           new.min.temp == 10 ~ "k >39C",
                                                                           new.min.temp == 11 ~ "l not.know"
                                )))



xtabs(~dr.role + new.min.temp,aus.nz.role.pref.min.temp.v2)
coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.pref.min.temp.v2)











################### ADULT/PAEDIATRIC
aus.nz.paediatric.min.temp.delay <- data %>%
                                    filter(country %in% c("australia","new.zealand")) %>% 
                                    dplyr::select(groups.treated,
                                                  min.temp.delay.surg
                                    ) %>%
                                    mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric")),
                                           new.min.temp = if_else(min.temp.delay.surg == 11,1,min.temp.delay.surg + 1)
                                    ) %>%
                                    na.omit() %>%
                                    mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
                                                                               new.min.temp == 2 ~ "b <32C",
                                                                               new.min.temp == 3 ~ "c 32C",
                                                                               new.min.temp == 4 ~ "d 33C",
                                                                               new.min.temp == 5 ~ "e 34C",
                                                                               new.min.temp == 6 ~ "f 35C",
                                                                               new.min.temp == 7 ~ "g 36C",
                                                                               new.min.temp == 8 ~ "h 37C",
                                                                               new.min.temp == 9 ~ "i 38C",
                                                                               new.min.temp == 10 ~ "j 39C",
                                                                               new.min.temp == 11 ~ "k >39C"
                                    )))

xtabs(~groups.treated + new.min.temp,aus.nz.paediatric.min.temp.delay)
coin::wilcox_test(new.min.temp ~ groups.treated,data = aus.nz.paediatric.min.temp.delay)


aus.nz.paediatric.max.temp.delay <- data %>%
                                    filter(country %in% c("australia","new.zealand")) %>% 
                                    dplyr::select(groups.treated,
                                                  max.temp.delay.surg
                                    ) %>%
                                    mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric"))) %>%
                                    na.omit() %>%
                                    mutate(max.temp.delay.surg = as.ordered(case_when(max.temp.delay.surg == 1 ~ "a <36C",
                                                                                      max.temp.delay.surg == 2 ~ "b 36C",
                                                                                      max.temp.delay.surg == 3 ~ "c 37C",
                                                                                      max.temp.delay.surg == 4 ~ "d 38C",
                                                                                      max.temp.delay.surg == 5 ~ "e 39C",
                                                                                      max.temp.delay.surg == 6 ~ "f 40C",
                                                                                      max.temp.delay.surg == 7 ~ "g 41C",
                                                                                      max.temp.delay.surg == 8 ~ "h >41C",
                                                                                      max.temp.delay.surg == 9 ~ "i no.max"
                                    )))

xtabs(~groups.treated + max.temp.delay.surg,aus.nz.paediatric.max.temp.delay)
coin::wilcox_test(max.temp.delay.surg ~ groups.treated,data = aus.nz.paediatric.max.temp.delay)

aus.nz.paediatric.pref.min.temp <-  data %>%
                                    filter(country %in% c("australia","new.zealand")) %>% 
                                    dplyr::select(groups.treated,
                                                  preferred.min.temp.surg
                                    ) %>%
                                    mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric")),
                                           new.min.temp = case_when(preferred.min.temp.surg == 12 ~ 12,
                                                                    preferred.min.temp.surg == 11 ~ 1,
                                                                    TRUE ~ preferred.min.temp.surg + 1
                                           )
                                    ) %>%
                                    na.omit() %>%
                                    mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
                                                                               new.min.temp == 2 ~ "b <32C",
                                                                               new.min.temp == 3 ~ "c 32C",
                                                                               new.min.temp == 4 ~ "d 33C",
                                                                               new.min.temp == 5 ~ "e 34C",
                                                                               new.min.temp == 6 ~ "f 35C",
                                                                               new.min.temp == 7 ~ "g 36C",
                                                                               new.min.temp == 8 ~ "h 37C",
                                                                               new.min.temp == 9 ~ "i 38C",
                                                                               new.min.temp == 10 ~ "j 39C",
                                                                               new.min.temp == 11 ~ "k >39C",
                                                                               new.min.temp == 12 ~ "l not.know"
                                    )))

sum(xtabs(~ groups.treated + new.min.temp,aus.nz.paediatric.pref.min.temp))
coin::wilcox_test(new.min.temp ~ groups.treated,data = aus.nz.paediatric.pref.min.temp)

aus.nz.paediatric.set.max.temp <-   data %>%
                                    filter(country %in% c("australia","new.zealand")) %>% 
                                    dplyr::select(groups.treated,
                                                  set.max.temp.surg
                                    ) %>%
                                    mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric"))) %>%
                                    na.omit() %>%
                                    mutate(set.max.temp.surg = as.ordered(case_when(set.max.temp.surg == 1 ~ "a <36C",
                                                                                    set.max.temp.surg == 2 ~ "b 36C",
                                                                                    set.max.temp.surg == 3 ~ "c 37C",
                                                                                    set.max.temp.surg == 4 ~ "d 38C",
                                                                                    set.max.temp.surg == 5 ~ "e 39C",
                                                                                    set.max.temp.surg == 6 ~ "f 40C",
                                                                                    set.max.temp.surg == 7 ~ "g 41C",
                                                                                    set.max.temp.surg == 8 ~ "h >41C",
                                                                                    set.max.temp.surg == 9 ~ "i no.max",
                                                                                    set.max.temp.surg == 10 ~ "j not.known"
                                    )))

sum(xtabs(~ groups.treated + set.max.temp.surg,aus.nz.paediatric.set.max.temp))
coin::wilcox_test(set.max.temp.surg ~ groups.treated,data = aus.nz.paediatric.set.max.temp)

# Table 1 - description of participants 
participants <- data %>% dplyr::select(country, dr.role)

table1 <- tbl_summary(
  data,
  by = country, missing = 'no'
) %>%
add_n() %>%
#add_p() %>%
modify_header(label = "**Variable**") %>% # update the column header
bold_labels()   


