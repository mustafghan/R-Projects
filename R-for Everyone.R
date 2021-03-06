
# Chapter 4: Basics of R --------------------------------------------------

# 4.2 Variables -----------------------------------------------------------



## 4.2.1 Variable Assignment: There are several ways of assigning variables in R. 
x <- 2
y = 5
3 -> z
assign ("j", 4)
 
## You can do multiple assignments

a <- b <- 7

## 4.2.2 Removing Variables

rm(j) # This frees up memory in R
gc(a) # This frees up memory in the operating system. R does it automatically so you don't necessarily have to do this R does it for you already. 


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

# data.frame is just like an Excel spreadsheet in that it has columns and rows. In statistical terms, each column is a variable and each row is an observation. 
 # In terms of how R organizes data.frames, each column is actually a vector, each different types of data. This also implies that within a column each element must be of the same type, just like with vectors. 
 # There are numerous ways to construct a data.frame, the simplest being to use the data.frame function. 
x <- 10:1
y <- -4:5
q <- c("Hockey", "Football", "Baseball", 'Curling', 'Rugby', "Lacrosse", "Basketball", "Tennis", 'Cricket', 'Soccer')
theDF <- data.frame(x,y,q)

# We can assign names during the creation process

theDF <- data.frame(First = x, Second = y, Sport = q)

#To check for row and column and both use
nrow(theDF)
ncol(theDF)
dim (theDF)

# We can also check names

names(theDF)

# or individual elements

names(theDF) [3]

# we can also assign row names

rownames(theDF)
rownames(theDF) <- c("One", "Two", "Three", "Four", "Five", "Six", 'Seveon', 'Eight', 'Nine', "Ten")
rownames(theDF)

# You can also set it back to generic by the following code
rownames (theDF) <- NULL

# you can use head() or tail() to print only first or last few rows from a data.frame

head(theDF)
tail(theDF)

# or set how many rows you want to see

head(theDF, n = 10)

head(theDF, n = 20)

# We can check the class as well

class(theDF)
# You can access specific column using $ or squar bracket

theDF$First

# You can access position, First is row, second is the column number. So to get the third row from the second column we use 
theDF[3, 2]

# To specify more than one row or column, use a vector of indices. Here it is row 3, columns 2 through 3

theDF[3, 2:3]

# rows 3 and 5, column 2
# since only one column was selected it was returned as a vector
# hence the column names will not be printed
theDF[c(3,5), 2]

# rows 3 and 5, columns 2 through 3
theDF[c(3,5), 2:3]

# To access an entire row, specefif that row, and likewise to access only a column, specify that column. 
theDF[ ,3]

# all of columns 2 through 3
theDF[ ,2:3]

# all of row 2
theDF[2, ]

# all of rows 2 through 4
theDF[2:4, ]

# you can access multiple columns by name, by making column argument a character vector of the names
theDF[, c("First", "Sport")]

# Yet another way of accessing a specefic column
theDF["Sport"]

# or the following, and return a (factor) vector
theDF[, 'Sport']
class(theDF[, "Sport"])

# or the following
theDF[["Sport"]]
class(theDF[["Sport"]])

# To get a single-column data.frame instead of vector, you can use the drop = FALSe
theDF[, "Sport", drop = FALSE]
class(theDF[, "Sport", drop = FALSE])

# this does the same
theDF[, 3, drop = FALSE]
class(theDF[, 3, drop = FALSE])

# Factors are stored specially. To see how they would be represented in data.frame form, use modle.matrix to create a set of indicators (or dummy) variables. That is one column for each level of a factor, with a 1 if a row contains that level or a 0 otherwise. 

newFactor <- factor(c("Pennsylvania", "New York", "New Jersey", "New York", "Tennessee", "Massachusetts", "Pennsylvania", "New York"))

model.matrix(~ newFactor -1)



# 5.2 Lists ---------------------------------------------------------------

# Lists are created with the list function where each argument to the function becomes an element of the list
# create a three element list
list(1,2,3)

# creates a single element list. 
# the only element is a vector that has three elements
list(c(1,2,3))

# creates a two element list
# the first is a three element vector
# the second element is a five element vector
list3 <- list(c(1,2,3), 3:7)

# two element list
# first element is a data.frame
# second element is a 10 element vector
list (theDF, 1:10)

# three element list
# fist is a data.frame
# second is a vector
# third is list3 which holds two vectors
list5 <- list(theDF, 1:10, list3)

# LIke data.frames, lists can have names. Each element has a unique name that can be either viewed or assigned using names. 
names(list5) <- c("data.frame", "Vector", "list")
names(list5)

# You can also assigned them during creation
list6 <- list(TheDataFrame = theDF, TheVector = 1:10, TheList = list3)
names(list6)

# You can also create an empty list. The bracket in the beginning allows you to show the result while creating using vector
(emptyList <- vector(mode = "list", length = 4))

# To access an individual element of a list, use double square brackets, specifying either the element or the name. Note that this allows access to only one element at a time
list5[[2]]

#or using the name
list5[["data.frame"]]

# Once an element is accessed it can be treated as if that actual element is being used, allowing nested indexing of elements. 
list6[[1]]$Sport

# It is possible to append elements to a list simpl by using an index (either numeric or named) that does not exist. 

# see how long it currently is
length (list5)

# add a fourth element, unnamed
list5[[4]] <- 2
length(list5)

# add a fifth element, name

list5[["NewElement"]] <- 3:6
length(list5)
names(list5)


# 5.3 Matrices ------------------------------------------------------------
# It is similar to data.frame with one exception: every single element, regardless of column, must be the same type, most commonly all numerics. They also act similarly to Vectors with element-by-element addition, multiplication, subtraction, division and equality. The nrow, ncol, and dim functions work just like they do for data.frames. 

# create a 5x2 matrix
A <- matrix(1:10, nrow=5)

# create another 5x2 matrix
B <- matrix(21:30, nrow=5)

# create another 2x10 matrix
C <- matrix(21:40, nrow = 2)

# you can use nrow, ncol, and dim

nrow(A)
ncol(A)
dim(A)

# add them
A + B # and etc

# see if the elements are equal
A == B

# There are two special vectors,letters and LETTERS, that contain the lower case and the upper case letters, respectively. 
colnames(B) <- LETTERS[1:2]
                       

colnames(C) <- letters[1:10]

# 5.4 Arrays --------------------------------------------------------------

# An array is essentially a multidimensional vector. It must all be of the same type, and individual elements are accessed in a similiar fashion using []. First element is row index, second is column index, and remaining elements are for outer dimensions. 

theArray <- array(1:12, dim = c(2,3,2))

theArrayName <- array(1:12, 
                      dim = c (2,3,3), 
                      dimnames = list(
                          c("One","Two"), 
                          c("Yak", "Doo", "Say"), 
                          c("Aik", "Do", "Theen")))

theArrayName[1, ,] # first element of first row for every column and outside dimension

theArrayName[1, , 1] # first elements of first row of only the first outside dimension

theArrayName[, , 1] # all the elements of the first outside dimension


# Chapter 6: Reading Data into R ------------------------------------------


# 6.1 Reading CSVs --------------------------------------------------------

# read.table is best way to read CSV files, but we can also use rea.csv, which is a wrapper around read.table.
# you can read the csv file directly from the website for example. 

theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <- read.table(file = theUrl, header = TRUE, sep = ",")

# 6.1.1 read_delim......... 
# We use the readr package. Bunch of functions for reading text files, with read_delim the most common for reading text files. This is faster than read.table. 

library(readr)
tomato2 <- read_delim(file = theUrl, delim = ",") # This returns a tibble in stead of the regular data.frame. You can also use the hea.read_delim to display the data. 
 # The other advantage is that you don't have to specify stringsasFactors = FALSE. Compare the Source column in tomato data.frame (shows it as factor). There are presets of read_csv and read_tsv. 

# 6.1.2 fread.................
# This is another option for reading large data quickly is fread from the data.table package. The first argument is the full filename or URL of the file to be read. The header argument indicates that the first row of the file holds the column names and the sep specifies the field delimiter. This function has a stringsAsFactors argument that is set to FALSE by default. 

library(data.table)
theUrl_2 <- "C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\TomatoFirst.csv"
tomato_1 <- fread(input=theUrl_2,sep=',', header=TRUE)

# So both read_delim and fread are faster than read.table. The option of which one to use depends on where dplyr or 
# data.table is preferrred for data manipulation. 

# 6.2 Excel Data ----------------------------------------------------------

# You can read excel files (both xls and xlsx) using the read_excel. However, unlike fread and read_delim, you cannot read the excel file directly from a site. You have to download it first and then single Excel sheet. If you want to do it directly from a website, you can use the download.file syntax. 

download.file(url = 'http://www.jaredlander.com/data/ExcelExample.xlsx', destfile = 'C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\ExcelExample.xlsx', method = 'curl')

# After downloading the file, we check the sheets in the Excel file. 

library(readxl)
excel_sheets('C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\ExcelExample.xlsx')

# By default read_excel reads the first sheet and creates a tibble instead of a data.frame. data.frame

tomatoXL <- read_excel('C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\ExcelExample.xlsx')

 # Specifying which sheet to read can be done by either supplying the sheet position as a number or the actual name of the sheet as a character. 

# using position

wineXL <- read_excel ("C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\ExcelExample.xlsx", sheet = 2)

# using name
wineXL2 <- read_excel ("C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\ExcelExample.xlsx", sheet = "Wine")
 


# 6.3 - 6.4 Reading from Databases and also from Other Statistical --------

# You can read from Databases similar to the excel file, but it's not really that widely used anyways. 
# You can read files from spss, sas, stata, using the foreign which is similar to read.table in that you get a data.frame. # You can also use the haven package and read files into a tibble (read_spss, read_sas, read_stata)


# 6.5 R Binary Files ------------------------------------------------------

# When working with other R programmers, a good way to pass around data--or any R objects such as variables and functions is to use RData files. These are binary files that represents objects of any kind, whether single or multiple objects and can be passed among Windows, Mac, Linux without any issues. Example below

# save the tomata data.frame to disk

save(tomato, file = "C:/Users/mustafa.zia/Desktop/R/R-Projects/tomata.rdata")

# remove tomato from memory
rm(tomato)

# read it from the rdata file
load("C:\\Users\\mustafa.zia\\Desktop\\R\\R-Projects\\tomata.rdata")

# Now let's create a few objects to store in a single RData file, remove them and then load them again. 

# create some objects
n <- 20
r <- 1:10
w <- data.frame(n, r)

# save them
save(n,r,w, file = "C:/Users/mustafa.zia/Desktop/R/R-Projects/multiple.rdata")

# remove them
rm(n,r,w)

# load them
load("C:/Users/mustafa.zia/Desktop/R/R-Projects/multiple.rdata")


 # If you just saved the w without the n and the r, then you won't be able to type n and see the value as it is not loaded as a separate object. 

save(w, file = "C:/Users/mustafa.zia/Desktop/R/R-Projects/w.rdata")
load("C:/Users/mustafa.zia/Desktop/R/R-Projects/w.rdata")

# so now when you type n, you won't get anything cause it wasn't loaded. 


# 6.6 Data Included with R ------------------------------------------------

# You can use the ggplot2 comes with the diamond dataset. You can call it using the data function.

data(diamonds, package = 'ggplot2')


# Extract Data from Web Sites ---------------------------------------------

# 6.7.1 Simple HTML Tables....
# If the data is stored neatly in an HTML table, we can use readHTMLTable in the XML package to easily extract it. 

library(XML)
theURL_XML <- "https://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL_XML, which = 1, header=FALSE, stringsASFactors=FALSE)

# the which says which table to read. it could as well be the second, third, or fourth table. 

# 6.7.2 Scraping Web Data......................

# Information is often scattered about in tables, divs, spans, or other HTML delements. As an example we put the menu and restaurant details for RIbalta, a beloved NY pizzeria, into an HTML file. The address and phone number are stored in an ordered list, section identifiers are in spans and the items and prices are in tables. We use the rvest package to extract the data into a usable format. 

library(rvest)
ribalta <- read_html("http://www.jaredlander.com/data/ribalta.html")
class(ribalta)
ribalta

# By exploring the HTML we see that the address is tored in a span, which is an element of an ordered list. Firs twe use html_nodes to select all span alements within ul elements. .........Won't go much into it. 


# 6.8 Reading JSON Data ---------------------------------------------------

# A popular format for data, especially for APIs and document databases, is JSON, which stands for JavaScript Object Notation. It is a data format, stored in plain text, which is well suited for nested data. The two main R packages for reading JSON data are rjson and jsonlite. 

# The data for this example is a sample from a JSON file listing some of our favorite pizza places in New York. There is an entry for each pizzeria. Within that is a Name element and an array, named Details, that holds elements for Address, City, State, Zip and Phone. 

#The fromJSON function reads the file into R and parses the JSON text. By default, it attempts to sipmlify the data into a data.frame. 

library(jsonlite)
pizza <- fromJSON('http://www.jaredlander.com/data/PizzaFavorites.json')

# The result is a two-column data.frame where the first column is the Name and the second column, named Details, is actually a one-row data.frame for each row of the outer data.frame. This may seem odd, but storing objects in cells of data.frames has long been possible and has recently become more and more the norm. We can see the Details is a list-column where each element is a data.frame. 
class(pizza)
class(pizza$Details)
class(pizza$Name)
class(pizza$Details[[1]])

# This nested structure of a data.frame within a data.frame is best unraveled using the tools availalbe in dplyr, tidyr, and purr. 



# Chapter 7: Statistical Graphics -----------------------------------------


# Chapter 8: Writing R functions ------------------------------------------

# Really good for cutting down on code that needs to be repeated over and over again. However, in R it is alittle different compared with other programming languages. 

# 8.1 Hello, World! -------------------------------------------------------

# Function that simply prints "Hello, World!"
say.hello <- function()
{
  print("Hello, World!")
}
# First, note that in R the period (.) is just another character and has no special meaning, unlike in other languages. The body of the function is enclosed in curly braces ({}). This is not necessary if the function contains only one line, but that is rare. Notice the indenting for the commands inside the function. While not required, it is good practice to properly indent code to ensure readability. It is here in the body that we put the lines of code we want the function to perform. Calling say.hello() prints as described. 

say.hello ()

# 8.2 Function Arguments --------------------------------------------------
# We use the sprintf function. It's first argument is a string with special input characters and subsequent arguments that will be substituted into the special input characters. 

# one substitution example
sprintf("Hello %s", "Jared")

# two substitution example
sprintf("Hello %s, today is %s", "Mustafa","wonderful day")

# We now use springf to build a string to print based on a function's argument

hello.person <- function(name)
{
    print(sprintf("Hello %s", name))
}

hello.person("Mustafa")
hello.person("Sophia")

#The argument name can be used as a variable inside the function (it does not exist outside the function). It can also be used like any other variable and as an argument to further function calls. 

# We can add a second argument to be printed as well. When calling functions with more than one argument, there are two ways to specify which argument goes with which value, either positionally or by name. 

hello.person_2 <- function(first,last)
{
    print(sprintf("Hello %s %s", first, last))
    
}

# by position
hello.person_2("Mustafa", "Zia")

# by name
hello.person_2(first = "Mustafa", last = "Zia")

# the other order
hello.person_2(last = "Zia", first = "Mustafa")

# just specify one name
hello.person_2(last = "Zia", "Mustafa")

# specify the other
hello.person_2(first = "Mustafa", "Zia")

# Being able to specify the arguments by name adds a lot of flexibility to calling functions. Even partial argument names can be supplied, but it is not really recommended and should be done with caution. 

hello.person_2(f = "Mustafa", l = "Zia")

# 8.2.1 Default Arguments............................

# When using multiple arguments it is sometimes desirable to not have to enter a value for each. In other languages functions can be overloaded by defining the function multiple times, each with a differing number of arguments. R instead provides the capability to specify default arguments. These can be NULL, characters, numbers, or any valid R object. Let's rewrite hello.person to provide "Doe" as the default last name

hello.person_3 <- function(first, last = "Doe")
{print(sprintf("Hello %s %s", first, last))
}
# Call without specifying last
hello.person_3 ("Jared")

# Call with a different last
hello.person_3 ("Jared", "Lander")

# 8.2.2 Extra Arguments..............................

# R offers special operator that enables functions to take an arbitrary number of arguments that do not need to be specified in the function definition. this is the dot-dot-dot argument (...). This should be used very carefully, although it can provide great flexibility. For now we will just see how it can absorb extra arguments; later we will find a use for it when passing arguments between functions. 

# First we have to build the function with ... to absorb the extra argument. 
hello.person_4 <- function(first, last ="Doe", ...)
{  
    print(sprintf("Hello %s %s", first, last))
}
# call hello.person_4 with an extra argument
hello.person_4 ("Jared", extra = "Goodbye")

#call it with two valid arguments and a third
hello.person_4 ("Jared", "Lander", "Goodbye")


# 8.3 Return Values -------------------------------------------------------

#Functions are generally used for computing some value, so they need a mechanism to supply that value back to the caller. This is called returning and is done quite easily. There are two ways to accomplish this with R. The value of the last line of code in a function is automatically returned, although this can be bad practice. The return command more explicitly specifies that a value should be returned and the function should be exited. To illustrate, we will build a function that doubles its only arguments and returns that value. 

# first build it without an explicity return
double.num <- function(x)
{
    x * 2
}
double.num(34)

# now build it with an explicit return
double.num_1 <- function(x)
{
    return(x * 2)
}

double.num_1 (55)

# build it again, this time with another argument after the explicity return

double.num_2 <- function(Mustafa)
{
    return(Mustafa * 6)
    
    # below here is not executed because function already exited
    print("Hello!")
    return(17)
}
double.num_2(5)

# build it again, with only one explicit return

double.num_3 <- function(y)
{
    (y * 5)
    print("Hello!")
    return(17)
}

double.num_3(5)


# 8.4 do.call -------------------------------------------------------------

# A particularly underused trick is the do.call function. This allows us to specify the name of a function either as a character or as an object, and provide arguments as a list. 

do.call("hello.person_4", args=list(first="Shahram", last="Zia"))

do.call(hello.person_3, args=list(first="Mustafa", last = "Zia"))

# This is particularly useful when building a function that allows the user to specify an action. In the following example the user supplies a vector and a function to be run. 

run.this <- function(x, func=mean)
{
    do.call(func, args=list(x))
}

# finds the mean by default
run.this(1:50)

# specify to calculate the mean

run.this(1:10, mean)

# calculate the sum
run.this (1:10, sum)

# calculate the standard deviation
run.this(2:8, sd)


# Chapter 9: Control Statements -------------------------------------------
# Control statements allow us to control the flow of our programming and cause different things to happen, depending on the values of tests. Tests result in a logical, TRUE or FALSE, which is used in if-like statements. The main control statements are if, else, ifelse, and switch. 


# 9.1 if and else ---------------------------------------------------------

# The most common test is the if command. It essentially says if something is TRUE, then perform some action; otherwise, do not perform that action. The thing we are testing goes inside parentheses following the if command. The most basic checks are: equal to (==), less than (<), less than or equal to (<=), greater than (>), greater than or equal to (>=) and not equal (!=). 
# If these tests pass they result in TRUE, and if they fail they result in FALSE. As noted in SEction 4.3.4, TRUE is numerically equivalent to 1 and FALSE is equivalent to 0. 
as.numeric(TRUE)
as.numeric(FALSE)

# Tests don't have to be used inside if statements. 

1 == 1
1<1  # etc. 

# Now we show how to use test inside an if statement. 
# set up a variable to hold 1

toCheck <- 1

#if toCheck is equal to 1, print hello
if(toCheck == 1)
{
    print("Hello")
}

#if toCheck is equal to 5, print hello
if(toCheck == 5)
{
    print("Mustafa")
}
# Since toCheck is not equal to 5, when you run it nothing happens. Make sure the whoel statement is run.  

# Notice that if statements are similar to functions, in that all statements (there can be one or multiple) go inside curly braces. Life is not always so simple that we want an action only if some relationship is TRUE. We often want a different action if that relationship is FALSE. In the following example we put an if statement followed by an else statement inside a function, so that it can be used repeatedly.

# first create the function
check.bool <- function(a)
{
    if (a == 1)
    {
        # if the input is equal to 1, print hello
        print("hello")
        
    } else
    {
        print("goodbye")
    }
}

# Notice that else is on the same line as its preceding closing curly brace (}). This is important, as the code will fail otherwise. Now let's use that function and see if it works. 

check.bool(1)   # gives you hello
check.bool(0)   # gives you goodbye
check.bool("M") # gives you goodbey
check.bool(TRUE)# gives you hello

# Anything other than 1 caused the function ti print "goodbye". This is exactly what we wanted. Passing TRUE printed "hello" because TRUE is numerically the same as 1. 
# Perhaps we want to successively test a few cases. That is where we can use else if. We first test a signel statement, then make another test, and then perhaps fall over to catch all. We will test is using a new check.bool

check.bool_1 <- function(x)
{    
    if (x==1)
    {
        # if the input is equal to 1, print hello
        print ("Hello")
    }
    else if (x == 0)
    {
        # if the input is equal to 0, print Goodbye
        print ("Goodbye")
    }
    else
    {
        # otherwise print confused
        print("confused")
    }    
}

check.bool_1(1)   # gives you hello
check.bool_1(0)   # gives you Goodbye
check.bool_1("k") # gives you confused
check.bool_1(5)   # gives you confused
check.bool_1(FALSE) # gives you Goodbye

# 9.2 Switch --------------------------------------------------------------

# 


# If we have multiple cases to check, writing else if repeatedly can be cumbersome and inefficient. This is where switch is most useful. The first argument is the value we are testing. Subsequent arguments are a particular value and what should be the result. The last argument, if not given a value, is the default result. Here we build a function that takes in a value and returns a corresponding result,

use.switch <- function(x)
{switch (x, 
         "a" = "first",
         "b" = "second",
         "z" = "last",
         "c" = "third",
         "other")
}
use.switch("a")
use.switch("c")
use.switch("mustafa")
use.switch(TRUE)

# if the first argument is numeric, it is matched positionally to the followin arguments, regardless of the names of the subsequent arguments. If the numeric arguments is greater than the number of subsequent arguments, NULL is returned. 

use.switch(2)
use.switch(5)
use.switch(8)

is.null(use.switch(6))


# 9.3 ifelese -------------------------------------------------------------

# While if is like the if statment in traditional languages, ifelse is more like the if function in Excel. The first argument is the condition to be tested (much like in a traditional if statement), the second argument is the return value if the test is TRUE and the third argument is the return value if the test is FALSE. The beauty here -- unlike with the traditional if is that this works with VECTORIZED arguments. As is often the case in R, using vectorization avoids for loops and speeds up our code. The nuances of ifelse can be tricky, so we show numerous examples. We start with a very simple example, testing whether 1 is equal to 1 and printing "Yes" if that is TRUE and "No" if it is FAlSE. 

# see if 1 == 1 
ifelse( 1 == 1, "Yes", "No")

# see if 1 == 0 
ifelse(1 == 0, "Yes", "No")

# This clearly gives us the results we want. ifelse uses all the regular equality tests seen in Section 9.1 and any other logical tests. It is worth noting, however, that if testing just a single element ( a vector of length 1 or a simple is.na), it is more efficient to use if than ifelse. This can result in nontrivial speedup of our code. 

# Next we will illustrate a vectorized first argument. 

toTest <- c(1, 1, 0, 1, 0, 1)
ifelse(toTest == 1, "Yes", "No")

# This returned "Yes" for each element of toTest that equaled 1 and "No" for each element of toTest that did not equal 1. The TRUE and FALSE arguemnts can even refer to the testing element. 

ifelse(toTest == 1, toTest*3, toTest)

# the FALSE argument is repeated as needed
ifelse(toTest == 1, toTest*3, "Zero")

# Now let's say that toTest has NA elements. In that case the corresponding result from ifelse is NA
toTest[2] <- NA
ifelse(toTest == 1, "Yes", "No")
# The same goes for the rest of thec ode. The NA will have the NA element. 
