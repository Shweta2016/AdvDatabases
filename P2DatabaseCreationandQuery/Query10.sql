SELECT 
    e.firstName,
    COUNT(p.productCode) AS 'Number of products sold'
FROM
    employees e
        LEFT JOIN
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
        LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
        LEFT JOIN
    orderitems oi ON o.orderNumber = oi.orderNumber
        LEFT JOIN
    products p ON oi.productCode = p.productCode
WHERE
    e.jobTitle = 'Sales Rep'
GROUP BY e.employeeNumber
ORDER BY COUNT(p.productCode);
