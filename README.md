# Companion planting data 

</br>
## JSON format
### Variables (columns):
#### type 
- 4 categories: Vegetables/Fruit/Herbs/Flowers
#### common_name 
- common name of the plant
#### code 
- stripped common name of the plant, acts as primary key for matches
#### scientific_name
- scientific name of the plant
#### helps (list)
- a list of plants helped by primary key plant
#### helped_by (list)
- a list of plants that help the primary key plant
#### avoid (list)
- a list of plants that harm the primary key plant
#### attracts (list)
- a list of animals the primary key plant attracts
#### repels_distracts (list)
- a list of animals helped by primary key plant

</br>

## The data was scraped from Wikipedia 
### <a href="https://en.wikipedia.org/wiki/List_of_companion_plants">Wikipedia: List of Companion Plants</a>

## The data was manipulated in the following ways:
### - Relationships not matching a primary key plant were removed (for helps/helped_by/attracts columns)
### - Relationships without citations were removed
### - Punctuation was removed 
### - Text was split, rearranged, and removed
### - Non alphabetic characters were removed 
