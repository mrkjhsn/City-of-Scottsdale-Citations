	-- how frequently does someone receive multiple citations at the time time?
	-- for instance, someone is issued a speeding ticket, but they also have a taillight out
	-- which combination of citations are often grouped together?
	
	-- 415 people received more than one citation at a given incident
	-- grouping by name and age to remove chance that people with common names will be grouped together

	select [Cited Person]
		,[Cited Person Age]
		,[Citation Date]
		,count([Charge Description]) as _Count_
	from [dbo].[spd_PDCitations$]
	group by [Cited Person], [Cited Person Age], [Citation Date]
	having count([Charge Description]) > 1
	order by count([Charge Description]) desc

	-- provide full detail of citations from above query

	select A.[Cited Person]
	,A.[Citation Type Description]
	,convert(varchar, A.[Citation Date], 101) as Citation_Date
	,A.[Charge Description]
	,concat(A.[Cited Person],A.[Cited Person Age]) as unique_identifier
	,B.count_of_citations
from [dbo].[spd_PDCitations$] as A
inner join (select [Cited Person]
			,[Cited Person Age]
			,[Citation Date]
			,concat([Cited Person],[Cited Person Age]) as unique_identifier
			,count(*) as count_of_citations
		   from [dbo].[spd_PDCitations$]
		   group by [Cited Person]
			,[Cited Person Age]
			,[Citation Date]
		   having count(*) >= '2'
		   ) as B on concat(A.[Cited Person],A.[Cited Person Age]) = B.unique_identifier
order by B.count_of_citations desc, A.[Cited Person], A.[Charge Description]

------
select *
from [dbo].[spd_PDCitations$] as A
inner join (select [Cited Person] as name2
			,[Cited Person Age] as age2
			,[Citation Date] as date2
			,concat([Cited Person],[Cited Person Age]) as unique_identifier
			,count(*) as count_of_citations
		   from [dbo].[spd_PDCitations$]
		   group by [Cited Person]
			,[Cited Person Age]
			,[Citation Date]
		   having count(*) >= '2'
		   ) as B on concat(A.[Cited Person],A.[Cited Person Age]) = B.unique_identifier


-- how many different types of speed related citations are there?
select [Charge Description]
	,count([Charge Description])
from [dbo].[spd_PDCitations$]
group by [Charge Description]
having [Charge Description] like '%exceed%' or 
	[Charge Description] like '%Speed Greater Than R&P or Posted%' or
	[Charge Description] like '%Racing/Exhibition of Speed%'

--- show all information for all citations identified in query above
select *
from [dbo].[spd_PDCitations$]
where [Charge Description] like '%exceed%' or 
	[Charge Description] like '%Speed Greater Than R&P or Posted%' or
	[Charge Description] like '%Racing/Exhibition of Speed%'
----

select [Charge Description]
	,count([Charge Description])
from [dbo].[spd_PDCitations$]
group by [Charge Description]
order by count([Charge Description]) desc
