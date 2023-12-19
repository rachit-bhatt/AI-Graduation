

# (I) Having a look at the data:
# Keyboard shortcut to run highlighted LOC's: Ctrl + Enter
dim(iris)
names(iris)
str(iris)

#
head(iris)
tail(iris)

head(iris, 2)
tail(iris, 3)

#return the 1st 3 rows of this DF:
head(iris,3)
iris[1:3, ]
attributes(iris)

# return 1st 10 values of the column 'Sepal.Length':
iris$Sepal.Length[1:10]
iris[1:10 ,"Sepal.Length" ]







# (II) Explore individual variables:
summary(iris) #

install.packages("Hmisc")
library(Hmisc)
describe(iris) #
describe(iris[ , c(1,5)])

range(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(0.1, 0.3, 0.65))

# histogram and variance:
hist(iris$Sepal.Length)
var(iris$Sepal.Length)

# pie-chart:
table(iris$Species)
pie(table(iris$Species))

# barchart:
barplot(table(iris$Species))

# boxplot:
boxplot(iris$Sepal.Length)
boxplot(iris$Petal.Length)
boxplot(iris$Sepal.Length, ylim = c(4,7))


# scatterplot:
plot(iris$Sepal.Length , iris$Petal.Length )
plot(iris$Sepal.Length , iris$Petal.Length, col = iris$Species )


with (iris, 
      plot(Sepal.Length , Petal.Length, col = Species )
      )


with (iris, 
      plot(Sepal.Length , Petal.Length, col = Species, pch = as.numeric(Species) )
      )



# pairplot: matrix of all possible scatterplots
pairs(iris)












