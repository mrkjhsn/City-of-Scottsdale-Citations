-- are some officers more likely to spot certain behavior?
-- 286 unique Scottsdale Police Department officers
-- NULL officer enforced 442 citations, are these automated traffic citations?
-- I could do a join to pull in names of badges, analyze male/female makeup of police force.  Is one gender more likely to enforce certain citations
-- are some officers more likely to patrol in specific areas of town?  This is probably related to the beat they are assigned to.


-- finds count of citations for each Officer
-- officer 1335 has a huge margin more than any other officer, why is this?
select 
	[Officer Badge #] 
	,count([Charge Description]) as _count_
from [dbo].[spd_PDCitations$]
group by [Officer Badge #]
order by count([Charge Description]) desc



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




-- a 'beat' number is associated with each citation, how are the beat numbers distributed through the citations?
-- beats ordered by the number of citations in each beat
 select [Beat]
	,count(*)
 from [dbo].[spd_PDCitations$]
 group by [Beat]
 order by count(*) desc

 -- how many beat numbers are there?
 -- beats run 1-20, and 99, as well as citations associated with no beat
 select [Beat]
 from [dbo].[spd_PDCitations$]
 group by [Beat]
 order by [Beat] desc