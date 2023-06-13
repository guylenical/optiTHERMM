# missing data analysis

library(finalfit)

# Load data
data <- readRDS("clean_data.rds")

# set explanatory & dependent variables for analysis
dependent1 <- c("min.temp.delay.surg") # minimum body temperature that would delay burn surgery
dependent2 <- c("max.temp.delay.surg") #maximum temperature that would delay burn surgery
dependent3 <- c("preferred.min.temp.surg") # minimum body temperature during burn surgery
dependent4 <- c("set.max.temp.surg") # maximum body temperature during burn surgery

# complexity of burn treated 1
# 'high level care' vs 'lower level care' based on complexity of burns treated. High level = inhalational burn treated + 40% TBSA or more treated there
#  alternatively, 'high level care' could be where a unit ACCEPTS A BURN OF ANY SIZE
explanatory1 <- c(
  "level.of.complexity",
  "hospital.statement" 
)

# adult vs paeds divide
explanatory2 <- c(
  "groups.treated"
)

# Visualisation
data %>% missing_pairs(dependent1, explanatory1)   
data %>% missing_pairs(dependent1, explanatory2)   

data %>% missing_pairs(dependent2, explanatory1)   
data %>% missing_pairs(dependent2, explanatory2)   

data %>% missing_pairs(dependent3, explanatory1)   
data %>% missing_pairs(dependent3, explanatory2)   

data %>% missing_pairs(dependent4, explanatory1)   
data %>% missing_pairs(dependent4, explanatory2)   

# Hypothesis tests
data %>% missing_compare(dependent1, c(explanatory1, explanatory2))
data %>% missing_compare(dependent2, c(explanatory1, explanatory2))
data %>% missing_compare(dependent3, c(explanatory1, explanatory2))
data %>% missing_compare(dependent4, c(explanatory1, explanatory2))

