-- Criando a base de dados
CREATE DATABASE bank;

-- Comando para utilizar a base de dados citada
USE bank;

-- Criando a tabela 'bank_marketing'
CREATE TABLE bank_marketing(
age INT,
job VARCHAR(100),
marital VARCHAR(100),
education VARCHAR(150),
credit_default VARCHAR(20),
housing VARCHAR(20),
loan VARCHAR(20),
contact VARCHAR(20),
month_contact VARCHAR(5),
day_of_week VARCHAR(15),
duration INT,
campaign INT,
pdays INT,
previous INT,
poutcome VARCHAR(30),
emp_var_rate FLOAT,
cons_price_index FLOAT,
cons_conf_index FLOAT,
euribor3m FLOAT,
nr_employed FLOAT,
y VARCHAR(5)
);

-- Carregando as informações do CSV para a tabela 'bank_marketing'
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/banks.csv'
INTO TABLE bank_marketing
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
