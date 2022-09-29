select *
from "Seeker Profile Builder".education_detail as edd, "Seeker Profile Builder".experience_detail as exd
where edd.user_account_id = '8ba23ec2-af99-4242-ae41-ae40acfc5d3b' and exd.user_account_id = '8ba23ec2-af99-4242-ae41-ae40acfc5d3b';



select *
from "Job Post Management".job_post as jp
where jp.id not in (
	select jpa.job_post_id	
	from "Job Post Management".job_post_activity as jpa
);



select jpa.user_account_id, jpa.apply_date
from "Job Post Management".job_post_activity as jpa
where jpa.job_post_id = 'bc3a0aa3-788e-475f-bb5e-ce972d7637a5'
order by jpa.apply_date desc;



select jp.id, jp.job_description, count(jpa.user_account_id)
from "Job Post Management".job_post as jp
left join "Job Post Management".job_post_activity as jpa on jp.id = jpa.job_post_id
where jp.company_id = 'df483a97-c668-466c-af8f-32837c879e3a'
group by jp.id;



select jp.id, jp.job_description, count(jpa.user_account_id)
from "Job Post Management".job_post as jp
left join "Job Post Management".job_post_activity as jpa on jp.id = jpa.job_post_id
where jp.company_id = 'df483a97-c668-466c-af8f-32837c879e3a'
group by jp.id
having count(jpa.user_account_id) = 0;



select edd.major, count(edd.major) as num
from "Job Post Management".job_post_activity as jpa
left join "Seeker Profile Builder".education_detail as edd on edd.user_account_id = jpa.user_account_id
group by edd.major
order by edd.major desc
limit 1;



select *
from "Job Post Management".job_post as jp
left join "Job Post Management".job_post_skill_set as jps on jp.id = jps.job_post_id
where jps.skill_level = 4



select cp.company_name
from "Company Profile".company as cp












