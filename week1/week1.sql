use pd_challenges;

##output1
#alter the column values as per required format
update week_1
set `Transaction Code` = substring( `Transaction Code`,1,3);

select `Transaction Code` from week_1
group by `Transaction Code`;

update week_1
set `Transaction Code` = substring(`Transaction Code`,1,2)
where `Transaction Code` = 'DS-';

select `Transaction Code`, sum(Value) as Value 
from week_1
group by `Transaction Code`;


##output2
alter table week_1
change `Online or In-Person` `Online or In-Person` text;

update week_1
set `Online or In-Person` = case
when `Online or In-Person` = 1 then 'Online'
when `Online or In-Person` = 2 then 'In-Person'
else `Online or In-Person`
end;

select `Transaction Date` from week_1
limit 2;

#changing the Transaction date column as per required datatype(text -> datetime)
alter table week_1 
add weekday datetime;

update week_1 
set weekday = str_to_date(`Transaction Date`, '%d/%m/%Y %H:%i:%s');

alter table week_1
drop column `Transaction Date`;

alter table week_1
change weekday `Transaction Date` datetime;

#updating the day as per the date in the date column
alter table week_1
add column dayfromdate text;

UPDATE week_1
SET dayfromdate = DATE(`Transaction Date`);

alter table week_1
drop column `Transaction Date`;

alter table week_1 
change dayfromdate `Transaction Date` text;

update week_1
set `Transaction Date` = date_format(`Transaction date`, '%W');

#print output in required format
select `Transaction Code`,`Online or In-Person`, `Transaction Date`, sum(Value) as value
from week_1
group by `Transaction Code`,`Online or In-Person`, `Transaction Date`;

##output3
select `Transaction Code`, `Customer Code`, sum(value) as Value 
from week_1
group by `Transaction Code`, `Customer Code`;


