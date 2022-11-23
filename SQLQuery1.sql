--using the linkedin database.
use LinkedIn

-- reading data for first impression.
select * from [Company Follows]
select * from Connections
select * from Endorsement_Given_Info
select * from Invitations
select * from [Job Applications]
select * from [Job Applications_1]
select * from [Job Applications_2]
select * from Learning
select * from messages
select * from Profile
select * from Reactions
select * from SearchQueries
select * from Shares
select * from Votes

--cleaning database tables one by one.
-- company follows
select * from [Company Follows]

-- deleting top 1 record from table as it contains headers.
delete top(1) from [Company Follows]

--creating another same table
create table company
	(
		Organization varchar(max),
		FollowedDate varchar(max)
		
	)

-- inserting data from old table to new table.
insert into company
select * from [Company Follows]

--droping old table
drop table [Company Follows]
select * from company

--connections table

select * from Connections
-- here email addresss column contains only null values so its better to remove that column from database.
alter table Connections
drop column Email_Address
select * from Connections

--Endorsement_given_info table
select * from Endorsement_Given_Info
--this table doesn't need any changes or cleaning.

--Invitations table
select * from Invitations
--droping message column as it containing null values.
alter table Invitations
drop column Message
select * from Invitations

--outgoing invitations
create table Outgoing_Invitations
(
	sender varchar(max),
	receiver   varchar(max),
	Sent_at varchar(max),
	direction varchar(max)
	)
insert into Outgoing_Invitations
select * from Invitations where Direction  like 'OUTGOING'

--Incoming Invitations
create table Incoming_Invitations
(
	sender varchar(max),
	receiver   varchar(max),
	Sent_at varchar(max),
	direction varchar(max)
	)
insert into Incoming_Invitations
select * from Invitations where Direction  like 'INCOMING'
select * from Outgoing_Invitations
select * from Incoming_Invitations

--dropping table as we have segregated the data
drop table Invitations

--job applications table
select * from [Job Applications]


-- dropping unwanted columns from tables job_applications_1
alter table [Job Applications_1] 
drop column Contact_Email, Contact_Phone_Number, job_url,Question_and_answers,resume_name

-- dropping unwanted columns from tables job_applications_1
alter table [Job Applications_2] 
drop column resume_name,Contact_Email, Contact_Phone_Number, job_url,Question_and_answers



-- dropping unwanted columns from tables job_applications
alter table [Job Applications]
drop column Contact_email,contact_phone_number,job_url,resume_name, Question_and_answers,resume_name

--from 3 columns of job application making only one column for convenience.
insert into [Job Applications]
select * from [Job Applications_1]
where Application_Date is not null and
Company_Name is not null and
Job_Title is not null
union
select * from [Job Applications_2]
where Application_Date is not null and
Company_Name is not null and
Job_Title is not null

--dropping unwanted tables
drop table [Job Applications_1],[Job Applications_2]

--learnings table
select * from Learning

--removing null column
alter table Learning
drop column column8


--logins table
select * from Logins

--messages table
--created 2 stored procedures one containing messages sent by me and 2 containing messages recieved by me.

--Profile table.
select * from profile
--dosent require any cleaning.

--reactions table
select [type], count([type]) totalreactions from Reactions
group by [Type]

-- searchQueries table.

with totalqueries as
(
select search_query, count(search_query) total_queries from SearchQueries 
group by Search_Query
)
select top 10 search_query, max(total_queries) total_queries from totalqueries
group by search_query
order by total_queries desc

-- shares table
select * from shares
select distinct(count(*)) from shares
-- No cleaning and analysis needed.

-- votes table.
Select distinct(count(*)) from votes
select * from Votes