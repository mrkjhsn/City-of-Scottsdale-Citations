-- are some officers more likely to spot certain behavior?
-- 286 unique Scottsdale Police Department officers
-- NULL officer enforced 442 citations, are these automated traffic citations?

-- officer badge numbers run from 419 to 1510
-- are these numbers issued sequentially? if so what can I understand about officer behavior between the oldest officers and the youngest officers?
select distinct([Officer Badge #]) 
from [dbo].[spd_PDCitations$] 
order by [Officer Badge #]

-- finds count of citations for each Officer
-- officer 1335 has 894 citations to his name, a huge margin more than any other officer, why is this?
-- the next highest officer is 826 with 594 citations
select 
	[Officer Badge #] 
	,count([Charge Description]) as _count_
from [dbo].[spd_PDCitations$]
group by [Officer Badge #]
order by count([Charge Description]) desc

-- do some officers have a high distribution of citations within certain charge descriptions?
-- for each officer, group citations and count, for the grouping with the highest count, what percent is that of the officers total citations?
-- limit this to officers with at least 100 citations, reasoning that officers with fewer citations may not have been on the force for long or may not patrol regularly
-- 23 officers had over 50% of their total citations from one specific charge description
select A.[Officer Badge #]
	   ,max(A.count_per_citation) as max_per_officer
	   ,[Charge Description]
	   ,B.count_of_total_citations
	   ,round(
			convert(float, A.count_per_citation)/convert(float, B.count_of_total_citations)*100
			,2
			) as _percent_

from (select [Officer Badge #] --subselect finds top citation type/officer     - top 1?  - distinct()
		,[Charge Description]
		,concat([Officer Badge #],[Charge Description]) _badge_charge_max
		,count(*) as count_per_citation
	from [dbo].[spd_PDCitations$]
	group by [Officer Badge #], [Charge Description]
	) as A

	left join (select [Officer Badge #]  -- subselect finds total citations/officer
				,count(*) as count_of_total_citations
				from [dbo].[spd_PDCitations$]
				group by [Officer Badge #]
			   ) as B on B.[Officer Badge #] = A.[Officer Badge #]
group by A.[Officer Badge #], [Charge Description], B.count_of_total_citations, A.count_per_citation
having B.count_of_total_citations > 100
order by round(
			convert(float, A.count_per_citation)/convert(float, B.count_of_total_citations)*100
			,2
			) desc


-- group by citations, count number of unique police officers who issued those citations, find ratio of citation counts to distinct police officers who issued those citations
-- most of the charge descriptions that show up at the top of this query are those that with the highest number of occurences
-- however there are a handful of outliers, it seems some officers have a tendency to enforce certain citations more than others:
	-- 5	Waste of Finite Resource <=65mph	111	-- 111 of these were issued by only 5 officers
	-- 8	Loading or Unloading In Through Lane	127	-- 127 of these were issued by only 8 officers

select 
	count(distinct([Officer Badge #])) as distinct_officers
	,[Charge Description]
	,count([Charge Description]) as count_of_citations
	,count([Charge Description])/count(distinct([Officer Badge #])) as Charge_to_Unique_Officer_Ratio
from [dbo].[spd_PDCitations$]
group by [Charge Description]
having count(distinct([Officer Badge #])) > 1  --this was needed since several citations have no officer associated with them, resulting in the probelem of dividing by zero
order by count([Charge Description])/count(distinct([Officer Badge #])) desc

-- focus on 'Waste of Finite Resource <=65mph', which appears to be issued if the person driving in a 55 zone is going only 10 above speed limit
-- most of these are issued by officers with badge numbers greater than 1100
-- is it possible that younger officers are more willing to give citations for people only 10 miles over the speed limit?
-- or is it simply that younger officers spend more time patroling, older officers spend more time doing administrative tasks?

select 
	[Citation Date]
	,[Charge Description]
	,[Arizona Statute Code]
	,[Citation Time]
	,[Officer Badge #]
	,[City]
	,[Street]
from [dbo].[spd_PDCitations$]
where [Charge Description] = 'Waste of Finite Resource <=65mph'
order by [Officer Badge #] 

-- focus on "Loading or Unloading In Through Lane"
-- most of these have been issued in just a handful of locations, many on the same day
-- this makes me think officers are specifically patrolling to enforce this citation 
select 
	[Citation Date]
	,[Charge Description]
	,[Arizona Statute Code]
	,[Citation Time]
	,[Officer Badge #]
	,[City]
	,[Street]
from [dbo].[spd_PDCitations$]
where [Charge Description] = 'Loading or Unloading In Through Lane'
order by [Officer Badge #] 

-- for any given officer with greater than 100 citations, is there a relationship between the total citations they have issued and the number of unique citations they have issued?
-- there doesn't seem to be much of a relationship here.  A handful of officers issue much more citations than the others, but don't have a greater number of unique citations.
select 
	([Officer Badge #]) as officer
	,count(distinct([Charge Description])) as unique_citation
	,count([Charge Description]) as count_total_citations
	,count([Charge Description])/count(distinct([Charge Description])) as ct_citations_by_dist_citations
from [dbo].[spd_PDCitations$]
group by [Officer Badge #]
having count([Charge Description]) > 100
order by count([Charge Description])/count(distinct([Charge Description])) desc


----------- make temp table with count of citations grouped by officer 
 select [Officer Badge #] 
		 ,[Charge Description]
		 ,count(*) as count_per_citation
into #Count_by_Officer
from [dbo].[spd_PDCitations$]
group by [Officer Badge #], [Charge Description]


-- do some officers have a disproportionate number of their total citations within any given citation type?
-- limited to officers with at least 100 total citations
-- took me a while to realize this was a groupwisemax problem

select A.*
	,C.count_of_total_citations
	,round(
			convert(float, A.count_per_citation)/convert(float, C.count_of_total_citations)*100
			,2
			) as _percent_
from #Count_by_Officer as A
	left outer join #Count_by_Officer as B on B.[Officer Badge #] = A.[Officer Badge #] 
	and B.count_per_citation > A.count_per_citation
	inner join (select [Officer Badge #]  -- is this the most efficient way for me to be doing this?  Inner joins are slower
				,count(*) as count_of_total_citations
				from [dbo].[spd_PDCitations$]
				group by [Officer Badge #]
				) as C on C.[Officer Badge #] = A.[Officer Badge #]

where B.count_per_citation is null and
	C.count_of_total_citations > 100
order by round(
			convert(float, A.count_per_citation)/convert(float, C.count_of_total_citations)*100
			,2
			) desc

		 



