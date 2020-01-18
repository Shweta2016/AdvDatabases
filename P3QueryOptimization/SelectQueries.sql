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


SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    COUNT(CONCAT(e.lastname, ', ', e.firstname)) AS 'Direct report'
FROM
    employees e
        INNER JOIN
    employees m ON m.employeeNumber = e.reportsto
GROUP BY CONCAT(m.lastname, ', ', m.firstname)
ORDER BY COUNT(CONCAT(e.lastname, ', ', e.firstname)) DESC;

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

