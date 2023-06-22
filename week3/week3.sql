use pd_challenges;

alter table w3_transactions
change column `ï»¿Transaction Code` `Transaction Code` text;

select * from w3_transactions
where `Transaction Code` like 'DSB%';

#rename the values in online or in-person field
alter table w3_transactions
change column `Online or In-Person` `Online or In-Person` text;

update w3_transactions
set `Online or In-Person` = Case
when `Online or In-Person` = 1 then 'Online'
when `Online or In-Person` = 2 then 'In-Person'
else `Online or In-Person`
end;

#changing the date to be the quarter
alter table w3_transactions
add column quarterrn datetime;

select `Transaction Date` from w3_transactions;

update w3_transactions
set quarterrn = str_to_date(`Transaction Date`,'%d/%m/%Y %H:%i:%s');

alter table w3_transactions
drop column `Transaction Date`;

alter table w3_transactions
change column `Transaction Date` `Transaction Date` date;

#alter the date to be the quarter
alter table w3_transactions 
change column `Transaction Date` `Transaction Date` int;
update w3_transactions
set `Transaction Date` = quarter(`Transaction Date`);


#Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person)
select sum(`Value`) as `Value`, `Transaction Date`,`Online or In-Person`
from w3_transactions
group by `Transaction Date`,`Online or In-Person`
order by `Transaction Date`;

#Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter
alter table w3_transactions 
add column `Quarterly Targets` int;

update w3_transactions
join w3_targets
on w3_transactions.`Online or In-Person` = w3_targets.`Online or In-Person`
set `Quarterly Targets` = case
when w3_transactions.`Transaction Date` = 1 and w3_targets.`Online or In-Person` = 'Online' and w3_transactions.`Online or In-Person`='Online' then w3_targets.Q1
when w3_transactions.`Transaction Date` = 1 and w3_targets.`Online or In-Person` = 'In-Person' and w3_transactions.`Online or In-Person`='In-Person' then w3_targets.Q1
when w3_transactions.`Transaction Date` = 2 and w3_targets.`Online or In-Person` = 'In-Person' and w3_transactions.`Online or In-Person`='In-Person' then w3_targets.Q2
when w3_transactions.`Transaction Date` = 2 and w3_targets.`Online or In-Person` = 'Online' and w3_transactions.`Online or In-Person`='Online' then w3_targets.Q2
when w3_transactions.`Transaction Date` = 3 and w3_targets.`Online or In-Person` = 'In-Person' and w3_transactions.`Online or In-Person`='In-Person' then w3_targets.Q3
when w3_transactions.`Transaction Date` = 3 and w3_targets.`Online or In-Person` = 'Online' and w3_transactions.`Online or In-Person`='Online' then w3_targets.Q3
when w3_transactions.`Transaction Date` = 4 and w3_targets.`Online or In-Person` = 'Online' and w3_transactions.`Online or In-Person`='Online' then w3_targets.Q4
when w3_transactions.`Transaction Date` = 4 and w3_targets.`Online or In-Person` = 'In-Person' and w3_transactions.`Online or In-Person`='In-Person' then w3_targets.Q4
else `Quarterly Targets`
end
;

select * from w3_targets ;
select * from w3_transactions;


select w3_transactions.`Online or In-Person`,`Transaction Date` as Quarter, sum(Value) as Value, `Quarterly Targets`,sum(Value) - `Quarterly Targets` as `Variance to Target`
from w3_transactions
join w3_targets
on w3_transactions.`Online or In-Person` = w3_targets.`Online or In-Person`
where `Transaction Code` like 'DSB%'
group by `Transaction Date`,`Online or In-Person`,`Quarterly Targets`;


select sum(Value) from w3_transactions 
group by `Transaction Date`,`Online or In-Person`;









