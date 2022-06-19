/*
Таблица DeptTable – таблица департаментов: 
-id – id департамента 
-DeptName – Наименование департамента 
-City – Город в котором располагается департамент 
 
Таблица EmployeeTable – таблица сотрудников: 
-id – id сотрудника 
-idDeptTable - id департамента 
-FIO – ФИО сотрудника 
-salary – зарплата 
-ReceiptDate - Дата приема сотрудника на работу 
 
⦁	Вывести ID и Наименование департаментов в которых работает более 15 сотрудников. 

⦁	Вывести вторую по величине зарплату работников. 

⦁	Вывести ID и ФИО всех сотрудников, у которых зарплата выше чем средняя зарплата всех сотрудников и при этом департамент в котором они работают располагается не в Москве. 

⦁	По каждому сотруднику вывести количество отработанных месяцев на текущую дату.

⦁	Посчитать количество сотрудников по каждому департаменту принятых на работу в 2016 году.
*/



----------1----------------
SELECT dt.id, dt.deptname 
FROM depttable AS dt
INNER JOIN employeetable AS et
ON dt.id = et.iddepttable
GROUP BY dt.id, dt.deptname
HAVING COUNT(et.id) > 15

---------2----------------

SELECT DISTINCT salary 
FROM employeetable
ORDER BY salary DESC
LIMIT 1 OFFSET 1

---------3----------------

SELECT et.id, et.fio, et.salary
FROM employeetable AS et
INNER JOIN depttable AS dt
ON dt.id = et.iddepttable
WHERE et.salary > (
	SELECT AVG(salary)
	FROM employeetable
) AND dt.city <> 'Москва'

---------4----------------

SELECT *, ((DATE_PART('year', DATE(NOW())) - DATE_PART('year', receiptdate)) * 12 +
              (DATE_PART('month', DATE(NOW())) - DATE_PART('month', receiptdate))) AS months
FROM employeetable 

---------5----------------

SELECT dt.id, dt.deptname, COUNT(et.id) AS employees
FROM employeetable AS et
INNER JOIN depttable AS dt 
ON et.iddepttable = dt.id
WHERE DATE_PART('year', et.receiptdate) = 2016
GROUP BY dt.id, dt.deptname
