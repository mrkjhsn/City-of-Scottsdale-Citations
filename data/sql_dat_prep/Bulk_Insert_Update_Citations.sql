   	-- each week the City of Scottsdale releases the prior year's worth of citations
	-- after downloaded, I used python to remove irregularities from the dataset
			-- a number of officer badge #s had 'B' in front of the number
			-- a handful of 'Zips' had letters rather than numbers
	 -- bulk insert statement below to update citations dataset

  	BULK INSERT [dbo].[spd_PDCitations$]
	FROM 'C:\\Users\\mrkjh\\Documents\\GitHub\\City-of-Scottsdale-Citations\\spd_PDCitations - 2-19-2019_CLEAN.csv'
	WITH (FORMAT = 'CSV',
		  FIRSTROW=2,
		  FIELDTERMINATOR = ',', 
		  ROWTERMINATOR = '\n');

  -- CTE (Common Table Expression) to remove duplicates once bulk insert has taken place

  with DupFinder as
  (
  select *, 
  ROW_NUMBER() over (partition by [Citation #] order by [Citation #]) as RowNumber
  from [dbo].[spd_PDCitations$]
  ) 

  delete from DupFinder
  where RowNumber > 1
  
