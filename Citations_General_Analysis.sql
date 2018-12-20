-- group citations by day, what is the distribution across the whole year?
select 
	convert(varchar,[Citation Date],101) as Date
	,count([Citation Date] ) as _count_per_day

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

-- for Feb 3rd, where were most citations taking place?
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

	from (select  -- finds citations for year grouped by block # and street name
		 [Charge Description]
		 ,[Citation Date]
		 ,count(concat([Street],[Street Number])) as _count_
		 ,concat([Street],[Street Number]) as _street_
		 from [dbo].[spd_PDCitations$]
		 group by [Charge Description],[Citation Date],[Street Number],[Street]
	) as A
	left join (select  -- finds total citations for year grouped by citation type
			  [Charge Description]
			  ,count([Charge Description]) as _charge_description_total_
			  from [dbo].[spd_PDCitations$]
			  group by [Charge Description]
		) as B on A.[Charge Description] = B.[Charge Description]

	where [Citation Date] = '2018-02-03 00:00:00.000'  -- selects only for final date of WM Open Tournament
	order by _count_ desc