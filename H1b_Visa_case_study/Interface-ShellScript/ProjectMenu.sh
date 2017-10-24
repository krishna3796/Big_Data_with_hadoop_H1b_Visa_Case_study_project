#!/bin/bash 
show_menu()
{
    BIPur='\033[01;35m'
    BIBlu='\e[1;94m'
	BIGre='\e[1;92m'
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"`   #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    bold=$(tput bold)
    normal=$(tput sgr0)
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}${BIPur}+---------------H1B VISA PROJECT MENU${NORMAL}${BIPur}--------------------------------+${NORMAL}"
    echo -e "${MENU}${BIPur}${bold}|${NUMBER} 1)${MENU}${bold}${BIBlu} Hive                                                           ${NORMAL} ${BIPur}|${NORMAL}"
    echo -e "${MENU}${BIPur}|${NUMBER} 2)${MENU}${bold}${BIBlu} Map Reduce                                                     ${NORMAL} ${BIPur}|${NORMAL}"
    echo -e "${MENU}${BIPur}|${NUMBER} 3)${MENU}${bold}${BIBlu} Pig                                                           ${NORMAL}  ${BIPur}|${NORMAL}"
    echo -e "${MENU}${BIPur}|${NUMBER} 4)${MENU}${bold}${BIBlu} Export data from HDFS to MySql database using SQOOP            ${NORMAL} ${BIPur}|${NORMAL}"
    echo -e "${MENU}${BIPur}|${NUMBER} 5)${MENU}${bold}${BIBlu} Display the exported data from MySql database                  ${NORMAL} ${BIPur}|${NORMAL}"
    echo -e "${MENU}${BIPur}+--------------------------------------------------------------------+${NORMAL}"
    echo -e "${ENTER_LINE}${bold}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}

function hive_menu()
{
 echo -e "${ENTER_LINE}${bold} Select A Query:" 
	echo -e "${ENTER_LINE}${bold}1) ${BIBlu}Is the number of petitions with Data Engineer job title increasing over time ?"
	echo -e "${ENTER_LINE}${bold}2) ${BIBlu}Which industry(SOC_NAME) has the most number of Data Scientist positions?
[certified]"
	echo -e "${ENTER_LINE}${bold}3) ${BIBlu}Find the percentage and the count of each case status on total applications for each year. Create a line graph depicting the pattern of All the cases over the period of time."
	echo -e "${ENTER_LINE}${bold}4) ${BIBlu}Create a bar graph to depict the number of applications for each year [All]"
	echo -e "${ENTER_LINE}${bold}5) ${BIBlu}Find the average Prevailing Wage for each Job for each Year (take part time and full time separate). Arrange the output in descending order - [Certified and Certified Withdrawn.]${NORMAL}"

echo "(Enter 'e' to Exit)";
}
function option_picked()
{
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE="$1"  #modified to post the correct option selected
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
	    hive_menu
read option;


 case $option in
                1) hive -e "select * from h1b.h1b_final limit 10"
                    ;;	

		2) hive -e "select soc_name,count(job_title) as tot from h1b.h1b_final where job_title='DATA SCIENTIST' and case_status='CERTIFIED' group by soc_name order by tot desc limit 1;"
                    ;;	


		3) echo "Enter a year:"; 
			read year;
 hive -e "select a.case_status,count(a.case_status) as case_count,round((count(a.case_status)/total*100),2) as case_percent from h1b.h1b_final a,h1b.totalcount b where a.year='$year' group by a.case_status,b.total;"
                    ;;	


		4) hive -e "select year,count(*) from h1b.h1b_final group by year;"
                    ;;	


		5) echo "Enter Job Position (Part time = N    Full time = Y)"
			read $op1
 	hive -e "select year,job_title,avg(prevailing_wage) as totavg from h1b.h1b_final where (case_status='CERTIFIED' OR case_status='CERTIFIED-WITHDRAWN') and full_time_position='$op1' group by job_title,year order by totavg desc;"
                    ;;	


		*) echo "Please Select one among the option[1-5]";;
                esac
                show_menu;
                    ;;
	

 
           2)clear;
	echo -e "${ENTER_LINE}${bold}Select an option [1-4] :"
		echo -e "${ENTER_LINE}${bold}1) ${BIBlu}Find top 5 locations in the US who have got certified visa for each year.[certified]"; 
	echo -e "${ENTER_LINE}${bold}2) ${BIBlu}Which top 5 employers file the most petitions each year? - Case Status - ALL";   
	echo -e "${ENTER_LINE}${bold}3) ${BIBlu}Find the most popular top 10 job positions for H1B visa applications for each year ? (for all applications)";
	echo -e "${ENTER_LINE}${bold}4) ${BIBlu}Find the most popular top 10 job positions for H1B visa applications for each year ? (only certified applications)${NORMAL}";
	echo "(Enter 'e' to Exit)";
	read mroption;

case $mroption in
                1) 
			hadoop fs -rm -r /output/p*
			hadoop jar '/home/hduser/Documents/project2b.jar' Project_2b /user/hive/warehouse/h1b.db/h1b_final /output/project_2b
			hadoop fs -cat /output/project_2b/p*
                    ;;

 		2) 
			hadoop fs -rm -r /output/p*
			hadoop jar '/home/hduser/Documents/project4.jar' Project_4 /user/hive/warehouse/h1b.db/h1b_final /output/project_4
			hadoop fs -cat /output/project_4/p*
                    ;;
	

		3) 
			hadoop fs -rm -r /output/p*
			hadoop jar '/home/hduser/Documents/project5a.jar' Project_5a /user/hive/warehouse/h1b.db/h1b_final /output/project_5a
			hadoop fs -cat /output/project_5a/p*
                    ;;

		4) 
			hadoop fs -rm -r /output/p*
			hadoop jar '/home/hduser/Documents/project5b.jar' Project_2b /user/hive/warehouse/h1b.db/h1b_final /output/project_5b
			hadoop fs -cat /output/project_5b/p*
                    ;;


     		*) echo "Please Select one among the option[1-4]";;
                esac
                show_menu;
                    ;;

3)clear;
echo -e "${ENTER_LINE}${bold}Select an option [1-4] :"
echo -e "${ENTER_LINE}${bold}1) ${BIBlu}Find top 5 job titles who are having avg highest growth in applications.[ALL](project 1b)";
echo -e "${ENTER_LINE}${bold}2) ${BIBlu}Which part of the US has the most Data Engineer jobs for each year?(project 2a)";
echo -e "${ENTER_LINE}${bold}3) ${BIBlu}Which are the employers along with the number of petitions who have the success rate more than 70%  in petitions. (total petitions filed 1000 OR more than 1000)?";
echo -e "${ENTER_LINE}${bold}4) ${BIBlu}Which are the  job positions along with the number of petitions which have the success rate more than 70%  in petitions (total petitions filed 1000 OR more than 1000)?${NORMAL}";
echo "(Enter 'e' to Exit)";
read pigopt;
case $pigopt in
                1)pig piggyproject1b.pig
                    ;;
		2)pig piggyproject2a.pig
                    ;;
		3)pig piggyproject9.pig
                    ;;
		4)hadoop fs -rm -r /output/pigout/pigproject10
		pig piggyproject10.pig
		hadoop fs -cat /output/pigout/pigproject10/p*
                    ;;


		*) echo "Please select one among the option[1-4]";;
                esac
                show_menu;
                    ;;

4)clear
mysql -u root -p'root' -e 'drop database question10;create database if not exists question10;use question10;create table q10(job_title varchar(100),success_rate float,petitions int);';

sqoop export --connect jdbc:mysql://localhost/question10 --username root --password 'root' --table q10 --update-mode allowinsert  --export-dir /output/pigout/pigproject10/p* --input-fields-terminated-by '\t' 
show_menu
;;

5)clear
mysql -u root -p'root' -e 'select * from question10.q10';
show_menu
;;


 	\n) exit;
        ;;

        *) clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi



done

