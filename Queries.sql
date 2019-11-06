SELECT Equipment.EquipmentID, Equipment.Make, Equipment.Model, Equipment.Description
FROM Equipment
LEFT JOIN EquipmentLoan ON Equipment.EquipmentID = EquipmentLoan.EquipmentID
WHERE Damaged = 0 AND (Current = 0 OR Current IS NULL) AND (Description LIKE '%video%' OR Type LIKE '%video%'); 

SELECT Employee.EmployeeID, FirstName, LastName 
FROM Employee 
INNER JOIN Contract ON Employee.EmployeeID = Contract.EmployeeID 
WHERE year(DueFinish) = 2019 AND ActualFinish IS NULL;

SELECT Project.Title, SUM(Expense.Amount) AS "Expenses" 
FROM Project
LEFT JOIN Expense ON Project.ProjectID= Expense.ProjectID
GROUP BY Project.ProjectID;

SELECT DISTINCT Employee.FirstName, Employee.LastName, Employee.Email, Grade.Title 
FROM EmployeeSkill 
INNER JOIN Employee ON EmployeeSkill.EmployeeID = Employee.EmployeeID 
INNER JOIN Skill ON EmployeeSkill.SkillID = Skill.SkillID 
INNER JOIN Grade ON Employee.GradeID = Grade.GradeID 
WHERE Skill.Title LIKE '%video%';

SELECT Project.Title, COUNT(*) AS 'No Employees'
FROM Assignment 
INNER JOIN Project On Assignment.ProjectID = Project.ProjectID 
INNER JOIN Employee ON Assignment.EmployeeID = Employee.EmployeeID 
WHERE Employee.Current = 1 AND Project.Internal = 0
GROUP BY Assignment.ProjectID HAVING COUNT(*) > 2;

SELECT DISTINCT Employee.EmployeeID, Employee.FirstName, Employee.LastName
FROM Employee
LEFT JOIN Assignment ON Employee.EmployeeID = Assignment.EmployeeID
WHERE Assignment.EmployeeID IS NULL;

SELECT Skill.Title, COUNT(*) AS 'No Employees'FROM EmployeeSkill 
LEFT JOIN Skill ON EmployeeSkill.SkillID =Skill.SkillID
GROUP BY EmployeeSkill.SkillID;

SELECT EquipmentLoan.EmployeeID, COUNT(*) AS "Equipment on Loan"
FROM EquipmentLoan 
WHERE EquipmentLoan.Current = 1
GROUP BY EquipmentLoan.EmployeeID;

SELECT EquipmentLoan.EmployeeID, COUNT(*) AS "All Time Loans"
FROM EquipmentLoan 
GROUP BY EquipmentLoan.EmployeeID;

SELECT Payslip.PayslipID, Payslip.EmployeeID FROM Payslip LEFT JOIN Contract ON
Contract.EmployeeID = Payslip.EmployeeID WHERE (Contract.Start < "2017-01-01" AND
Contract.DueFinish < "2017-01-01") OR (Contract.Start > "2017-12-31" AND
Contract.DueFinish > "2017-12-31") OR Contract.EmployeeID is null AND YEAR(Payslip.Payday) = 2017;