SELECT 
    o.orderDate, o.orderNumber, c.customerName
FROM
    orders o
        JOIN
    customers c ON c.customerNumber = o.customerNumber
WHERE
    orderDate IN (SELECT 
            MAX(o.orderDate)
        FROM
            orders o
                JOIN
            customers c ON o.customerNumber = c.customerNumber
        WHERE
            o.orderDate BETWEEN CAST('2003-01-01' AS DATE) AND CAST('2003-11-01' AS DATE)
        GROUP BY c.customerName
        ORDER BY c.customerName)
ORDER BY c.customerName , o.orderNumber; 
