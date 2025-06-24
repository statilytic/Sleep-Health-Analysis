use new;

select * from sleep_health;

-- check if rows in columns are consistent
select distinct Occupation from sleep_health;
select distinct Gender from sleep_health;
select distinct `BMI Category` from sleep_health;
select distinct `Sleep Disorder` from sleep_health;

-- we see that `BMI Category` has 'Normal' and 'Normal Weight', change to Normal

set sql_safe_updates = 0;

start transaction;

update sleep_health
set `BMI Category` =  "Normal"
where `BMI Category` =  "Normal Weight";

commit;


select * from sleep_health;

-- stress level of each occupation and whether stress affects quality of sleep
-- low stress, high sleep quality
select Occupation, round(avg(`Stress Level`),2) as avg_stress_level, 
		round(avg(`Quality of Sleep`),2) as avg_quality_sleep,
        COUNT(*) AS total_people,
  SUM(CASE WHEN `Sleep Disorder` = "Insomnia" or `Sleep Disorder` = "Sleep Apnea"  THEN 1 ELSE 0 END) AS disorder_cases,
  ROUND(SUM(CASE WHEN `Sleep Disorder` = "Insomnia" or `Sleep Disorder` = "Sleep Apnea"  THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS disorder_rate_pct
from sleep_health
group by Occupation
order by avg_stress_level, avg_quality_sleep, disorder_rate_pct ;


-- bmi category and sleep disorder
select `BMI Category`,
		sum(case when `Sleep Disorder` = "None" then 1 else 0 end) as None,
        sum(case when `Sleep Disorder` = "Sleep Apnea" then 1 else 0 end) as `Sleep Apnea`,
        sum(case when `Sleep Disorder` = "Insomnia" then 1 else 0 end) as `Insomnia`
from sleep_health
group by `BMI Category`;

-- fitness and sleep disorder
-- activity levels based on conditions
with cte as (select `Physical Activity Level`, `Daily Steps`, `Sleep Disorder`,
					case
						when `Physical Activity Level`<= 40 and `Daily Steps` < 5000 then "Low"
						when `Physical Activity Level` > 40 and `Physical Activity Level` <= 60 
						 and `Daily Steps` >= 5000 and `Daily Steps` < 8000 then "Moderate"
						else "High" end as "Fitness Level"
					
			 from sleep_health)
             
 select `Sleep Disorder`,
		sum(case when `Fitness Level` = "Low" then 1 else 0 end) as "Low Fitness Level",
        sum(case when `Fitness Level` = "Moderate" then 1 else 0 end) as "Moderate Fitness Level",
        sum(case when `Fitness Level` = "High" then 1 else 0 end) as "High Fitness Level"
 from cte
 group by `Sleep Disorder`;
 
 -- sleep duration vs sleep quality
 with cte as (select 
				  case
					when `Quality of Sleep` >= 1 and `Quality of Sleep` <= 5 then 'Low'
					when `Quality of Sleep` >= 6 and `Quality of Sleep` <= 7 then 'Medium'
					else 'High' 
				  end as `Sleep_Quality_Cat`,
				  case 
					when `Sleep Duration` < 6 then 'Short'
					when `Sleep Duration` >= 6 and `Sleep Duration` <= 8 then 'Adequate'
					else 'Long'
					end as `Sleep_Duration_Cat`
				 from sleep_health)

select Sleep_Quality_Cat, 
	sum(case when Sleep_Duration_Cat = "Short" then 1 else 0 end) as "Short_Sleep_Length",
    sum(case when Sleep_Duration_Cat = "Adequate" then 1 else 0 end) as "Adequate_Sleep_Length",
    sum(case when Sleep_Duration_Cat = "Long" then 1 else 0 end) as "Long_Sleep_Length"
from cte
group by Sleep_Quality_Cat ;

