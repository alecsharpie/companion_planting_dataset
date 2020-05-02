# Companion planting data 

<br>

## JSON format
### Keys:
#### type 
- 4 categories: Vegetables/Fruit/Herbs/Flowers (string)
#### common_name 
- common name of the plant (string)
#### code 
- stripped common name of the plant, acts as primary key for matches (string)
#### scientific_name
- scientific name of the plant (string)
#### helps
- a list of plants helped by primary key plant (strings)
#### helped_by
- a list of plants that help the primary key plant (strings)
#### avoid
- a list of plants that harm the primary key plant (strings)
#### attracts
- a list of animals the primary key plant attracts (strings)
#### repels_distracts
- a list of animals helped by primary key plant (strings)

<br>

### The data was scraped from Wikipedia 
<a href="https://en.wikipedia.org/wiki/List_of_companion_plants">Wikipedia: List of Companion Plants</a>

### The data was manipulated in the following ways:
 - Relationships not matching a primary key plant were removed (for helps/helped_by/attracts columns)
 - Relationships without citations were removed
 - Punctuation was removed 
 - Text was split, rearranged, and removed
 - Non alphabetic characters were removed 
