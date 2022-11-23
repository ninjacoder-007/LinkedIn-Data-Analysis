create procedure recieved_messages as (
select * from messages where [to] like 'Shubham Ghadge' )

exec recieved_messages