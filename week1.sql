use pd_challenges;

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

