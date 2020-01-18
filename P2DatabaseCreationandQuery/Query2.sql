SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    COUNT(CONCAT(e.lastname, ', ', e.firstname)) AS 'Direct report'
FROM
    employees e
        INNER JOIN
    employees m ON m.employeeNumber = e.reportsto
GROUP BY CONCAT(m.lastname, ', ', m.firstname)
ORDER BY COUNT(CONCAT(e.lastname, ', ', e.firstname)) DESC;
