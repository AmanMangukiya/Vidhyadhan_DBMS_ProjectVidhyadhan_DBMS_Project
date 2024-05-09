set search_path to Vidhyadhan;

-- 1.Given name of available scholarship

SELECT S_Name FROM Scholarships WHERE Closing_Date >= CURRENT_DATE;

-- 2.List of applied scholarships by given applicant

SELECT S.S_Name
FROM Scholarships S
INNER JOIN Applied_in A ON S.Scholarship_Id = A.Scholarship_Id
WHERE A.Applicant_Id = 'A0000001';

-- 3.Get the list of students who applied for the given scholarship.

SELECT  A.applicant_id , A.Fname, A.Lname
FROM Applicant A
INNER JOIN Applied_in AI ON A.Applicant_Id = AI.Applicant_Id
INNER JOIN Scholarships S ON AI.Scholarship_Id = S.Scholarship_Id
WHERE S.S_Name = 'Merit Scholarship';

-- 4.The total amount received by a particular student.

SELECT SUM(RF.Ammount_Received)
FROM Received_From RF
WHERE RF.Applicant_id = 'A0000001';

-- 5.List all scholarships sorted by the amount of financial aid 
-- offered and time duration.

SELECT S.S_Name, S.Amount, S.Starting_Date, S.Closing_Date
FROM Scholarships S
ORDER BY S.Amount DESC, S.Closing_Date;

-- 6.List upcoming scholarships.

SELECT S.S_Name, S.Starting_Date, S.Closing_Date
FROM Scholarships S
WHERE S.Starting_Date > CURRENT_DATE;

-- 7.List all scholarships funded by the donor or Company along

SELECT S.S_Name
FROM Scholarships S
INNER JOIN Donated_In D ON S.Scholarship_Id = D.Scholarship_Id
INNER JOIN Donor DR ON D.Donor_Id = DR.Donor_Id
WHERE DR.Company_Name = 'ABC Enterprises';

-- 8.The total amount donated by them till now.

SELECT SUM(DI.Donated_Ammount)
FROM Donated_In DI
WHERE DI.Donor_Id = 'D0000001';

-- 9.Get the list of all the applicants sorted by their percentile who have applied 
-- for each scholarship

SELECT A.Fname, A.Lname, Q.Percentile
FROM Applicant A
INNER JOIN Qualification Q ON A.Applicant_Id = Q.Applicant_Id
INNER JOIN Applied_in AI ON A.Applicant_Id = AI.Applicant_Id
INNER JOIN Scholarships S ON AI.Scholarship_Id = S.Scholarship_Id
ORDER BY S.S_Name, Q.Percentile DESC;

-- 10.Select students who have applied but not received scholarship 
-- for each scholarship

SELECT A.Applicant_id ,A.Fname, A.Lname, AI.Scholarship_Id
FROM Applicant A
INNER JOIN Applied_in AI ON A.Applicant_Id = AI.Applicant_Id
LEFT JOIN Received_From RF ON AI.Applicant_Id = RF.Applicant_Id
WHERE RF.Applicant_Id IS NULL;

-- 11.List all scholarships ordered by their Applicant deadlines

SELECT S.S_Name, S.Closing_Date
FROM Scholarships S
ORDER BY S.Closing_Date;

-- 12.List all scholarships ordered by their number of applicants

SELECT S.S_Name, COUNT(AI.Applicant_Id) AS Num_Applicants
FROM Scholarships S
LEFT JOIN Applied_in AI ON S.Scholarship_Id = AI.Scholarship_Id
GROUP BY S.S_Name
ORDER BY Num_Applicants DESC;

--13.Identify the donors who have contributed the highest amount of scholarships.


SELECT DR.Donor_Id, SUM(DI.Donated_Ammount) AS Total_Amount
FROM Donor DR
INNER JOIN Donated_In DI ON DR.Donor_Id = DI.Donor_Id
GROUP BY DR.Donor_Id
ORDER BY Total_Amount DESC
LIMIT 1;


-- 15. Get a scholarship(name,criteria,deadline etc) which is currently available.

SELECT *FROM Scholarships WHERE Closing_Date >= CURRENT_DATE
ORDER BY Closing_Date ;

-- 16. Give the name of all company which is gives scholership in multiple state.

SELECT DR.Company_Name FROM Donor DR
INNER JOIN Donated_In DI ON DR.Donor_Id = DI.Donor_Id
INNER JOIN Scholarships S ON DI.Scholarship_Id = S.Scholarship_Id
INNER JOIN States ST ON S.Scholarship_Id = ST.Scholarship_Id
GROUP BY DR.Company_Name
HAVING COUNT(DISTINCT ST.State_Name) > 1;

-- 17.Give the scholarship name in which multiple company donated amount

SELECT S.S_Name
FROM Scholarships S
INNER JOIN Donated_In DI ON S.Scholarship_Id = DI.Scholarship_Id
INNER JOIN Donor DR ON DI.Donor_Id = DR.Donor_Id
GROUP BY S.S_Name
HAVING COUNT(DISTINCT DR.Company_Name) > 1;


-- 18 .list all the scholarships with average scholarship amount in descending order.

SELECT S.S_Name, AVG(S.Amount) AS Avg_Amount
FROM Scholarships S
GROUP BY S.S_Name
ORDER BY Avg_Amount DESC;

-- 19. Calculate the total amount of funds received for scholarships in each state: 
SELECT ST.State_Name, SUM(RF.Ammount_Received) AS Total_Amount_Received
FROM States ST
INNER JOIN Scholarships S ON ST.Scholarship_Id = S.Scholarship_Id
INNER JOIN Received_From RF ON S.Scholarship_Id = RF.Scholarship_Id
GROUP BY ST.State_Name;

-- 20 List all applicants who have applied for scholarships in a specific city.

SELECT distinct A.Applicant_id ,A.Fname, A.Lname, S.Scholarship_Id
FROM Applicant A
INNER JOIN Applied_in AI ON A.Applicant_Id = AI.Applicant_Id
INNER JOIN Scholarships S ON AI.Scholarship_Id = S.Scholarship_Id
INNER JOIN States ST ON S.Scholarship_Id = ST.Scholarship_Id
INNER JOIN Citys C ON c.City = C.City
WHERE C.City = 'Rajkot';


-- 21. give the remaining amount of each scholership after distributing 
-- scholership amount of all eligible applicant

select t1.Scholarship_Id  ,(t1.sum - t2.sum) as Remaining_Fund from 
((select sum(Donated_Ammount),Scholarship_Id 
  			from (Scholarships Natural Join Donated_In)
					group by Scholarship_Id order by Scholarship_Id ASC )t1
INNER JOIN
(select sum(Ammount_Received),Scholarship_Id 
			from (Scholarships Natural Join Received_From)
					group by Scholarship_Id order by Scholarship_Id ASC)t2
 
on t1.Scholarship_id = t2.Scholarship_id) order by t1.Scholarship_Id

-- 22.List all scholarships along with the department offering them.

SELECT S.Scholarship_Id, S.S_Name, DP.Department_Name
FROM Scholarships S
INNER JOIN Departments_with_Programs DP ON S.Scholarship_Id = s.Scholarship_Id;

-- 23.Get the list of all facilitators who work under a given manager.

SELECT *FROM Employees
WHERE Manager_Email_Id = 'Ramesh223@gmail.com';

-- 24.List of all Scholarships managed by a given manager:

SELECT S.*FROM Scholarships S
INNER JOIN Employees E ON S.Scholarship_Id = E.Scholarship_Id
WHERE E.Manager_Email_Id = 'Ramesh223@gmail.com';


--25. Get the number of applicants who applied for a 
-- scholarship which is managed by a given manager

SELECT COUNT(AI.Applicant_Id) AS Num_Applicants
FROM Applied_in AI
INNER JOIN Scholarships S ON AI.Scholarship_Id = S.Scholarship_Id
INNER JOIN Employees E ON S.Scholarship_Id = E.Scholarship_Id
WHERE E.Email_Id = 'Divya298@gmail.com';

--26.Get all donors details who give donations for a scholarship 
-- managed by a given manager:

SELECT D.*FROM Donor D
INNER JOIN Donated_In DI ON D.Donor_Id = DI.Donor_Id
INNER JOIN Scholarships S ON DI.Scholarship_Id = S.Scholarship_Id
INNER JOIN Employees E ON S.Scholarship_Id = E.Scholarship_Id
WHERE E.Email_Id = 'Divya298@gmail.com';

-- 27 . give applicant who got greater or equal 90 percentile.
select Applicant_Id,Fname,Mname,Lname from (Applicant natural join Qualification) 
where percentile>=90.0 and Type_of_Qualification='JEE' order by Applicant_id;


--28. List applicants exceeding a certain amount of scholarship.

SELECT A.* FROM Applicant A
INNER JOIN Received_From RF ON A.Applicant_Id = RF.Applicant_Id
INNER JOIN Scholarships S ON RF.Scholarship_Id = S.Scholarship_Id
WHERE RF.Ammount_Received > 80000;

--29.List all applicants who have been selected for 
-- scholarships but have not yet received it.

SELECT A.* FROM Applicant A
INNER JOIN Applied_in AI ON A.Applicant_Id = AI.Applicant_Id
LEFT JOIN Received_From RF ON AI.Applicant_Id = RF.Applicant_Id
WHERE RF.Applicant_Id IS NULL;