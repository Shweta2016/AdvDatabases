SELECT 
    c.customerNumber,
    c.customerName,
    COUNT(o.orderNumber) OrderCount,
    o.status
FROM
    customers c
        LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName , o.status
HAVING OrderCount > 2; 
