-- group citations by day in order to find the distribution across the whole year
select 
	convert(varchar,[Citation Date],101) as Date -- formats date to a more readable format
	,count([Citation Date] ) as _count_per_day  --finds the total per day
from [dbo].[spd_PDCitations$]
group by [Citation Date] 
order by count([Citation Date])

-- top 10 days of the year with the most citations
select top 10
	convert(varchar,[Citation Date],101) 
	,count([Citation Date] ) as _count_
from [dbo].[spd_PDCitations$]
group by [Citation Date] 
order by count([Citation Date]) desc

-- Feb 3rd, 2018 is at the top of the top 10 list with 140 citations, what were the most common citations?
   select top 10
		A.[Charge Description]
		,A.[Citation Date]
		,A._count_
		,B._charge_description_total_
		,round(
				convert(float,A._count_)/convert(float,B._charge_description_total_)*100
				,2
			) as _percent_
		,A._street_

	from (select                              -- finds citations for year grouped by block # and street name
		 [Charge Description]
		 ,[Citation Date]
		 ,count(concat([Street],[Street Number])) as _count_
		 ,concat([Street],[Street Number]) as _street_
		 from [dbo].[spd_PDCitations$]
		 group by [Charge Description],[Citation Date],[Street Number],[Street]
	) as A
	left join (select                         -- finds total citations for year grouped by citation type
			  [Charge Description]
			  ,count([Charge Description]) as _charge_description_total_
			  from [dbo].[spd_PDCitations$]
			  group by [Charge Description]
		) as B on A.[Charge Description] = B.[Charge Description]

	where [Citation Date] = '2018-02-03 00:00:00.000'  -- selects only for final date of WM Open Tournament
	order by _count_ desc

-- for Feb 3rd, 2018 shows citations grouped by location
   select
		A._location_
		,A.[Citation Date]
		,A._count_
		,B._charge_description_total_
		,round(
				convert(float,A._count_)/convert(float,B._charge_description_total_)*100
				,2
			) as _percent_
		
	from (select                              -- finds locations grouped by block # and street name with count of citations that took place there on any given day
		 concat([Street Number],' ',[Street]) as _location_
		,[Citation Date]
		 ,count([Charge Description]) as _count_
		 from [dbo].[spd_PDCitations$]
		 group by concat([Street Number],' ',[Street]),[Citation Date]
		 
	) as A
	left join (select                         -- finds count of citations at each location grouped by the entire year
			  concat([Street Number],' ',[Street]) as _location_
			  ,count([Charge Description]) as _charge_description_total_
			  from [dbo].[spd_PDCitations$]
			  group by concat([Street Number],' ',[Street])
		) as B on A._location_ = B._location_

	where [Citation Date] = '2018-02-03 00:00:00.000'  -- selects only for final date of WM Open Tournament
	order by _count_ desc



-- October 19, 2017 had the next highest citations with 126, where were those taking place?
-- there seems to be no pattern in locations for this date

  select
		 A.[Charge Description]
		,A.[Citation Date]
		,A._count_
		,B._charge_description_total_
		,round(
				convert(float,A._count_)/convert(float,B._charge_description_total_)*100
				,2
			) as _percent_
		,A._street_

	from (select                              -- finds citations for year grouped by block # and street name
		 [Charge Description]
		 ,[Citation Date]
		 ,count(concat([Street],[Street Number])) as _count_
		 ,concat([Street],[Street Number]) as _street_
		 from [dbo].[spd_PDCitations$]
		 group by [Charge Description],[Citation Date],[Street Number],[Street]
	) as A
	left join (select                         -- finds total citations for year grouped by citation type
			  [Charge Description]
			  ,count([Charge Description]) as _charge_description_total_
			  from [dbo].[spd_PDCitations$]
			  group by [Charge Description]
		) as B on A.[Charge Description] = B.[Charge Description]

	where [Citation Date] = '2017-10-19 00:00:00.000'  -- selects only for final date of WM Open Tournament
	order by _count_ desc

-- November 24, 2017 had the next highest citations with 123, where were those taking place?
-- other than a number of speeding tickets around Old Town Scottsdale there seems to be no pattern in locations for this date
	select
		 A.[Charge Description]
		,A.[Citation Date]
		,A._count_
		,B._charge_description_total_
		,round(
				convert(float,A._count_)/convert(float,B._charge_description_total_)*100
				,2
			) as _percent_
		,A._street_

	from (select                              -- finds citations for year grouped by block # and street name
		 [Charge Description]
		 ,[Citation Date]
		 ,count(concat([Street],[Street Number])) as _count_
		 ,concat([Street],[Street Number]) as _street_
		 from [dbo].[spd_PDCitations$]
		 group by [Charge Description],[Citation Date],[Street Number],[Street]
	) as A
	left join (select                         -- finds total citations for year grouped by citation type
			  [Charge Description]
			  ,count([Charge Description]) as _charge_description_total_
			  from [dbo].[spd_PDCitations$]
			  group by [Charge Description]
		) as B on A.[Charge Description] = B.[Charge Description]

	where [Citation Date] = '2017-11-24 00:00:00.000'
	order by _count_ desc
	----------
	-- 415 people received more than one citation at a given incident
	select [Cited Person]
		,[Cited Person Age]
		,[Citation Date]
		,count([Charge Description]) as _Count_
	from [dbo].[spd_PDCitations$]
	group by [Cited Person], [Cited Person Age], [Citation Date]
	having count([Charge Description]) > 1
	order by count([Charge Description]) desc