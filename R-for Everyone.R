

# Chapter 4 ---------------------------------------------------------------


# 4.2 Variables -----------------------------------------------------------



## 4.2.1 Variable Assignment: There are several ways of assigning variables in R. 
1: x <- 2
2: y = 5
3: 3 -> z
assign ("j", 4)
 
## You can do multiple assignments

1: a <- b <- 7

## 4.2.2 Removing Variables

1: rm(j) # This frees up memory in R
2: gc(a) # This frees up memory in the operating system. R does it automatically so you don't necessarily have to do this R does it for you already. 


# 4.3 Data Types ----------------------------------------------------------

## 4.3.1 Numeric Data 

# Integer and Numeric. Integer is also considered a numeric. 
# Assigning integers is like this 
i <- 5L
class(i)
is.numeric(i)

## 4.3.2 Character Data 
# R has two ways of handling character data: character and factor
x <- 'data'
# To find the length of a character or a numeric you can use
nchar

## 4.3.3 Dates
# use as.Date to convert to a date
date1 <- as.Date("2012-06-28")
# Using functions such as the as.numeric or as.Date does not merely change the formatting of an object but actually changes the underlying type

## 4.3.4 Logical


# 4.4 Vectors -------------------------------------------------------------
# R is a vectorized language. Operations are applied to each element of a vector automatically, without the need to loop through the the vector. 

## 4.4.1 Vector Operations
vector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# Multiply each element by 3

vector * 3
# Additionally you can do other mathematical operations. 

# You can also create similar vectors using the :, which creates a sequence of numbers in either direction

vector_1 <-   2:11
vector_2 <-  -4:5

# You can perform similar functions by vectors (e.g. multiplying two vectors) if they both have equal lengths. 
# Multiply:
vector_1 * vector_2
# Add
vector_1 + vector_2 
# you can check the length with the length statement

length (vector_1)

# Note: If two unequal operators, then the shorter vectors gets recycled --that is, it's elements are repeated, in order, until they have been matched up with every element of the longer vector. If the longer one is not a multiple of the shorter one, a warning is given. See example below: 

vector + c(1,2)
#In this case the Vector which is 1: 10 is a multiple of c(1,2), let's see what happens if it's not with example below:

vector + c(1,2,3)
# Warning message:
#     In vector + c(1, 2, 3) :
#     longer object length is not a multiple of shorter object length
# You end up with the following vector 2 4 6 5 7 9 8 10 12 11. The C(1,2,3) keeps getting added onto the vector (1:10)
# so you get 1 + 1, 2+2, 3+3, 1+4, 2+5, 3+6, 1+7, 2+8, 3+9, 1+10

# Comparisons also work on vectors.  Here the result is a vector of the same length containing TRUE of FALSE for each element. 

vector <= 5

# You can this operation on vectors too

vector_1 > vector_2

# You can also use the all or any function to check whether all or any of the comparisons are true. 

any(vector_1 < vector_2)
all(vector_1 > vector_2)
any(vector_1 > vector_2)

 # You can also access single, consecutive or nonconsecutive elements of a vector by using the square bracket [ ]

vector_1 [1]
vector_2 [5:6] # consecutive
vector[c(1,7)] # nonconsecutive

# You can also name the vectors either during or after the creation by element
Vector_Name <- c(One = "a", Two = "b", Last = "r")

w <- 1:3
names(w) <- c("a", "b", "c")

## 4.4.2 Factor Vectors
# Let's create a vector of text data

q <- c("Hockey", "Football", "Baseball", "Curling", 'Rugby', "Lacrosse", 'Basketball', 'Tennis', "Cricket", 'Soccer')
q2 <- c(q, "Hockey", "Lacrosse", "Hockey", 'Water Polo', 'Hockey', 'Lacrosse')

# Now convert to a factor using as.factor

q2_Factor <- as.factor(q2)
# You'll notice R also assigns a unique factor to each element, giving each character element a unique integer value
as.numeric(q2_Factor)
# You can also set the level of the factor

factor(x = c("High School", "College", "Masters", "Doctorate"), 
       levels = c ("High School", "College", "Masters", "Doctorate"), 
       ordered= TRUE)

# 4.5 Calling Functions ---------------------------------------------------

mean (vector)


# 4.6 Function Documentation ----------------------------------------------

# use ? before function to see what it does. If you have a gist of the function, you can use the apropos ("mean") to find out about it. 
apropos ("mean")

# 4.7 Mission Data --------------------------------------------------------

# Two types: NA and NULL

## 4.7.1 NA

# R uses NA to reprsent missing data. You can use the is.na to check fo missingness
z <- c(1, 3, NA, 3, NA)
is.na(z)
# Same thing works for character

# if you calculate the mean of z, you will get NA because even if a single element is missing, the mean won't be calculated

mean(z)

#If you want R to ignor the missing and calculate the mean then use the na.rm = TRUE, which first removes the missing data

mean(z, na.rm = TRUE)
# This is also true for sum, min, max, var, sd and other functions. 

##4.7.2 NULL
# Unlike NA which is missingness, NULL is more like nothingness. You cannot use it within a vector as it will treat it as not existing at all and so it disappears

null_check <- c(1, NULL, 6)
null_check
# When you run the above "null_check", it will only return 1, 6. You can use is.null to test for NULL value. 

# 4.8 Pipes ---------------------------------------------------------------

# Using the "magrittr" package. What the pipe does is it uses the object or value from the left hand side of the pipe and inserts it into the first argument of the function on the right hand side of the pipe. 
library(magrittr)
pipe_example <- 1:10
mean(pipe_example)
# You can use the above using the pipe instead

pipe_example %>% mean# ctrl +shift + M is the shortcut
 #Another example

pipe_example_2 <- c(1, 3, NA, 6, NA, 3, NA)
sum(is.na(pipe_example_2))

# Can do the same in Pipe

pipe_example_2 %>% is.na %>% sum

#When piping an object into a function and not seeting any additional arguments, no parenthese are needed. However, if addtional arguments are used, then they should be named and included inside the parentheses after the function call. The first argument is not used, as the pipe already inserted the left-hand object into the first argument. 

mean(pipe_example_2, na.rm = TRUE)

# Or using pipe

pipe_example_2 %>% mean (na.rm = TRUE)



# Chapter 5: Advanced Data Structures -------------------------------------


# 5.1 data.frames ---------------------------------------------------------


