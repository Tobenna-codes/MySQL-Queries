CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
 
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

SELECT * FROM employees;

-- Over() without arguments like partition by (it returns that single value for every single role because it's not being partitioned by anything)
SELECT emp_no, department, salary, min(salary) OVER(), max(salary) over() from employees;

SELECT emp_no, department, salary, min(salary) OVER(PARTITION BY department) as 'min. salary by department',
max(salary) over(PARTITION BY department) as 'max. salary by department' 
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    AVG(salary) OVER() AS company_avg
FROM employees;
 
SELECT 
    emp_no, 
    department, 
    salary, 
    COUNT(*) OVER(PARTITION BY department) as dept_count
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    avg(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_avg_salary,
    avg(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS 'row_number',
    rank() OVER(order by salary DESC) AS salary_rank,
    DENSE_RANK() OVER(ORDER BY salary desc) as 'dense_rank'
FROM employees
ORDER BY salary DESC;

SELECT emp_no, department, salary,
	NTILE(4) over(ORDER BY salary DESC) as overall_salary_quartile,
	NTILE(4) over(PARTITION BY department ORDER BY salary DESC) as dept_sal_quartile,
	dense_RANK() over(order by salary desc) as overall_salary_rank,
	dense_rank() over(PARTITION BY department ORDER BY salary desc) as dept_sal_rank
from employees ORDER BY emp_no;

SELECT emp_no, department, salary, 
	FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) as 'first_value',
	LAST_VALUE(emp_no) over(PARTITION BY department ORDER BY salary DESC) as 'last_value',
	NTH_VALUE(emp_no, 4) OVER(PARTITION BY department ORDER BY salary DESC) as fourth_value,
	salary - LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC) as sal_diff_lead,
	salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as sal_diff_lag
from employees;
