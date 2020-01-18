SELECT 
    o.customerNumber,
    customerName,
    SUM((priceEach * quantityOrdered)) Total_Price,
    productName
FROM
    orders o,
    orderitems oi,
    customers c,
    products p
WHERE
    c.customerNumber = o.customerNumber
        AND o.orderNumber = oi.orderNumber
        AND p.productCode = oi.productCode
GROUP BY c.customerNumber
ORDER BY Total_Price DESC
LIMIT 1; 
