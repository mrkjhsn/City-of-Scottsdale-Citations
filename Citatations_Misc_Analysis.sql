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