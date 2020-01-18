SELECT 
    COUNT(c.customerNumber) No_of_Customers, c.country
FROM
    customers c
        LEFT JOIN
    orders o ON o.customerNumber = c.customerNumber
        JOIN
    orderitems oi ON o.orderNumber = oi.orderNumber
        JOIN
    products p ON oi.productCode = p.productCode
WHERE
    p.buyPrice > 50
GROUP BY c.country
ORDER BY COUNT(c.customerNumber) DESC;
