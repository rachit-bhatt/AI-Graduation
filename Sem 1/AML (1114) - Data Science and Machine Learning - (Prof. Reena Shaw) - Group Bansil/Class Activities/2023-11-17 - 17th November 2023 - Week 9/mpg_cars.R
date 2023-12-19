#######################################################
install.packages("tidyverse")
library(tidyverse)

data() #Shortcut to run a LOC: 'Crtl' + 'Enter'
View(mtcars) 
?mtcars
?mean
names(mtcars)

install.packages('dplyr') # library containing 'glimpse()'
library('dplyr')
glimpse(mtcars) # 32 * 11



# subset: filter by rows:
?filter


# Q1. filtering for cars whose city-mileage is atleast 20:
filter(mtcars, mpg >= 20) # 14*11

mpg_efficient <- filter(mtcars, mpg >= 20)
dim(mpg_efficient)




# Multiline comment: 'ctrl + shift + c'

# Q2. 'mutate': change/ add a col, in the DF
# Task: Mutate the 'mpg' column, to convert 'miles per gallon'
# ....into 'km per litre' (metric system):
mpg_metric <- mutate(mtcars, cty_metric <- mpg * 0.425144 )
View(mpg_metric)
dim(mpg_metric) # 1 extra column => total 12 cols


# Performing the same task as above, this time using the 'Pipe' operator: '%>%'
# Shortcut for 'pipe': 'ctrl + shift + M'
mpg_metric <- mtcars %>% 
                  mutate(cty_metric <- mpg * 0.425144) 

View(mpg_metric)
dim(mpg_metric) # 1 extra column => total 12 cols


# Q3. Grouped summaries:
# Find average weight of the cars ('wt' col), per value of transmission ('am' col):
mpg_metric %>% 
  group_by(am) %>% 
  summarise(mean(wt))


# Q4. Dataviz using ggplot:
install.packages("ggplot2")
library('ggplot2')

?ggplot()

ggplot(mtcars, aes(x = mpg))+
  geom_histogram(bins = 10)+
  labs(x = "City Mileage")



### Q5. Filter for rows where the car name is 'Mercedes': (N.B: 'mercedes' is
## not present as a colname, but as an Index):
mtcars_2 <- mtcars
View(mtcars_2)

rownames(mtcars_2)
mtcars_2$car_name <- rownames(mtcars_2) # creating a new column called 'car_name', containing the values of the row-labels
View(mtcars_2)


install.packages("dplyr")
library('dplyr')
mtcars_2 %>% 
  filter(grepl('merc', ignore.case = TRUE, car_name))








