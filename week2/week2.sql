use pd_challenges;

#removing '-' from sortcode field in transactions table
update w2_transactions
set `Sort Code` = replace(`Sort Code`,'-','');

#setting the primary and foreign keys in respective tables
alter table w2_swiftcodes
add constraint pk_codes 
primary key (Bank);
alter table w2_transactions
add constraint fk_transaction 
foreign key (Bank) references w2_swiftcodes(Bank);

select * from w2_swiftcodes
join w2_transactions
on w2_swiftcodes.Bank = w2_transactions.Bank;

#add a field for country code with default value GB for UK
alter table w2_transactions
add column `Country Code` char(2) default 'GB';

#creating the IBAN
alter table w2_transactions
add column IBAN varchar(255);

update w2_transactions
join w2_swiftcodes 
on w2_transactions.Bank = w2_swiftcodes.Bank
set w2_transactions.IBAN = concat(w2_transactions.`Country Code`,w2_swiftcodes.`Check Digits`,w2_swiftcodes.`SWIFT Code`,w2_transactions.`Sort Code`, w2_transactions.`Account Number`)
;

select `Transaction ID`, IBAN from w2_transactions;








