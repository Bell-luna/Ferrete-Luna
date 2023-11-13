
CREATE DATABASE IF NOT EXISTS FerreteriaDB;
USE FerreteriaDB;

-- Tabla de Productos
CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT,
    Precio DECIMAL,
    Stock INT,
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria)
);

-- Tabla de Categorias
CREATE TABLE Categorias (
    ID_Categoria INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);

-- Tabla de Proveedores
CREATE TABLE Proveedores (
    ID_Proveedor INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255)
);

-- Tabla de Clientes
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255)
);

-- Tabla de Ventas
CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY,
    Fecha DATE,
    Total DECIMAL,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);
