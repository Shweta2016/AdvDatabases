SELECT 
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS 'Employee Name',
    SUM(ppo.No_of_products) AS 'Total Products'
FROM
    employees e
        LEFT JOIN
    customers c ON c.salesRepEmployeeNumber = e.employeeNumber
        JOIN
    productsperorder ppo ON c.customerNumber = ppo.customerNumber
WHERE
    ppo.productName LIKE '%Ford%'
GROUP BY e.employeeNumber
ORDER BY SUM(ppo.No_of_products) DESC
LIMIT 1; 
