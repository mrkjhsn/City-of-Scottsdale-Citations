The first Citations download I did from the City of Scottsdale data portal in Sept. 2018 had the officer badge numbers strictly designated with digits.

When I downloaded updated data in Februray 2019, some of those badge numbers had a "B" in front of the digit.  This prevented me from importing this field into SQL as an number.

I wrote a python script to remove the "Bs" from the officer badge column before I performed the bulk insert into SQL.