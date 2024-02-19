create database Datascience;
select * from ds_salaries;

-- cek data apakah ada yang null
select * from ds_salaries
where work_year is null
OR experience_level IS NULL
	OR employment_type IS NULL
	OR job_title IS NULL
	OR salary IS NULL
	OR salary_currency IS NULL
	OR salary_in_usd IS NULL
	OR employee_residence IS NULL
	OR remote_ratio IS NULL
	OR company_location IS NULL
	OR company_size IS NULL;
    
    -- job title apa saja yang ada di tabel
    select distinct job_title 
    from ds_salaries 
    group by job_title;
    
    /* riset mengenai pekerjaan yang berkaitan dengan data analyst*/
      select distinct job_title 
    from ds_salaries 
    where job_title like '%data analyst%'
    group by job_title;
    
    -- rata-rata gaji data analyst convert to rupiah
    select (avg(salary_in_usd)* 1500) /12 as salarypermonth
    from ds_salaries 
    where job_title like '%data analyst%';
    
    -- gaji rata-ratanya berdasarkan experience level,job title, dan employment, dan uutan terkecil ke terbesar
	select experience_level,employment_type,job_title, (avg(salary_in_usd)* 1500) /12 as salarypermonth
    from ds_salaries 
    where job_title like '%data analyst%'
    group by 1,2,3
    order by 4 asc;
    
    -- di negara mana data analyst memilki gaji yang paling menarik dan kita ingin bekerja secara remote
    select company_location,job_title,employment_type,(avg(salary_in_usd)* 15000) /12 as salarypermonth
    from ds_salaries 
    where job_title like '%data analyst%' and remote_ratio = 100
    group by 1,2,3
    order by 4 desc;
    
    -- ingin setidaknya gaji diatas 50 jt per bulan
    select company_location,job_title,employment_type,(avg(salary_in_usd)* 15000) /12 as salarypermonth
    from ds_salaries 
    where job_title like '%data analyst%' and remote_ratio = 100
    group by 1,2,3
    having salarypermonth >= 50000000
    order by 4 asc;
    
    -- di tahun berapa terjadi kenaikan yang cukup tinggi dari experience level mid ke senior
    -- data analyst, full time
    select distinct work_year from ds_salaries;
    
    with senior as
    (select work_year, (avg(salary_in_usd)* 15000) /12 as sesalarypermonth
    from ds_salaries
    where job_title like '%data analyst%'
    and employment_type = "FT"
    and experience_level = "SE"
    group by 1),
    
    mid as(
	select work_year, (avg(salary_in_usd)* 15000) /12 as midsalarypermonth
    from ds_salaries
    where job_title like '%data analyst%'
    and employment_type = "FT"
    and experience_level = "MI"
    group by 1)
    
	select s.work_year, s.sesalarypermonth, m.midsalarypermonth, s.sesalarypermonth - m.midsalarypermonth
    from senior s left join mid m
    on s.work_year = m.work_year
    union
    select m.work_year, s.sesalarypermonth, m.midsalarypermonth, s.sesalarypermonth - m.midsalarypermonth
    from senior s right join mid m
    on s.work_year = m.work_year;
    
     
    

    
    
    