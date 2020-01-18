insert  into customers (customerNumber,customerName, addressLine1,addressLine2,city,state, postalCode,country,salesRepEmployeeNumber,creditLimit) values 
(500,'John Sequal','500, Royale',NULL,'Santa Clara', 'CA','50000','USA',1370,'5000.00');

update orderitems set quantityOrdered = 35
where orderNumber = 10100 and productCode = 'S18_1749';

DELETE FROM payments where paymentDate <'20040101';
