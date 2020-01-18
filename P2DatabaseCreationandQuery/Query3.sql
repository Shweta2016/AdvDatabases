SELECT 
    p.productName, COUNT(p.productCode) Total_Products_Sold
FROM
    orders o
        JOIN
    orderitems oi ON o.orderNumber = oi.orderNumber
        JOIN
    products p ON oi.productCode = p.productCode
GROUP BY oi.productCode
HAVING COUNT(p.productCode) > 25
ORDER BY Total_Products_Sold; 
