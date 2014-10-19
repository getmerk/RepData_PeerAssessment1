---
title: 'Assignment 1: Reproducible Research'
output: html_document
---


## Loading and preprocessing the data 



1. Load the data 

```{r, echo= TRUE}

data1 <- read.csv("activity.csv", sep = ",")

```

2. Process/transform the data (if necessary) into a format suitable for your analysis

Loading the dplyr function 

```{r, echo= TRUE}
library(dplyr)
```

creating a new data frame tbl and also Sample data is shown by head(data2)

```{r, echo= TRUE}

data2 <- tbl_df(data1) 

head(data2)

```



## What is mean total number of steps taken per day?



1. Make a histogram of the total number of steps taken each day

```{r, echo= TRUE}

totalstepsperday <- data2 %>% 
        group_by(date) %>% 
        summarise_each(funs(sum))

hist(totalstepsperday$steps, xlab = "Total number of steps per day", main = "Total number of steps taken each day", col="red")
dev.print(png, file = "Plot1.png", width = 480, height = 480, units = "px")# printing the final plot with the given specifications 

```

2. Calculate and report the mean and median total number of steps taken per day

 A. mean total number of steps taken per day
 

```{r, echo= TRUE}

meanstepsperday <- data2 %>% 
        group_by(date) %>% # grouped by date
        summarise(mean_steps= mean(steps))

head(meanstepsperday)

```

 B. median total number of steps taken per day


```{r, echo= TRUE}

medianstepsperday <- data2 %>% 
        group_by(date) %>% # grouped by date
        summarise(median_steps=median(steps))

head(medianstepsperday)

```



## What is the average daily activity pattern?


 Make a time series plot (i.e. type = "l") of the 5-minute interval 
 (x-axis) and the average number of steps taken, averaged 
 across all days (y-axis)
 
 Step 1. Computing the average number of steps across all days 
 
```{r, echo= TRUE}

Avgstepsacrossalldays <- data2 %>% 
        group_by(interval) %>% # grouped by date
        summarise(steps= mean(steps, na.rm = TRUE))

```

Step 2. plotting the average number of steps across all days  

```{r, echo= TRUE}

plot(Avgstepsacrossalldays$interval,Avgstepsacrossalldays$steps, 
     type = "l", xlab = "interval", ylab = "Average steps across all days", 
     main = "Time series for average steps of all days")
dev.print(png, file = "Plot2.png", width = 480, height = 480, units = "px")# printing the final plot with the given specifications 

```


1. Which 5-minute interval, on average across all the days in the dataset, 
   contains the maximum number of steps?

This can be done by Searching the maximum number of stepts from "Avgstepsacrossalldays" data 

The answer is the 835th interval!

```{r, echo= TRUE}

Avgstepsacrossalldays[Avgstepsacrossalldays$steps %in% c(max(Avgstepsacrossalldays$steps)),]

```



## Imputing missing values



 1. Calculate and report the total number of missing values 
    in the dataset (i.e. the total number of rows with NAs)

    Total number of missing values can be computed as:  
    
    
```{r, echo= TRUE}
sum(is.na(data2))

```

