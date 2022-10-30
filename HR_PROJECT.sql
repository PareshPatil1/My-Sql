use hr;
show tables;

/*1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last 
Name"*/
select first_name as "First Name",Last_name as "Last Name"
from employees;

/*2. Write a query to get unique department ID from employee table*/
select distinct(department_id) 
from hr.employees;

/*3. Write a query to get all employee details from the employee table order by first name, descending*/
select * from employees
order by first_name desc;

/*4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is 
calculated as 15% of salary)*/
select first_name,last_name,salary,salary*0.15 as"pf"
from employees;

/*5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of 
salary*/
select employee_id,first_name,last_name,salary
from employees
order by salary asc;

/*6. Write a query to get the total salaries payable to employees*/
select sum(salary)
from employees;

/*7. Write a query to get the maximum and minimum salary from employees table*/
select max(salary),
       min(salary)
from employees;

/*8. Write a query to get the average salary and number of employees in the employees table*/
select avg(salary),count(*)
from employees;
 
 /*9. Write a query to get the number of employees working with the company*/
 select count(*)
 from employees;

/*10. Write a query to get the number of jobs available in the employees table*/
select count(distinct job_id)
from employees;

/*11. Write a query get all first name from employees table in upper case*/
select upper(first_name) 
from employees;

/*12. Write a query to get the first 3 characters of first name from employees table*/
select substring(first_name,1,3)
from employees; 

/*13. Write a query to get first name from employees table after removing white spaces from both side*/
select trim(first_name)
from employees;

/*14. Write a query to get the length of the employee names (first_name, last_name) from employees table*/
select first_name,last_name, length(first_name)+ length(last_name) as 'lenth'
from employees;

/*15. Write a query to check if the first_name fields of the employees table contains numbers*/
select *
from employees
where first_name regexp '[0-9]';

/*16. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is 
not in the range $10,000 through $15,000*/
select first_name,last_name,salary
from employees
where salary not between 10000 and 15000;

/*17. Write a query to display the name (first_name, last_name) and department ID of all employees in 
departments 30 or 100 in ascending order*/
select first_name,last_name,department_id
from employees
where department_id in (30,100)
order by department_id asc;

/*18. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is 
not in the range $10,000 through $15,000 and are in department 30 or 1000*/
select first_name,last_name,salary
from employees
where salary not between 10000 and 15000  and department_id in (30,100);

/*19Write a query to display the name (first_name, last_name) and hire date for all employees who were 
hired in 1987*/
select first_name,last_name,hire_date
from employees
where year (hire_date) like "1987";

/*20. Write a query to display the first_name of all employees who have both "b" and "c" in their first name*/
select first_name
from employees
where first_name like '%b%' and first_name like '%c%';

/*21. Write a query to display the last name, job, and salary for all employees whose job is that of a 
Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000
*/
select last_name,job_id,salary
from employees
where job_id in ('programmer','shipping clerk') and salary not in (4500,10000,15000);

/*22. Write a query to display the last name of employees whose names have exactly 6 characters*/
select last_name
from employees
where last_name like "length(last_name,1,6)";

/*23. Write a query to display the last name of employees having 'e' as the third character*/
select last_name
from employees
where last_name like '__e%';

/*24. Write a query to get the job_id and related employee's id*/
select job_id,
GROUP_CONCAT(employee_id) as 'employee_Id'
from employees
group by job_id;

/*25. Write a query to update the portion of the phone_number in the employees table, within the phone 
number the substring '124' will be replaced by '999'*/
update employees
set phone_number = 
replace(phone_number,'124','999')
where phone_number like '%124%';

/*26. Write a query to get the details of the employees where the length of the first name greater than or 
equal to 8*/
select *
from employees
where length(first_name)>=8;

/*27. Write a query to append '@example.com' to email field*/
UPDATE employees
set email = 
concat(email,'@example.com');

/*28. Write a query to extract the last 4 character of phone numbers*/
SELECT right(phone_number,4) as 'ph.no'
from employees;

/*29. Write a query to get the last word of the street address*/
select location_id,right(street_address,1)
from locations;

/*30. Write a query to get the locations that have minimum street length*/
select *
from locations
where length(street_address) <= (select min(length(street_address)) from locations);

/*31. Write a query to display the first word from those job titles which contains more than one words*/
select job_title,substr(job_title,1,instr(job_title,'')-1)
from jobs;

/*32. Write a query to display the length of first name for employees where last name contain character 'c' 
after 2nd position*/
select first_name,last_name
from employees
where instr(last_name,'c')>2;

/*33. Write a query that displays the first name and the length of the first name for all employees whose 
name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the 
employees' first names*/
select first_name as "name",length(first_name) as"length"
from employees
where first_name like "j%" or first_name like "m%" or first_name like "a"
order by first_name;

/*34. Write a query to display the first name and salary for all employees. Format the salary to be 10 
characters long, left-padded with the $ symbol. Label the column SA*/
select first_name,
lpad(salary,10,'$') as 'salary'
from employees;

/*35. Write a query to display the first eight characters of the employees' first names and indicates the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary
*/
select left(first_name,8),
repeat('$',floor(salary/1000)) 'salary($)',salary
from employees
order by salary desc;

/**36. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year
*/
select first_name,last_name,employee_id,hire_date
from employees
where position('07'in date_format(hire_date,'%d,%m,%y'))>0;

