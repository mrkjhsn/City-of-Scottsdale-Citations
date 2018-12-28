-- are some officers more likely to spot certain behavior?
-- 286 unique Scottsdale Police Department officers
-- NULL officer enforced 442 citations, are these automated traffic citations?
-- I could do a join to pull in names of badges, analyze male/female makeup of police force.  Is one gender more likely to enforce certain citations
-- are some officers more likely to patrol in specific areas of town?


-- finds count of citations for each Officer
-- officer 1335 has a huge margin more than any other officer, why is this?
select 
	[Officer Badge #] 
	,count([Charge Description]) as _count_
from [dbo].[spd_PDCitations$]
group by [Officer Badge #]
order by count([Charge Description]) desc





-- Christmas day has by far the fewest citations, only 4 officers gave citations that day
select 
	[Officer Badge #]
	,[Charge Description]
from [dbo].[spd_PDCitations$]
where [Citation Date] = '2017-12-25 00:00:00.000' 

-- find citations by officer for specific periods of the year
select 
	[Officer Badge #]
	,case when month([Citation Date]) between 1 and 3 
		then count([Charge Description]) 
		end as _count_

from [dbo].[spd_PDCitations$]
--where month([Citation Date]) between 1 and 3
group by [Officer Badge #],month([Citation Date])
order by count([Charge Description]) desc