create procedure sent_messages as(
select * from messages where [from] like 'Shubham Ghadge')

exec sent_messages



