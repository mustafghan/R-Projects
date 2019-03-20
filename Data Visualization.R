library(tidyverse)
library (ggplot2)

j
## Data Visualization examples

ggplot(data = mpg)+
    geom_point (mapping = aes(x =displ, y = hwy))


ggplot (data = mpg) +
    geom_point (mapping = aes(x = displ, y = hwy, color = class)) +
    facet_wrap (~ class, nrow = 3)

ggplot (data = mpg) +
    geom_point (mapping = aes (x = displ, y = hwy), colour = "pink") +
    facet_wrap (drv ~ class, nrow = 2 )


ggplot (data = mpg) +
    geom_smooth (mapping = aes(x = displ, y = hwy))

ggplot (data = mpg) +
    geom_smooth (mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot (data = mpg) +
    geom_point (mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_smooth (mapping = aes(x = displ, y = hwy, color = drv)) + 
    facet_wrap (~ drv, ncol= 3)



# Data Transformation

library(nycflights13)
library(tidyverse)


# 5.1.3 dplyr basics In this chapter you are going to learn the five key dplyr
# functions that allow you to solve the vast majority of your data manipulation
# challenges:
#
# Pick observations by their values (filter()). Reorder the rows (arrange()).
# Pick variables by their names (select()). Create new variables with functions
# of existing variables (mutate()). Collapse many values down to a single
# summary (summarise()). These can all be used in conjunction with group_by()
# which changes the scope of each function from operating on the entire dataset
# to operating on it group-by-group. These six functions provide the verbs for a
# language of data manipulation.
#
# All verbs work similarly:
#
# The first argument is a data frame.
#
# The subsequent arguments describe what to do with the data frame, using the
# variable names (without quotes).
#
# The result is a new data frame.

# Together these properties make it easy to chain together multiple simple steps
# to achieve a complex result. Let's dive in and see how these verbs work.

# either prints out the results, or saves them to a variable. If you want to do
# both, you can wrap the assignment in parentheses:

(jan1 <- filter(flights, month == 1, day == 1)) 


# The following code finds all flights that departed in November or December:

filter (flights, month == 11 | month == 12)

# A useful short-hand for this problem is x %in% y. This will select every row
# where x is one of the values in y. We could use it to rewrite the code above:

filter(flights, month %in% c(11,12) )

# filter() only includes rows where the condition is TRUE; it excludes both
# FALSE and NA values. If you want to preserve missing values, ask for them
# explicitly:

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
#Here we will do it and explicitly tell the program to include NA:
filter(df, is.na(x) | x > 1)
#
#
# 5.3 Arrange rows with arrange() arrange() works similarly to filter() except
# that instead of selecting rows, it changes their order. It takes a data frame
# and a set of column names (or more complicated expressions) to order by. If
# you provide more than one column name, each additional column will be used to
# break ties in the values of preceding columns:
arrange(flights, year, month, day)

# Use desc() to re-order by a column in descending order:

arrange(flights, desc(dep_delay)
        
        # 5.4 Select columns with select() It's not uncommon to get datasets with
        # hundreds or even thousands of variables. In this case, the first challenge is
        # often narrowing in on the variables you're actually interested in. select()
        # allows you to rapidly zoom in on a useful subset using operations based on the
        # names of the variables.
        #
        # select() is not terribly useful with the flights data because we only have 19
        # variables, but you can still get the general idea:
        #
        # # Select columns by name 
        
        select(flights, year, month, day)
        
        # Select all columns between year and day (inclusive)
        select(flights, year:day)
        
        # Select all columns except those from year to day (inclusive)
        select(flights, -(year:day))
        
        # There are a number of helper functions you can use within select():
        
        starts_with("abc"): #matches names that begin with "abc".
            
            ends_with("xyz"): #matches names that end with "xyz".
            
            contains("ijk"): #matches names that contain "ijk".
            
            matches("(.)\\1"): #selects variables that match a regular expression. 
            
            # This onematches any variables that contain repeated characters. 
            # You'll learn more about regular expressions in strings.
            
            num_range("x", 1:3): matches x1, x2 and x3
        
        # Another option is to use select() in conjunction with the everything() helper.
        # This is useful if you have a handful of variables you'd like to move to the
        # start of the data frame.
        
        select(flights, time_hour, air_time, everything())
        
        # 5.5 Add new variables with mutate() Besides selecting sets of existing
        # columns, it's often useful to add new columns that are functions of existing
        # columns. That's the job of mutate().
        #
        # mutate() always adds new columns at the end of your dataset so we'll start by
        # creating a narrower dataset so we can see the new variables. Remember that
        # when you're in RStudio, the easiest way to see all the columns is View().
        
        flights_sml <- select(flights, 
                              year:day, 
                              ends_with("delay"), 
                              distance, 
                              air_time
        )
        flights_sml <- mutate(flights_sml,
                              gain = dep_delay - arr_delay,
                              speed = distance / air_time * 60)
        
        # Note that you can refer to columns that you've just created:
        
        mutate(flights_sml,
               gain = dep_delay - arr_delay,
               hours = air_time / 60,
               gain_per_hour = gain / hours
        )
        
        # If you only want to keep the new variables, use transmute():
        
        transmute(flights,
                  gain = dep_delay - arr_delay,
                  hours = air_time / 60,
                  gain_per_hour = gain / hours
        )
        
        # Cumulative and rolling aggregates: R provides functions for running sums,
        # products, mins and maxes: cumsum(), cumprod(), cummin(), cummax(); and
        # dplyr provides cummean() for cumulative means. If you need rolling
        # aggregates (i.e. a sum computed over a rolling window), try the RcppRoll
        # package.
        
        # 5.6 Grouped summaries with summarise()
        # The last key verb is summarise(). It collapses a data frame to a single row:
        
        summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
        
        # 7 Exploratory Data Analysis
        
        
        