## City-of-Scottsdale-Citations
What can the [dataset](http://data.scottsdaleaz.gov/dataset/police-citations) of citations issued by the City of Scottsdale Police Department tell me?

As resident of Scottsdale Arizona, I'm interested in an understanding of the city I can form by combing through it's data.  I walk, I bicycle, I drive through it regularly, I shop and grocery stores, I visit public libraries.  These daily activities have allowed me to gain an understanding of the city through direct contact.  In contrast to that understanding, what story about the city can be formed by looking at something like the citations(approximately 27K over the last year) issed by the City of Scottsdale Police Department.
___

#### When multiple citations are issued, what are the most frequent combinations?
![](https://github.com/mrkjhsn/City-of-Scottsdale-Citations/blob/master/visualizations/Multiple%20Citation%20Combinations.png)
___
#### Analysis by Day of the Year


##### Things to Consider:
+ which days of the year are associated with the highest/lowest numbers of citations? what could be contributing factors?
	+ February 3rd, 2018 was associated with 140 citations, the highest per day citation count of the year.  This is attributable to the combination of the final day of the Waste management Open Golf Tournament taking place this day, as well as it being Superbowl Sunday.  Examining the nature and location of these citations, most of these included underage drinking in north Scottsdale and Old Town Scottsdale.  The next highest day of the year(10/19/2017) had only 126, with many other dates clustered closely behind that number.
	+ December 25, 2017(Christmas Day) had the smallest number of citations with only 4.

+ are temperature/seasonal changes a contributing factor to some citations?


#### Analysis by Location

##### Things to Consider:
+ which locations are associated with the highest numbers of citations of any given type?
    + exclude all citations for which less than 100 were issued over the course of the year throughout the whole city
	+ exclude citations for which fewer than 20 were issued at any one location
	+ finally, only include a given citation type at a location if the count of citations at that location amounts to more than 5% of total citations of that type from across the city
        +  N 82nd St / E Camelback Rd is associated with 74 failures to stop at stop signs, 8.4% of all that took place in Scottsdale.  This could be because Camelback doesn't go through to the 101 to the east, as do many only east/west roads through Scottsdale.  Drivers(especially visitors) heading east aren't expecting the stop sign.
        + N 64th St / E Cholla St is associated with 109 of 427 total citations of type 'Exceed 15mph In School Crossing'.  The next highest location with this citation was 7xxx N Miller Rd with 71 of the 427.
        + 7xxx E Camelback Rd (Scottsdale Fashion Square) is associated with 85 of 285 citations of 'Shoplifting-Removal of Goods'
+ is the higher number of citations at these locations attributable to something temporary, or permanent?


#### Analysis by Police Officer

##### Things to Consider:
+ are some officers better at enforcing certain citations?
    + One officer(badge #1335) produced almost 900 citations over a 1 year period of time.  The next highest officer had only around 600 citations during this same time period.  It's unclear to me why this one officer produced so many more citations than the other officers.
    + in cases where certain officers have large numbers of citations of one type, this seems to be more of a function that they were assigned to patrol a specific area for specific infractions, rather than the officer simply noticing an infraction while in the course of general patrolling.
+ am I able to identify specific reasons why some officers have a higher number of citations in a specific "charge description"?
    - most of the citations that make up a significant percent of any given officers total citations are speeding tickets(Speed Greater Than R&P or Posted).  However a handful of officers(badge# 1402 - 68%, badge# 1273 - 60%, badge# 1337 - 56%) have a disproportionate amount of their total citations within the 'DUI-Impaired to Slightest Degree' category.  It's possible these officers are more regularly assigned to task force duties patrolling specific areas and times when they are more likely to enforce DUI citations.
+ ~~is the citation issuing behavior of male officers the same as female officers?~~  Unable to determine this since the Citations dataset only includes officer badge number.  The Incidents dataset includes officer __last name__ along with __first initial__ and __badge number__.  It's possible I could extract the name and do a join.  But these three pieces of data aren't enough for me to easily determine the sex of the officer.
