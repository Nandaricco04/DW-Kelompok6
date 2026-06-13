-- buat database dw_superstore
CREATE DATABASE dw_superstore;

-- dimcustomer
CREATE TABLE dimcustomer (
    id_customer INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

-- dimproduct
CREATE TABLE dimproduct (
    id_product INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(50),
    product_name VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);

-- dimregion
CREATE TABLE dimregion (
    id_region INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50)
);

-- dimtime
CREATE TABLE dimtime (
    id_time INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    day INT,
    month INT,
    quarter INT,
    year INT
);

-- factsales
CREATE TABLE factsales (
    id_fact_sales INT AUTO_INCREMENT PRIMARY KEY,
    id_customer INT,
    id_product INT,
    id_region INT,
    id_time INT,
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2),

    FOREIGN KEY (id_customer) REFERENCES dimcustomer(id_customer),
    FOREIGN KEY (id_product) REFERENCES dimproduct(id_product),
    FOREIGN KEY (id_region) REFERENCES dimregion(id_region),
    FOREIGN KEY (id_time) REFERENCES dimtime(id_time)
);