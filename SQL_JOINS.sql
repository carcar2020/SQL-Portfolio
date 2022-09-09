

-- Examples of types of join using Vendors and Invoices data.
-- Types of joins in here include (INNER JOIN, LEFT JOIN, RIGHT JOIN AND FULL OUTER JOIN).

-- Looking at data from Invoices and Vendors table
-- INNER JOIN
SELECT * FROM Invoices 
INNER JOIN Vendors 
ON Invoices.VendorID = Vendors.VendorID;


-- Looking at data where the InvoiceID is greater then or equal to 100.
-- LEFT JOIN
SELECT * FROM Invoices 
LEFT JOIN Vendors 
ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceID >= 100;


-- Looking at InvoiceID's that are greater then or equal to 100 and VendorID's that are greater then 50,
-- as well as Concatenating the First and Last name
-- RIGHT JOIN
SELECT CONCAT(VendorContactFName,' ', VendorContactLName) AS FullName, Vendors.VendorID, Invoices.InvoiceID  FROM Invoices 
RIGHT JOIN Vendors 
ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceID >= 100 AND Vendors.VendorID >50
ORDER BY VendorID;


-- Looking at VendorID's between 1-10 and Vendors with a DefaultTermsID of 3 only
-- FULL OUTER JOIN
SELECT Vendors.VendorID, Vendors.DefaultTermsID FROM Invoices 
FULL OUTER JOIN Vendors 
ON Invoices.VendorID = Vendors.VendorID
WHERE (Vendors.VendorID BETWEEN 1 AND 10) AND Vendors.DefaultTermsID = 3;
