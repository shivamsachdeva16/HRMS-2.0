



/* function so that user's leaves record*/
drop function fUserLeaveDetail;
create function fUserLeaveDetail(@EmployeeId int)
returns TABLE
AS
RETURN 
select tLeaves.LeaveType,tEmployeeLeaves.StartDate,
tEmployeeLeaves.EndDate,tEmployeeLeaves.Status from tBalanceAccount 
INNER JOIN
tLeaves ON tLeaves.LeaveId=
tBalanceAccount.LeaveId	
INNER JOIN
tEmployeeLeaves on tBalanceAccount.LeaveId=tEmployeeLeaves.LeaveId 
AND tEmployeeLeaves.EmployeeId=tBalanceAccount.EmployeeId 
where tBalanceAccount.EmployeeId=@EmployeeId ;
 
select * from fUserLeaveDetail(1);

/* function for leave details*/
create function fUserLeaveBalance(@EmployeeId int)
returns TABLE
as 
RETURN
select LeaveId,Balance,LeavesTaken,Approved,Pending,Cancelled
from tBalanceAccount where EmployeeId=@EmployeeId ;



select * from fUserLeaveBalance(1);

  create function fUserLeaveBalanceEdit(@EmployeeId int)returns TABLE
as
RETURN
 select
(select LeaveType from tLeaves where tLeaves.LeaveId=tBalanceAccount.LeaveId)as LeaveType,Balance,LeavesTaken,Approved,Pending,Cancelled
from tBalanceAccount WHERE EmployeeId=@EmployeeId;

select * from fUserLeaveBalanceEdit(5);
/* competence manager would be able to see the leaves request generated by members of his team*/
create function fCMLeaveStatus(@ManagerId int)
returns TABLE
as 
RETURN
select EmployeeId,LeaveId,RequestTime,StartDate,EndDate 
from tEmployeeLeaves
where ManagerId=@ManagerId ;

select * from fCMLeaveStatus(3);
/* CM would be able to see pending requests*/
create function fCMLeaveStatusPending(@ManagerId int)

returns TABLE
as 
RETURN
select EmployeeId,LeaveId,RequestTime,StartDate,EndDate 
from tEmployeeLeaves
where ManagerId=@ManagerId AND  Status='pending' ;

select * from fCMLeaveStatusPending(3);
/* CM will see the leaves approved */
create function fCMLeaveStatusApproved(@ManagerId int)

returns TABLE
as 
RETURN
select EmployeeId,LeaveId,RequestTime,StartDate,EndDate 
from tEmployeeLeaves
where ManagerId=@ManagerId AND Status='approved' ;

create function fUserRequests(@EmployeeId int)
returns TABLE
as
RETURN
 select
(select LeaveType from tLeaves where tLeaves.LeaveId=tEmployeeLeaves.LeaveId)as LeaveType,StartDate,EndDate,Status
from tEmployeeLeaves WHERE EmployeeId=@EmployeeId;

select * from fUserRequests(1);

create function fUserSeeLeavesApproved(@EmployeeId INT)
RETURNS TABLE
AS
RETURN
select
(select LeaveType from tLeaves where tLeaves.LeaveId=tEmployeeLeaves.LeaveId)as LeaveType,StartDate,EndDate,Status
from tEmployeeLeaves WHERE EmployeeId=@EmployeeId AND Status='approved' ; 

select * from fUserSeeLeavesApproved(2);
select * from tBalanceAccount;
select * from tEmployeeLeaves;
select * from tLeaves;
select * from Employee;
select * from ProjectTeamDetails;

 create function fUserLeavesPerStatus(@EmployeeId INT,@Status varchar(50))
RETURNS TABLE
AS
RETURN

select
(select LeaveType from tLeaves where tLeaves.LeaveId=tEmployeeLeaves.LeaveId)as LeaveType,StartDate,EndDate,Status
from tEmployeeLeaves WHERE EmployeeId=@EmployeeId AND Status=@Status ; 

select * from fUserLeavesPerStatus(1,'pending');

