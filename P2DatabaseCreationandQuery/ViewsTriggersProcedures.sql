DELIMITER $$ 
CREATE TRIGGER productCheckData Before insert on products 
for each row 
BEGIN 
  call check_price(new.buyPrice, new.MSRP); 
End$$ 
DELIMITER ; 


CREATE DEFINER=`root`@`localhost` PROCEDURE `check_price`(IN buyPrice decimal(10, 2), MSRP decimal(10, 2)) 
BEGIN 
    if buyPrice < 0 then 
        signal sqlstate '45000' 
 
            set message_text = 'check constraint on products.buyPrice failed'; 
 
    end if; 
 
    if MSRP < 0 then 
 
        signal sqlstate '45001' 
 
            set message_text = 'check constraint on products.MSRP failed'; 
 
    end if; 
 
    if buyPrice < MSRP then 
 
        signal sqlstate '45002' 
 
            set message_text = 'buyPrice value cannot be lower than MSRP'; 
 
    end if; 
 
END  


CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_Employee_1`()
BEGIN
DECLARE exit handler for sqlexception
  BEGIN
    ROLLBACK;
    signal sqlstate '45000'
			set message_text = 'Error - Rollback';
END;

DECLARE exit handler for sqlwarning
 BEGIN
    ROLLBACK;
	signal sqlstate '45001'
			set message_text = 'Warning rollback';
END;
START TRANSACTION;
delete from employees where employeeNumber = 1000;
insert into employees (employeeNumber, firstName, lastName, email, reportsTo, jobTitle) values (1000, 'Allen', 'Richey', 'allen@abc.com', 1002, 'VP Product');
insert into employees (employeeNumber, firstName, lastName, email, reportsTo, jobTitle) values (1001, 'Shravya', NULL, 'allen@abc.com', 1000, 'VP Product');
update employees set lastName = 'Richey' where employeeNumber = 1000;	
COMMIT;
END


CREATE OR REPLACE FORCE VIEW  "CUSTOMER_VIEW" ("CUSTOMERNUMBER", "CUSTOMERNAME", "CREDITLIMIT") AS 
  select customerNumber, customerName, creditLimit
	from customers;


CREATE OR REPLACE TRIGGER "UPDATE_ON_CUSTOMER" 
  INSTEAD OF UPDATE ON Customer_View
  FOR EACH ROW
BEGIN
    Update CUSTOMERS
    set CUSTOMERNAME = :new.CUSTOMERNAME
    where CUSTOMERNUMBER = :old.CUSTOMERNUMBER;
    DBMS_OUTPUT.PUT_LINE('updated');
END;
/


CREATE VIEW ProductsPerOrder AS
    SELECT 
        o.orderNumber,
        p.productName,
        o.customerNumber,
        COUNT(p.productCode) No_of_products,
        o.status,
        oi.quantityOrdered,
        p.productVendor,
        p.MSRP
    FROM
        orders o
            JOIN
        orderitems oi ON o.orderNumber = oi.orderNumber
            JOIN
        products p ON oi.productCode = p.productCode
    GROUP BY oi.productCode; 
