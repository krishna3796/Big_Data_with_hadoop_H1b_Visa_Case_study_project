load_data = Load '/user/hive/warehouse/h1b.db/h1b_final' using PigStorage('\t') as (s_no,case_status,employer_name,soc_name,job_title:chararray,full_time_position,prevailing_wage,year:chararray,worksite:chararray,longitute,latitute);



filter_data_2011 = filter load_data by job_title == 'DATA ENGINEER' and year == '2011';

groupby_worksite = group filter_data_2011 by worksite ;

bag2011 = foreach groupby_worksite generate group as worksite,COUNT(filter_data_2011.job_title) as total;

final =limit( order bag2011 by total desc)1;






filter_data_2012 = filter load_data by job_title == 'DATA ENGINEER' and year == '2012';

groupby_worksite2 = group filter_data_2012 by worksite ;

bag2012 = foreach groupby_worksite2 generate group as worksite,COUNT(filter_data_2012.job_title) as total;

final2 =limit( order bag2012 by total desc)1;





filter_data_2013 = filter load_data by job_title == 'DATA ENGINEER' and year == '2013';

groupby_worksite3 = group filter_data_2013 by worksite ;

bag2013 = foreach groupby_worksite3 generate group as worksite,COUNT(filter_data_2013.job_title) as total,filter_data_2013.year;

final3 =limit( order bag2013 by total desc)1;




filter_data_2014 = filter load_data by job_title == 'DATA ENGINEER' and year == '2014';

groupby_worksite4 = group filter_data_2014 by worksite ;

bag2014 = foreach groupby_worksite4 generate group as worksite,COUNT(filter_data_2014.job_title) as total;

final4 =limit( order bag2014 by total desc)1;





filter_data_2015 = filter load_data by job_title == 'DATA ENGINEER' and year == '2015';

groupby_worksite5 = group filter_data_2015 by worksite ;

bag2015 = foreach groupby_worksite5 generate group as worksite,COUNT(filter_data_2015.job_title) as total;

final5 =limit( order bag2015 by total desc)1;






filter_data_2016 = filter load_data by job_title == 'DATA ENGINEER' and year == '2016';

groupby_worksite6 = group filter_data_2016 by worksite ;

bag2016 = foreach groupby_worksite6 generate group as worksite,COUNT(filter_data_2016.job_title) as total;

final6 =limit( order bag2016 by total desc)1;






total_final = union final,final2,final3,final4,final5,final6;
dump total_final;











































