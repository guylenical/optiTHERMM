# missing data analysis from https://finalfit.org/articles/missing.html

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
explanatory <- c(
  "level.of.complexity",
  "hospital.statement", 
  "groups.treated"
)

# Visualisation
data %>% ff_glimpse(dependent1, explanatory)   
data %>% missing_pattern(dependent1, explanatory)
data %>% missing_pairs(dependent1, explanatory)   

data %>% ff_glimpse(dependent2, explanatory)   
data %>% missing_pattern(dependent2, explanatory)
data %>% missing_pairs(dependent2, explanatory)   

data %>% ff_glimpse(dependent3, explanatory)   
data %>% missing_pattern(dependent3, explanatory)
data %>% missing_pairs(dependent3, explanatory)   

data %>% ff_glimpse(dependent4, explanatory)   
data %>% missing_pattern(dependent4, explanatory)
data %>% missing_pairs(dependent4, explanatory)   

