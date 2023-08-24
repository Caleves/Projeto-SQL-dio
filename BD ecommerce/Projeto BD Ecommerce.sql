CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CUSTOMER
CREATE TABLE Customer(
	idCustomer INT auto_increment PRIMARY KEY,
    Name VARCHAR(45),
    Address VARCHAR(45),
	CPF CHAR (11) NOT NULL,
    CNPJ VARCHAR(18),
    CONSTRAINT unique_cpf_customer UNIQUE (CPF),
    CONSTRAINT unique_cnpj_customer UNIQUE (CNPJ)
    );

DESC Customer;

-- PRODUCT
CREATE TABLE Product(
	idProduct INT auto_increment PRIMARY KEY,
    Category VARCHAR(50),
    Description VARCHAR(50),
	Value FLOAT
);

DESC Product;

-- PAYMENT
CREATE TABLE Payment(
	idPayment INT auto_increment PRIMARY KEY,
    CustomerPayment INT,
    Card VARCHAR(50),
    Brand VARCHAR(50),
    Number VARCHAR(50),
    CONSTRAINT fk_payment_customer FOREIGN KEY (CustomerPayment) REFERENCES Customer(idCustomer)
);

DESC Payment;

-- DELIVERY
CREATE TABLE Delivery(
	idDelivery INT auto_increment PRIMARY KEY,
    DeliveryStatus BOOL,
    TrackingCode VARCHAR(50),
    DeliveryDate DATE
);

DESC Delivery;

-- ORDER
CREATE TABLE Order(
	idOrder INT auto_increment PRIMARY KEY,
    OrderStatus BOOL DEFAULT FALSE,
    Shipping FLOAT,
    Description VARCHAR(50),
    CONSTRAINT fk_delivery FOREIGN KEY (idOrder) REFERENCES Delivery(idDelivery)
);

DESC Order;

-- INVENTORY
CREATE TABLE Inventory(
	idInventory INT auto_increment PRIMARY KEY,
    Location VARCHAR(50)
);

DESC Inventory;

-- PRODUCTS IN INVENTORY
CREATE TABLE InventoryProduct(
	idProduct INT PRIMARY KEY,
    idInventoryProduct INT,
    Quantity FLOAT,
    CONSTRAINT fk_inventory FOREIGN KEY (idProduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_product_inventory FOREIGN KEY (idInventoryProduct) REFERENCES Inventory(idInventory)
);

DESC InventoryProduct;

-- MAIN SUPPLIER
CREATE TABLE Supplier(
	idSupplier INT auto_increment PRIMARY KEY,
    BusinessName VARCHAR(45),
    CPF CHAR (11) NOT NULL,
    CNPJ VARCHAR(18),
    CONSTRAINT unique_cpf_supplier UNIQUE (CPF),
    CONSTRAINT unique_cnpj_supplier UNIQUE (CNPJ)
);

DESC Supplier;

-- THIRD-PARTY SUPPLIER
CREATE TABLE ThirdParty(
	idThirdParty INT auto_increment PRIMARY KEY,
	BusinessName VARCHAR(50),
    Location VARCHAR(50),
    CPF CHAR (11) NOT NULL,
    CNPJ VARCHAR(18),
    CONSTRAINT unique_cpf_thirdparty UNIQUE (CPF),
    CONSTRAINT unique_cnpj_thirdparty UNIQUE (CNPJ)
);

DESC ThirdParty;

-- PRODUCT ORDER
CREATE TABLE ProductOrder(
	idOrder INT,
    idProduct INT,
    Quantity FLOAT DEFAULT 1,
    CONSTRAINT fk_order FOREIGN KEY (idOrder) REFERENCES ThirdParty(idThirdParty),
    CONSTRAINT fk_product FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

DESC ProductOrder;

-- PRODUCT ORDER TO MAIN SUPPLIER
CREATE TABLE SupplierOrder(
	idSupplierPurchase INT,
    idSupplierOrder INT,
    Quantity FLOAT DEFAULT 1,
    CONSTRAINT fk_supplier_purchase FOREIGN KEY (idSupplierPurchase) REFERENCES Supplier(idSupplier),
    CONSTRAINT fk_supplier_order FOREIGN KEY (idSupplierOrder) REFERENCES Order(idOrder)
);

DESC SupplierOrder;

-- PRODUCTS IN MAIN SUPPLIER INVENTORY 
CREATE TABLE SupplierInventory(
	idSupplierInventory INT,
    idSupplierProduct INT,
    CONSTRAINT fk_supplier_inventory FOREIGN KEY (idSupplierInventory) REFERENCES Supplier(idSupplier),
    CONSTRAINT fk_products_supplier FOREIGN KEY (idSupplierProduct) REFERENCES Product(idProduct)
);

DESC SupplierInventory;

-- PRODUCTS IN THIRD-PARTY SUPPLIER INVENTORY 
CREATE TABLE ThirdPartyInventory(
	idProductsInventory INT,
    idThirdPartyProduct INT,
    CONSTRAINT fk_products_inventory FOREIGN KEY (idProductsInventory) REFERENCES Product(idProduct),
    CONSTRAINT fk_thirdparty_order FOREIGN KEY (idThirdPartyProduct) REFERENCES ThirdParty(idThirdParty)
);

DESC ThirdPartyInventory;

