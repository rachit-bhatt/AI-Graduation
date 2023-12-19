data("cars")

cars

names(cars)

length(cars)
class(cars$speed)

length(cars$speed)
unique(cars$speed)

sort(table(cars), decreasing = TRUE)
View(sort(table(cars), decreasing = TRUE))
barplot(sort(table(cars), decreasing = TRUE))

cars %>%
  select(speed) %>%
  count(speed) %>%
  arrange(desc(n)) %>%
  View()

# Missing Values:
cars[ , "speed"]
cars[is.na(cars$speed)]
View(cars[is.na(cars$speed)])

class(cars$speed)
summary(cars$speed)
boxplot(cars$speed)
View(hist(cars$speed))
