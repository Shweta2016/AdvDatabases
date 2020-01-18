SELECT 
    c.customerNumber, c.customerName
FROM
    orders o,
    orderitems oi,
    customers c,
    products p
WHERE
    c.customerNumber = o.customerNumber
        AND o.orderNumber = oi.orderNumber
        AND p.productCode = oi.productCode
        AND p.productVendor LIKE '%Red Start%'
        AND p.quantityInStock < 1000; 
