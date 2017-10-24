
data1 = LOAD '/user/hive/warehouse/h1b.db/h1b_final' USING PigStorage('\t') as (s_no:double,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);

--B = LOAD '/user/hive/warehouse/h1b.db/h1b_final' USING PigStorage('\t') as (s_no:double,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:double,year:chararray,worksite:chararray,longitude,latitude);

--data1 = UNION A,B;
--dump data1;
 
data2 = FOREACH data1 GENERATE $1,$4,$7;
--dump data2;
year1 = FILTER data2 BY $2 == '2011';
year2 = FILTER data2 BY $2 == '2012';
year3 = FILTER data2 BY $2 == '2013';
year4 = FILTER data2 BY $2 == '2014';
year5 = FILTER data2 BY $2 == '2015';
year6 = FILTER data2 BY $2 == '2016';

group1 = group year1 by ($1);
group2 = group year2 by ($1);
group3 = group year3 by ($1);
group4 = group year4 by ($1);
group5 = group year5 by ($1);
group6 = group year6 by ($1);

Count1 = foreach group1 generate group, COUNT(year1.$1);
Count2 = foreach group2 generate group, COUNT(year2.$1);
Count3 = foreach group3 generate group, COUNT(year3.$1);
Count4 = foreach group4 generate group, COUNT(year4.$1);
Count5 = foreach group5 generate group, COUNT(year5.$1);
Count6 = foreach group6 generate group, COUNT(year6.$1);

JOIN1 = join Count1 BY $0, Count2 BY $0, Count3 BY $0, Count4 BY $0, Count5 BY $0,Count6 BY $0;

data3 = foreach JOIN1 GENERATE $0,$1,$3,$5,$7,$9,$11;
--dump data3;

average1 = FOREACH data3 GENERATE $0, (DOUBLE)((($2-$1)*100)/$1+(($3-$2)*100)/$2+(($4-$3)*100)/$3+(($5-$4)*100)/$4+(($6-$5)*100)/$5);

RESULT1 = FOREACH average1 GENERATE $0, (DOUBLE)($1/5);
--DUMP RESULT1

AVERAGEDESC1= LIMIT (ORDER RESULT1 BY $1 DESC) 5;
DUMP AVERAGEDESC1;



