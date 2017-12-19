# CityListing

Assignment Details:
Create a simple mobile application (crash free), with one page (list view) to list all
the cities of the world & its population.
● Add a simple search bar with autocomplete text to search based on cities
● Taping on a row should take to details screen showing the information
about the city. (Can show only City, Country, Population and Timezone)
● Sort the list by population (ascending / descending)
Data​: You can download the list (static file) from the link:
http://www.geonames.org/export/.


Project details: 
Application flow (architecture)
When the application is launched initially, application reads data from csv file and save the data in core data. To save application launching time, the data is retrieved and saved once only
At Home screen, data is fetched from core data and all the cities are listed on table view.
I keep the static file in CSV format within the application with 588 records
I followed the proper folder structure for view controllers, database, resources files and utilities
For UI, I used storyboards with autolayout
I have implemented the sorting functionality
