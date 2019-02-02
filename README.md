## City-of-Scottsdale-Citations
What can the dataset of citations issued by the City of Scottsdale Police Department tell me?

As resident of Scottsdale Arizona, I'm interested in an understanding of the city I can form by combing through it's data.  I walk, I bicycle, I drive through it regularly, I shop and grocery stores, I visit public libraries.  These daily activities have allowed me to gain an understanding of the city through direct contact.  In contrast to that understanding, what story about the city can be formed by looking at something like the citations(approximately 27K over the last year) issed by the City of Scottsdale Police Department.

In some of my other repositories, I've focused on answering very specific questions.  Such as "Where do most DUIs take place in Scottsdale?".  With this repository I'm following my curiosity and learning from the data in a more exploratory way.


#### Analysis by Day of the Year


##### Things to Consider:
+ which days of the year are associated with the highest/lowest numbers of citations?
+ for outlier days, what could be contributing factors?
+ are more broad temperature/seasonal changes a contributing factor to some citations?


#### Analysis by Location

##### Things to Consider:
+ which locations are associated with the highest numbers of citations of any given type?
+ is the higher number of citations at these locations attributable to something temporary, or permanent?


#### Analysis by Police Officer

##### Things to Consider:
+ what is the relationship between beat # to types of citations?
+ are some officers better at enforcing certain citations?
    + in cases where certain officers have large numbers of citations of one type, this seems to be more of a function that they were assigned to patrol a specific area for specific infractions, rather than the officer simply noticing an infraction while in the course of general patrolling.
+ am I able to identify specific reasons why some officers have a higher number of citations in a specific "charge description"?
+ ~~is the citation issuing behavior of male officers the same as female officers?~~  Unable to determine this since the Citations dataset only includes officer badge number.  The Incidents dataset includes officer __last name__ along with __first initial__ and __badge number__, but this isn't enough for me to easily determine the sex of the officer.
