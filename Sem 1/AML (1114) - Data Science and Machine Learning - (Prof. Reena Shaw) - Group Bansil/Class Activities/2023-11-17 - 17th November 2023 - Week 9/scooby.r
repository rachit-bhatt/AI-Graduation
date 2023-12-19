# shortcut to run: 'Ctrl + Enter'

install.packages("readxl")
library(readxl) # similar to writing 'import pandas as pd'

###########


# Downloaded the Scooby dataset directly from the Github repo:
# Github:  data/2021/2021-07-13/Scooby-Doo Completed.csv
library(readr)
scooby<- read.csv("C:\\Users\\shaws\\Downloads\\Scooby-Doo Completed.csv") #used double-slashes
View(scooby)

colnames(scooby) # similar to pandas' 'df.columns'


# similar to pandas' 'df.info()':
str(scooby) 

install.packages("dplyr")
library(dplyr)
glimpse(scooby)

mean(scooby$run.time) #23.5
mean(scooby$imdb) # results in an error

# typecast 'imdb' into a Double:
scooby$imdb <- as.double(scooby$imdb)
typeof(scooby$imdb)

mean(scooby$imdb)# Gives NA's
tail(scooby$imdb)
mean(scooby$imdb, na.rm = TRUE) # 7.27

#######################################################


# The 'scooby' dataset has already been downloaded from
# the last lecture, and exists as an object in the envt.

# 'scooby$imdb' has already been converted into Double
library("ggplot2") #package, in order to use the 'ggplot()' function.
library("dplyr")
glimpse(scooby) # 603 *75

str(scooby)

scooby_small <- scooby %>% 
  select(series.name : format)         # 603 * 9
# %>% mutate(imdb = as.double(imdb))
View(scooby_small)

colnames(scooby_small)
# [1] "series.name" "network"     "season"      "title"       "imdb"       
# [6] "engagement"  "date.aired"  "run.time"    "format" 
# 

str(scooby_small) # check which variables are categorical
View(scooby_small)

unique(scooby_small$network) # 11 networks


#View the 'imdb' rating wrt 'time' (as a scatterplot):
ggplot(scooby_small, 
       aes(x = date.aired, 
           y = imdb)
)+
  geom_point()  #scatterplot(), only Black dots on a White background




# To display colourful vizlns, load the 'RColorBrewer' package:
install.packages("RColorBrewer")
library("RColorBrewer")

# display the colour-palettes in the 'RColorBrewer' package:
display.brewer.all()


#View the above scatterplot, adding colour:
ggplot(scooby_small, 
       aes(x = date.aired, 
           y = imdb,
           color = format) #add colours based on the values of the categorical 'scooby_small$format' column
)+
  geom_point()   
# + scale_color_brewer(palette = 'Dark2')   #didn't use 'RColorBrewer.scale_color_brewer(palette = 'Dark2')'
# as 'ggplot()' as its own colour palettes.

# Using 'RColorBrewer's' palette:
ggplot(scooby_small, 
       aes(x = date.aired, 
           y = imdb,
           color = format) #add colours based on the values of the categorical 'scooby_small$format' column
)+
  geom_point() + 
  scale_color_brewer(palette = 'Dark2') 


#Due to crowded 'date' values along the x-axis, plot only the 'year'
# along the x-axis:
# Thus, feature-engineer a 'year' column:

################
# Explore the 'format' column:
table(scooby_small$format) # 43 'movies'

# filter to check what 'crossover' means:
scooby_crossover <- filter(scooby_small, format == "Crossover")
View(scooby_crossover)

#Filter out those rows that are not directly 'scooby doo' +
# are not 'TV episodes':
scooby_epi  <- scooby_small %>% 
  filter(format != "Crossover",
         format != "Movie",
         format != "Movie (Theatrical)"
  )
# non-episodic = 8+43+3 = 54
# scooby_episodic = 603-54 rows = 549 rows
View(scooby_epi)
table(scooby_epi$format) # 374 + 175


# The 2nd-group in 'scooby_epi$format' is 'TV Series (segmented)'.
# Here, the same episode is split into multiple parts.

# Thus, the IMDB rating for all the constituent segments 
# will reflect in the form of the same IMDB rating for the entire episode.


#Group the segmented episodes in order to assign them the same IMDB rating:
segmented_epi <- scooby_epi %>% 
  filter(format == "TV Series (segmented)") # 175*9


View(segmented_epi)
# Two segments on 10th Sept and 17th Sept each

segmented_epi <- scooby_epi %>% 
  filter(format == "TV Series (segmented)") %>% 
  group_by(date.aired) %>% 
  summarise(imdb = mean(imdb),
            network = unique(network),
            series.name = unique(series.name),
            total_runtime_per_epi = sum(run.time)) #assign only 1 value of IMDB rating, per group, ie: per row.

View(segmented_epi) # 75* 5cols
colnames(segmented_epi)

nonsegmented_epi <- scooby_epi %>%      # 9 cols
  filter(format != "TV Series (segmented)") %>% 
  select(date.aired,
         imdb,
         network,
         series.name,
         total_runtime_per_epi = run.time)  # 5 cols, to match the structure of 'segmented_epi'
# 374*5 

scooby_cleaned <- rbind(nonsegmented_epi, segmented_epi) # 449*5
View(scooby_cleaned)

unique(scooby_cleaned$network) # 7 unique values of 'network'


# A new vizln:
ggplot(scooby_cleaned, aes(x = date.aired, 
                           y = imdb,
                           colour = network)
) +
  geom_point() +
  scale_color_brewer(palette = 'Dark2') 


#############
# Task: to reduce the 'date' clutter, along the x-axis:

# In 'ggplot()', 'scale_x_date()' works with objects of class 'Date' only.
# thus, convert 'date.aired' column into type 'Date'
scooby_cleaned$date.aired_2 <- as.Date(scooby_cleaned$date.aired, format="%Y-%m-%d")

colnames(scooby_cleaned) #check whether 'date_aired_2' now exists in the DF
dim(scooby_cleaned) # 449*6

colSums(!is.na(scooby_cleaned)) #find the number of non-null values per Column
# ie, 449 non-null values of 'date.aired_2'


#check the min-max values of Date, to supply them as 'limits' in 'ggplot(scale_x_date(...))'
range(scooby_cleaned$date.aired_2, na.rm = TRUE) 
# "1969-09-13"   "2021-02-25"

min(scooby_cleaned$date.aired_2, na.rm = TRUE)
max(scooby_cleaned$date.aired_2, na.rm = TRUE)

# 1.
ggplot(scooby_cleaned, aes(x = date.aired_2,  #2nd version of 'date.aired'
                           y = imdb,
                           colour = network)
) +
  geom_point() +
  scale_color_brewer(palette = 'Dark2') +
  scale_x_date(date_breaks = "10 years", date_minor_breaks = "5 year", date_labels = "%b %Y") 


# 2.
ggplot(scooby_cleaned, aes(x = date.aired_2,  #2nd version of 'date.aired'
                           y = imdb,
                           colour = network)
) +
  geom_point() +
  scale_color_brewer(palette = 'Dark2') +
  scale_x_date(breaks = seq(as.Date("1969-09-13"), as.Date("2021-02-25"), by = "10 years"), 
               date_labels = "%b%y") 




