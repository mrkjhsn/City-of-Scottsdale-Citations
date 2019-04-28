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