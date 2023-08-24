CREATE DATABASE IF NOT EXISTS Workshop;
USE Workshop;

DROP DATABASE Workshop;

-- VEHICLE
CREATE TABLE Vehicle (
    idVehicle INT auto_increment PRIMARY KEY,
    idRevision INT,
    Plate CHAR(9) NOT NULL,
    CONSTRAINT plate_idVehicle UNIQUE (idVehicle, Plate)
);

ALTER TABLE Vehicle ADD CONSTRAINT fk_mechanical_eqp FOREIGN KEY (idVehicle) REFERENCES MechanicalEquipment(idMechanicalEquipment),
ADD CONSTRAINT fk_repair FOREIGN KEY (idVehicle) REFERENCES Repair(idRepair),
ADD CONSTRAINT fk_revision FOREIGN KEY (idRevision) REFERENCES Revision(idRevision);

DESC Vehicle;

-- CUSTOMERS
CREATE TABLE Customers (
    idCustomers INT auto_increment PRIMARY KEY,
    idVehicle INT,
    CONSTRAINT fk_vehicle FOREIGN KEY (idVehicle) REFERENCES Vehicle(idVehicle)
);

DESC Customers;

-- INDIVIDUAL PERSON
CREATE TABLE IndividualPerson (
    idIndividualPerson INT auto_increment PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(50),
    Contact CHAR(12)
);

ALTER TABLE IndividualPerson ADD CONSTRAINT unique_cpf_IndividualPerson UNIQUE (CPF);

ALTER TABLE IndividualPerson ADD CONSTRAINT fk_idCustomers_individual FOREIGN KEY (idIndividualPerson) REFERENCES Customers(idCustomers),
ADD CONSTRAINT fk_customer_individual FOREIGN KEY (idCustomerIndividual) REFERENCES Customers(idCustomers),
ADD CONSTRAINT fk_vehicle_individual FOREIGN KEY (idIndividualPerson) REFERENCES Vehicle(idVehicle);

DESC IndividualPerson;

-- LEGAL ENTITY
CREATE TABLE LegalEntity (
    idLegalEntity INT auto_increment PRIMARY KEY,
    BusinessName VARCHAR(50) NOT NULL,
    CNPJ CHAR(18) NOT NULL,
    Address VARCHAR(50),
    Contact CHAR(12),
    CONSTRAINT unique_cnpj_LegalEntity UNIQUE (CNPJ)
);

ALTER TABLE LegalEntity ADD CONSTRAINT fk_customers_legal FOREIGN KEY (idLegalEntity) REFERENCES Customers(idCustomers),
ADD CONSTRAINT fk_vehicle_legal FOREIGN KEY (idLegalEntity) REFERENCES Vehicle(idVehicle);

DESC LegalEntity;

-- REPAIR
CREATE TABLE Repair (
    idRepair INT auto_increment PRIMARY KEY,
    Description VARCHAR(50) NOT NULL
);

DESC Repair;

-- REVISION
CREATE TABLE Revision (
    idRevision INT auto_increment PRIMARY KEY,
    Description VARCHAR(50) NOT NULL
);

DESC Revision;

-- MECHANIC
CREATE TABLE Mechanic (
    idMechanic INT auto_increment PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50) NOT NULL
);

DESC Mechanic;

-- MECHANICAL EQUIPMENT TEAM
CREATE TABLE MechanicalEquipment (
    idMechanicalEquipment INT auto_increment PRIMARY KEY
);

ALTER TABLE MechanicalEquipment ADD CONSTRAINT fk_Mechanic FOREIGN KEY (idMechanicalEquipment) REFERENCES Mechanic(idMechanic);
ALTER TABLE WorkOrderService ADD CONSTRAINT fk_WorkOrderService FOREIGN KEY (idWorkOrderService) REFERENCES WorkOrderService(idWorkOrderService);

DESC MechanicalEquipment;

-- WORK ORDER SERVICE
CREATE TABLE WorkOrderService (
    idWorkOrderService INT auto_increment PRIMARY KEY,
    EmissionDate DATE,
    ServiceValue FLOAT NOT NULL,
    PartValue FLOAT NOT NULL,
    TotalValue FLOAT NOT NULL,
    Status ENUM('AWAITING', 'IN PROGRESS', 'COMPLETED', 'CANCELLED'),
    CompletionDate DATE
);

SELECT * FROM WorkOrderService ORDER BY EmissionDate;
SELECT * FROM WorkOrderService ORDER BY TotalValue;
DESC WorkOrderService;

-- PRICE REFERENCE
CREATE TABLE PriceReference (
    idPriceReference INT auto_increment PRIMARY KEY,
    CONSTRAINT fk_price_reference FOREIGN KEY (idPriceReference) REFERENCES WorkOrderService(idWorkOrderService)
);

DESC PriceReference;

-- CUSTOMER AUTHORIZATION
CREATE TABLE Authorization (
    idAuthorization INT auto_increment PRIMARY KEY,
    Authorized BOOL DEFAULT FALSE,
    CONSTRAINT fk_authorization_customer FOREIGN KEY (idAuthorization) REFERENCES Customers(idCustomers),
    CONSTRAINT fk_authorization_vehicle FOREIGN KEY (idAuthorization) REFERENCES Vehicle(idVehicle),
    CONSTRAINT fk_authorization_workOrderService FOREIGN KEY (idAuthorization) REFERENCES WorkOrderService(idWorkOrderService)
);

DESC Authorization;

-- PARTS
CREATE TABLE Parts (
    idParts INT auto_increment PRIMARY KEY,
    Description VARCHAR(50),
    Value FLOAT NOT NULL
);

DESC Parts;

-- WORK ORDER PARTS
CREATE TABLE WorkOrderParts (
    idWorkOrderParts INT auto_increment PRIMARY KEY,
    CONSTRAINT fk_parts FOREIGN KEY (idWorkOrderParts) REFERENCES Parts(idParts),
    CONSTRAINT fk_workOrder_parts FOREIGN KEY (idWorkOrderParts) REFERENCES WorkOrderService(idWorkOrderService)
);

DESC WorkOrderParts;

-- SERVICES
CREATE TABLE Services (
    idServices INT auto_increment PRIMARY KEY,
    Description VARCHAR(50),
    Value FLOAT NOT NULL
);

DESC Services;

-- WORK ORDER SERVICE
CREATE TABLE WorkOrderService (
    idWorkOrderService INT auto_increment PRIMARY KEY,
    CONSTRAINT fk_services FOREIGN KEY (idWorkOrderService) REFERENCES Services(idServices),
    CONSTRAINT fk_workOrder_services FOREIGN KEY (idWorkOrderService) REFERENCES WorkOrderService(idWorkOrderService)
);

DESC WorkOrderService;
