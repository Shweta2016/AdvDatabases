SELECT 
    o.customerNumber,
    customerName,
    COUNT(productName) Product_Count,
    c.country,
    p.productVendor
FROM
    orders o,
    orderitems oi,
    customers c,
    products p
WHERE
    c.customerNumber = o.customerNumber
        AND o.orderNumber = oi.orderNumber
        AND p.productCode = oi.productCode
        AND c.country LIKE '%USA%'
GROUP BY p.productVendor
ORDER BY Product_Count DESC
LIMIT 1;  
