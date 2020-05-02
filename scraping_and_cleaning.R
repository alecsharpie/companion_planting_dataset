library(rvest)
library(dplyr)
library(stringr)
library(jsonlite)

library(tidyverse)

#put a data set of compatible plants on github

#### SCRAPING ####

# read the web address from wikipedia
plant_list_html <-
  read_html("https://en.wikipedia.org/wiki/List_of_companion_plants")

# see all tables on the page, fill = TRUE fills differing coloumns
plant_list_html %>%
  html_nodes("table") %>%
  html_table(fill = TRUE)


#prepare a list for for loop to fill with different tables
list_of_df <- list()

#prepare a list for for loop to fill with table names
vector_of_types <- vector(mode = "character", length = length(2:5))

# run a for loop to scrape multiple tables off one page
# 2 = veges, 3 = fruit, 4 = herbs, 5 = flowers
# store table name in vector_of_types
# rename the columns
# remove duplicate rows
# store table in list_of_df
for (a in 2:5) {
  plants <- plant_list_html %>%
    html_nodes("table") %>%
    .[[a]] %>%
    html_table(fill = TRUE)
  
  vector_of_types[a - 1] <- colnames(plants)[1]
  
  colnames(plants) <- plants[1,]
  
  plants <- plants %>%
    filter(!Helps == "Helps")
  
  list_of_df[[a - 1]] <- plants
  
}

#name each table by its corresponding type
names(list_of_df) <- vector_of_types

#join tables together, creating the "type" coloumn from our table names
all_plants <- bind_rows(list_of_df, .id = "Type")


#### CLEANING ####


colnames(all_plants) <- c("type", "common_name", "scientific_name", "helps", "helped_by", "attracts", "repels_distracts", "avoid", "comments")

# regex. strip back plant names to lower case alphabet characters
all_plants_index <- all_plants %>%
  mutate(code = tolower(common_name)) %>%
  mutate(code = gsub("/.*|and\\s.*|or\\s.*|,.*| |'", "", code))

# change the above list into a vector
plant_names_vec <- as.vector(unique(all_plants_index$code))

## HELP COLUMN

# change to lowercase
# split the strings of plant names into individual plant names
split_test <- all_plants_index %>%
  mutate(helps = tolower(helps)) %>%
  mutate(helps = strsplit(helps, regex("[]())]|, ")))

# FIND OUT HOW TO DO THE FOLLOWING IN DPLYR

# loop through the column of interest and remove entries missing name or citation
# regex. only keep elements containing any letter and then any number any distance apart
for (b in 1:nrow(split_test)) {
  
  split_test$helps[[b]] <-
    split_test$helps[[b]][str_which(pattern = "[a-z].*[0-9]", string = unlist(split_test$helps[b]))]
  
}

# loop through the column of interest and simplify elements in each list
# regex. strip back names to alphabet characters
for (c in 1:nrow(split_test)) {

split_test$helps[[c]] <-
  gsub("\\]|\\[|,|'| | and | or |[0-9]|/.*|especially|most|bush|capsicum", "", unlist(split_test$helps[c]))

}


# loop through the column of interest and remove entries in each list not matching a primary ket plant
for (d in 1:nrow(split_test)) {
  split_test$helps[[d]] <-
    split_test$helps[[d]][unlist(split_test$helps[d]) %in% plant_names_vec]
  
}

## HELPED BY COLUMN

# change to lowercase
# split the strings of plant names into individual plant names
split_test <- split_test %>%
  mutate(helped_by = tolower(helped_by)) %>%
  mutate(helped_by = strsplit(helped_by, regex("[]())]|, ")))

# FIND OUT HOW TO DO THE FOLLOWING IN DPLYR

# loop through the column of interest and remove entries missing name or citation
# regex. only keep elements containing any letter and then any number any distance apart
for (b in 1:nrow(split_test)) {
  
  split_test$helped_by[[b]] <-
    split_test$helped_by[[b]][str_which(pattern = "[a-z].*[0-9]", string = unlist(split_test$helped_by[b]))]
  
}

# loop through the column of interest and simplify elements in each list
# regex. strip back names to alphabet characters
for (c in 1:nrow(split_test)) {
  
  split_test$helped_by[[c]] <-
    gsub("\\]|\\[|,|'| | and | or |[0-9]|/.*|especially|most|bush|capsicum", "", unlist(split_test$helped_by[c]))
  
}


# loop through the column of interest and remove entries in each list not matching a primary ket plant
for (d in 1:nrow(split_test)) {
  split_test$helped_by[[d]] <-
    split_test$helped_by[[d]][unlist(split_test$helped_by[d]) %in% plant_names_vec]
  
}


# how to leave space in the plant names while removing them at beginning and end? ^ $


## ATTRACTS COLUMN

# change to lowercase
# split the strings of plant names into individual plant names
split_test <- split_test %>%
  mutate(attracts = tolower(attracts)) %>%
  mutate(attracts = strsplit(attracts, regex("[]())]|, ")))

# FIND OUT HOW TO DO THE FOLLOWING IN DPLYR

# loop through the column of interest and remove entries missing name or citation
# regex. only keep elements containing any letter and then any number any distance apart
for (b in 1:nrow(split_test)) {
  
  split_test$attracts[[b]] <-
    split_test$attracts[[b]][str_which(pattern = "[a-z].*[0-9]", string = unlist(split_test$attracts[b]))]
  
}

# loop through the column of interest and simplify elements in each list
# regex. strip back names to alphabet characters
for (c in 1:nrow(split_test)) {
  
  split_test$attracts[[c]] <-
    gsub("\\]|\\[|,|'|\\.| or |[0-9]|/.*|especially|most|bush|capsicum", "", unlist(split_test$attracts[c]))
  
}

split_test <- split_test%>%
  mutate(attracts = gsub("hoverflies|syrphidae", "syrphid fly", attracts))

# for "attracts" column 
# removed and & space from the above regex
# added fullstop to the above regex



## REPELS_DISTRACTS COLUMN

# change to lowercase
# split the strings of plant names into individual plant names
split_test <- split_test %>%
  mutate(repels_distracts = tolower(repels_distracts)) %>%
  mutate(repels_distracts = strsplit(repels_distracts, regex("[]())]|, ")))

# FIND OUT HOW TO DO THE FOLLOWING IN DPLYR

# loop through the column of interest and remove entries missing name or citation
# regex. only keep elements containing any letter and then any number any distance apart
for (b in 1:nrow(split_test)) {
  
  split_test$repels_distracts[[b]] <-
    split_test$repels_distracts[[b]][str_which(pattern = "[a-z].*[0-9]", string = unlist(split_test$repels_distracts[b]))]
  
}

# loop through the column of interest and simplify elements in each list
# regex. strip back names to alphabet characters
for (c in 1:nrow(split_test)) {
  
  split_test$repels_distracts[[c]] <-
    gsub("\\]|\\[|,|'|\\.| or |[0-9]|/.*|-", "", unlist(split_test$repels_distracts[c]))
  
}

## AVOID COLUMN

# change to lowercase
# split the strings of plant names into individual plant names
split_test <- split_test %>%
  mutate(avoid = tolower(avoid)) %>%
  mutate(avoid = strsplit(avoid, regex("[]())]|, ")))

# FIND OUT HOW TO DO THE FOLLOWING IN DPLYR

# loop through the column of interest and remove entries missing name or citation
# regex. only keep elements containing any letter and then any number any distance apart
for (b in 1:nrow(split_test)) {
  
  split_test$avoid[[b]] <-
    split_test$avoid[[b]][str_which(pattern = "[a-z].*[0-9]", string = unlist(split_test$avoid[b]))]
  
}

# loop through the column of interest and simplify elements in each list
# regex. strip back names to alphabet characters
for (c in 1:nrow(split_test)) {
  
  split_test$avoid[[c]] <-
    gsub("\\]|\\[|,|'| | and | or |[0-9]|/.*|especially|most|bush|capsicum", "", unlist(split_test$avoid[c]))
  
}


# loop through the column of interest and remove entries in each list not matching a primary ket plant
for (d in 1:nrow(split_test)) {
  split_test$avoid[[d]] <-
    split_test$avoid[[d]][unlist(split_test$avoid[d]) %in% plant_names_vec]
  
}

companion_plants <- split_test[,c("type", "common_name", "code", "scientific_name", "helps", "helped_by", "attracts", "repels_distracts", "avoid")]


# save Data as JSON

companion_plants_json <- toJSON(companion_plants, pretty = TRUE)

write(companion_plants_json, "companion_plants.json")


# save to csv

#does not work, need to replace character(0) with NA
split_test <- split_test %>%
  mutate(helps = na_if(helps, as.vector(rep_len(character(0), nrow(split_test)))))







