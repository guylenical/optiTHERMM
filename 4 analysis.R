# Code by Glenn Boardman, Guy Stanley
# to analyse the UK and Australia & New Zealand OptiTHERMM.org data

# TO DO

library(tidyverse)
library(readxl)
library(rstatix)
library(coin)
library(MASS)
library(Hmisc)
library(gtsummary)
rm(list = ls())


# Read data
data <- readRDS("clean_data.rds")

####################### DOCTOR ROLE 
#TODO THIS WILL NEED TO BE REDONE
# AS THE NEWLY CLEANED data HAS BROKEN THE ORDER ASSUMED
# AND NOW INCLUDES UK DATA


aus.nz.role.min.temp.delay <- data %>%
  filter(country %in% c("Australia","New Zealand")) %>% 
  dplyr::select(dr.role,
                min.temp.delay.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other")),
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
  filter(country %in% c("Australia","New Zealand")) %>% 
  dplyr::select(dr.role,
                max.temp.delay.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other"))) %>%
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
  filter(country %in% c("Australia","New Zealand")) %>% 
  dplyr::select(dr.role,
                preferred.min.temp.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other")),
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
  filter(country %in% c("Australia","New Zealand")) %>% 
  dplyr::select(dr.role,
                set.max.temp.surg
  ) %>%
  mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other"))) %>%
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
#TODO THIS WILL NEED TO BE REDONE
# AS THE NEWLY CLEANED data HAS BROKEN THE ORDER ASSUMED
# AND NOW INCLUDES UK DATA

# coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.min.temp.delay)
# coin::wilcox_test(as.numeric(max.temp.delay.surg) ~ dr.role,data = aus.nz.role.max.temp.delay)
# coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.pref.min.temp)
# coin::wilcox_test(as.numeric(set.max.temp.surg) ~ dr.role,data = aus.nz.role.set.max.temp)


## Proportional Odds model
#TODO THIS WILL NEED TO BE REDONE
# AS THE NEWLY CLEANED data HAS BROKEN THE ORDER ASSUMED
# AND NOW INCLUDES UK DATA

# m1 <- polr(max.temp.delay.surg ~ dr.role,data = aus.nz.role.max.temp.delay,Hess = TRUE)
# m1.ctable <- coef(summary(m1))
# m1.p <- pnorm(abs(m1.ctable[, "t value"]), lower.tail = FALSE) * 2
# m1.ctable <- cbind(m1.ctable, "p value" = m1.p)
# m1.ctable
# confint(m1)


#TODO THIS WILL NEED TO BE REDONE
# AS THE NEWLY CLEANED data HAS BROKEN THE ORDER ASSUMED
# AND NOW INCLUDES UK DATA
# m2 <- polr(min.temp.delay.surg ~ 1,data = aus.nz.role,Hess = TRUE)
# 
# 
# ## Test proportional odds assumption
# 
# sf <- function(y) {
#   c('Y>=1' = qlogis(mean(y >= 1)),
#     'Y>=2' = qlogis(mean(y >= 2)),
#     'Y>=3' = qlogis(mean(y >= 3)),
#     'Y>=4' = qlogis(mean(y >= 4)),
#     'Y>=5' = qlogis(mean(y >= 5)),
#     'Y>=6' = qlogis(mean(y >= 6)),
#     'Y>=7' = qlogis(mean(y >= 7)),
#     'Y>=8' = qlogis(mean(y >= 8))
#   )
# }

#TODO THIS WILL NEED TO BE REDONEAS THE NEWLY CLEANED data HAS BROKEN THE ORDER ASSUMED
# (s <- with(aus.nz.role.min.temp.delay, summary(as.numeric(min.temp.delay.surg) ~ dr.role, fun=sf)))
# plot(s, which=1:8, pch=1:4, xlab='logit', main=' ', xlim=range(s[,6:9]))

#################### DOCTORS ROLE WITH MAX/MIN GROUPS COMBINED
#TODO THIS WILL NEED TO BE REDONEAS THE NEWLY CLEANED data HAS BROKEN THE ORDER ASSUMED
# aus.nz.role.min.temp.delay.v2 <- data %>%
#                                   filter(country %in% c("Australia","New Zealand")) %>% 
#                                   dplyr::select(dr.role,
#                                                 min.temp.delay.surg
#                                   ) %>%
#                                   mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other")),
#                                          new.min.temp = if_else(min.temp.delay.surg == 11|min.temp.delay.surg == 1,1,min.temp.delay.surg + 1)
#                                   ) %>%
#                                   na.omit() %>%
#                                   mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
#                                                                              new.min.temp == 3 ~ "c 32C",
#                                                                              new.min.temp == 4 ~ "d 33C",
#                                                                              new.min.temp == 5 ~ "e 34C",
#                                                                              new.min.temp == 6 ~ "f 35C",
#                                                                              new.min.temp == 7 ~ "g 36C",
#                                                                              new.min.temp == 8 ~ "h 37C",
#                                                                              new.min.temp == 9 ~ "i 38C",
#                                                                              new.min.temp == 10 ~ "j 39C",
#                                                                              new.min.temp == 11 ~ "k >39C"
#                                   )))
# 
# 
# 
# xtabs(~dr.role + new.min.temp,aus.nz.role.min.temp.delay.v2)
# coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.min.temp.delay.v2)
# 
# 
# aus.nz.role.max.temp.delay.v2 <- data %>%
#                               filter(country %in% c("Australia","New Zealand")) %>% 
#                               dplyr::select(dr.role,
#                                             max.temp.delay.surg
#                               ) %>%
#                               mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other")),
#                                      new.max.temp = if_else(max.temp.delay.surg == 8|max.temp.delay.surg == 9,as.integer(8),max.temp.delay.surg)
#                                      ) %>%
#                               na.omit() %>%
#                               mutate(new.max.temp = as.ordered(case_when(new.max.temp == 1 ~ "a <36C",
#                                                                          new.max.temp == 2 ~ "b 36C",
#                                                                          new.max.temp == 3 ~ "c 37C",
#                                                                          new.max.temp == 4 ~ "d 38C",
#                                                                          new.max.temp == 5 ~ "e 39C",
#                                                                          new.max.temp == 6 ~ "f 40C",
#                                                                          new.max.temp == 7 ~ "g 41C",
#                                                                          new.max.temp == 8 ~ "h >41C"
#                                                                                 
#                               )))
# 
# xtabs(~dr.role + new.max.temp,aus.nz.role.max.temp.delay.v2)
# coin::wilcox_test(new.max.temp ~ dr.role,data = aus.nz.role.max.temp.delay.v2)
# 
# 
# aus.nz.role.pref.min.temp.v2 <-  data %>%
#                                 filter(country %in% c("Australia","New Zealand")) %>% 
#                                 dplyr::select(dr.role,
#                                               preferred.min.temp.surg
#                                               ) %>%
#                                 mutate(dr.role = as.factor(if_else(dr.role == "Anaesthetist","anaesthetist","other")),
#                                        new.min.temp = case_when(preferred.min.temp.surg == 11|preferred.min.temp.surg == 1 ~ as.integer(1),
#                                                                 preferred.min.temp.surg == 12 ~ as.integer(11),
#                                                                 TRUE ~ preferred.min.temp.surg
#                                                                 )
#                                       ) %>%
#                                 na.omit() %>%
#                                 mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
#                                                                            new.min.temp == 2 ~ "c 32C",
#                                                                            new.min.temp == 3 ~ "d 33C",
#                                                                            new.min.temp == 4 ~ "e 34C",
#                                                                            new.min.temp == 5 ~ "f 35C",
#                                                                            new.min.temp == 6 ~ "g 36C",
#                                                                            new.min.temp == 7 ~ "h 37C",
#                                                                            new.min.temp == 8 ~ "i 38C",
#                                                                            new.min.temp == 9 ~ "j 39C",
#                                                                            new.min.temp == 10 ~ "k >39C",
#                                                                            new.min.temp == 11 ~ "l not.know"
#                                 )))
# 
# 
# 
# xtabs(~dr.role + new.min.temp,aus.nz.role.pref.min.temp.v2)
# coin::wilcox_test(new.min.temp ~ dr.role,data = aus.nz.role.pref.min.temp.v2)
# 
# ################### ADULT/PAEDIATRIC
# aus.nz.paediatric.min.temp.delay <- data %>%
#                                     filter(country %in% c("Australia","New Zealand")) %>% 
#                                     dplyr::select(groups.treated,
#                                                   min.temp.delay.surg
#                                     ) %>%
#                                     mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric")),
#                                            new.min.temp = if_else(min.temp.delay.surg == 11,1,min.temp.delay.surg + 1)
#                                     ) %>%
#                                     na.omit() %>%
#                                     mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
#                                                                                new.min.temp == 2 ~ "b <32C",
#                                                                                new.min.temp == 3 ~ "c 32C",
#                                                                                new.min.temp == 4 ~ "d 33C",
#                                                                                new.min.temp == 5 ~ "e 34C",
#                                                                                new.min.temp == 6 ~ "f 35C",
#                                                                                new.min.temp == 7 ~ "g 36C",
#                                                                                new.min.temp == 8 ~ "h 37C",
#                                                                                new.min.temp == 9 ~ "i 38C",
#                                                                                new.min.temp == 10 ~ "j 39C",
#                                                                                new.min.temp == 11 ~ "k >39C"
#                                     )))
# 
# xtabs(~groups.treated + new.min.temp,aus.nz.paediatric.min.temp.delay)
# coin::wilcox_test(new.min.temp ~ groups.treated,data = aus.nz.paediatric.min.temp.delay)
# 
# 
# aus.nz.paediatric.max.temp.delay <- data %>%
#                                     filter(country %in% c("Australia","New Zealand")) %>% 
#                                     dplyr::select(groups.treated,
#                                                   max.temp.delay.surg
#                                     ) %>%
#                                     mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric"))) %>%
#                                     na.omit() %>%
#                                     mutate(max.temp.delay.surg = as.ordered(case_when(max.temp.delay.surg == 1 ~ "a <36C",
#                                                                                       max.temp.delay.surg == 2 ~ "b 36C",
#                                                                                       max.temp.delay.surg == 3 ~ "c 37C",
#                                                                                       max.temp.delay.surg == 4 ~ "d 38C",
#                                                                                       max.temp.delay.surg == 5 ~ "e 39C",
#                                                                                       max.temp.delay.surg == 6 ~ "f 40C",
#                                                                                       max.temp.delay.surg == 7 ~ "g 41C",
#                                                                                       max.temp.delay.surg == 8 ~ "h >41C",
#                                                                                       max.temp.delay.surg == 9 ~ "i no.max"
#                                     )))
# 
# xtabs(~groups.treated + max.temp.delay.surg,aus.nz.paediatric.max.temp.delay)
# coin::wilcox_test(max.temp.delay.surg ~ groups.treated,data = aus.nz.paediatric.max.temp.delay)
# 
# aus.nz.paediatric.pref.min.temp <-  data %>%
#                                     filter(country %in% c("Australia","New Zealand")) %>% 
#                                     dplyr::select(groups.treated,
#                                                   preferred.min.temp.surg
#                                     ) %>%
#                                     mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric")),
#                                            new.min.temp = case_when(preferred.min.temp.surg == 12 ~ 12,
#                                                                     preferred.min.temp.surg == 11 ~ 1,
#                                                                     TRUE ~ preferred.min.temp.surg + 1
#                                            )
#                                     ) %>%
#                                     na.omit() %>%
#                                     mutate(new.min.temp = as.ordered(case_when(new.min.temp == 1 ~ "a no.min",
#                                                                                new.min.temp == 2 ~ "b <32C",
#                                                                                new.min.temp == 3 ~ "c 32C",
#                                                                                new.min.temp == 4 ~ "d 33C",
#                                                                                new.min.temp == 5 ~ "e 34C",
#                                                                                new.min.temp == 6 ~ "f 35C",
#                                                                                new.min.temp == 7 ~ "g 36C",
#                                                                                new.min.temp == 8 ~ "h 37C",
#                                                                                new.min.temp == 9 ~ "i 38C",
#                                                                                new.min.temp == 10 ~ "j 39C",
#                                                                                new.min.temp == 11 ~ "k >39C",
#                                                                                new.min.temp == 12 ~ "l not.know"
#                                     )))
# 
# sum(xtabs(~ groups.treated + new.min.temp,aus.nz.paediatric.pref.min.temp))
# coin::wilcox_test(new.min.temp ~ groups.treated,data = aus.nz.paediatric.pref.min.temp)
# 
# aus.nz.paediatric.set.max.temp <-   data %>%
#                                     filter(country %in% c("Australia","New Zealand")) %>% 
#                                     dplyr::select(groups.treated,
#                                                   set.max.temp.surg
#                                     ) %>%
#                                     mutate(groups.treated = as.factor(if_else(groups.treated == "adults","adult","paediatric"))) %>%
#                                     na.omit() %>%
#                                     mutate(set.max.temp.surg = as.ordered(case_when(set.max.temp.surg == 1 ~ "a <36C",
#                                                                                     set.max.temp.surg == 2 ~ "b 36C",
#                                                                                     set.max.temp.surg == 3 ~ "c 37C",
#                                                                                     set.max.temp.surg == 4 ~ "d 38C",
#                                                                                     set.max.temp.surg == 5 ~ "e 39C",
#                                                                                     set.max.temp.surg == 6 ~ "f 40C",
#                                                                                     set.max.temp.surg == 7 ~ "g 41C",
#                                                                                     set.max.temp.surg == 8 ~ "h >41C",
#                                                                                     set.max.temp.surg == 9 ~ "i no.max",
#                                                                                     set.max.temp.surg == 10 ~ "j not.known"
#                                     )))
# 
# sum(xtabs(~ groups.treated + set.max.temp.surg,aus.nz.paediatric.set.max.temp))
# coin::wilcox_test(set.max.temp.surg ~ groups.treated,data = aus.nz.paediatric.set.max.temp)
# 
