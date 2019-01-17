-- for each citation type, is there a specific area in Scottsdale where it is more likely to take place?

-- Filtering Criteria:
	-- exclude all citations for which less than 100 were issued over the course of the year throughout the whole city
	-- exclude citations for which fewer than 20 were issued at any one location
	-- finally, only include a given citation type at a location if the count of citations at that location amounts to more than 5% of total citations of that type from across the city

-- applying the above criteria produces a total of 14 unique citations that regularly take place at 32 locations across the city
 select
		A.[Charge Description]
		,A._count_
		,B._charge_description_total_
		,round(
				convert(float,A._count_)/convert(float,B._charge_description_total_)*100  -- division to find percent of total citations of each type that took place at each location
				,2
			) as _percent_
		,A._street_

	from (select                   -- finds total of citations of each type(Charge Description) that took place at each intersection or block along any given street for the entire year
		 [Charge Description]
		 ,count(concat([Street],[Street Number])) as _count_  -- if a citation occurs along a street, the first digit will be followed by 'xxx'
		 ,concat([Street],[Street Number]) as _street_        -- this joins block number with street to create the most precise location for each citation
		 from [dbo].[spd_PDCitations$]
		 group by [Charge Description],[Street Number],[Street]
	) as A
	left join (select                 -- finds total of citations of each type(Charge Description) that took place for the entire year, regardless of location in city
			  [Charge Description]
			  ,count([Charge Description]) as _charge_description_total_
			  from [dbo].[spd_PDCitations$]
			  group by [Charge Description]
		) as B on A.[Charge Description] = B.[Charge Description]

	where 
		round(
				convert(float,A._count_)/convert(float,B._charge_description_total_)*100  -- exclude citations from any one location that make up less than 5% of total for the year
				,2
			) > 5 and
		B._charge_description_total_ > 100 and  -- exclude all citations for which less than 100 were issued over the course of the year
		A._count_ > 20                          -- exclude citations for which fewer than 20 were issued at any one location
	order by B._charge_description_total_ desc, A._count_ desc



-- 14 unique citations meet the above criteria for a total of 1460 citations
 select
	count(distinct(A.[Charge Description])) as _count_unique_citations_
	,sum(A._count_) as sum_charge_descriptions
 from (
 			 select
					A.[Charge Description]
					,A._count_
					,B._charge_description_total_
					,round(
							convert(float,A._count_)/convert(float,B._charge_description_total_)*100  -- division to find percent of total citations of each type that took place at each location
							,2
						) as _percent_
					,A._street_

				from (select                   -- finds total of citations of each type(Charge Description) that took place at each intersection or block along any given street for the entire year
					 [Charge Description]
					 ,count(concat([Street],[Street Number])) as _count_  -- if a citation occurs along a street, the first digit will be followed by 'xxx'
					 ,concat([Street],[Street Number]) as _street_        -- this joins block number with street to create the most precise location for each citation
					 from [dbo].[spd_PDCitations$]
					 group by [Charge Description],[Street Number],[Street]
				) as A
				left join (select                 -- finds total of citations of each type(Charge Description) that took place for the entire year, regardless of location in city
						  [Charge Description]
						  ,count([Charge Description]) as _charge_description_total_
						  from [dbo].[spd_PDCitations$]
						  group by [Charge Description]
					) as B on A.[Charge Description] = B.[Charge Description]

				where 
					round(
							convert(float,A._count_)/convert(float,B._charge_description_total_)*100  -- exclude citations from any one location that make up less than 5% of total for the year
							,2
						) > 5 and
					B._charge_description_total_ > 100 and  -- exclude all citations for which less than 100 were issued over the course of the year
					A._count_ > 20                          -- exclude citations for which fewer than 20 were issued at any one location
				--order by B._charge_description_total_ desc, A._count_ desc

			) as A