
CREATE DATABASE IF NOT EXISTS FerreteriaDB;
USE FerreteriaDB;


-- Tabla de Categorias
CREATE TABLE Categorias (
    ID_Categoria INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);


-- Tabla de Clientes
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(255)
);
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
-- Tabla de Proveedores
CREATE TABLE Proveedores (
    ID_Proveedor INT PRIMARY KEY,
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



-- Inserción de datos en la tabla de Categorias
INSERT INTO Categorias (ID_Categoria, Nombre, Descripcion) VALUES
(1, 'Herramientas', 'Herramientas manuales y eléctricas'),
(2, 'Pinturas', 'Pinturas y accesorios para pintar'),
(3, 'Electricidad', 'Materiales eléctricos y accesorios');

-- Inserción de datos en la tabla de Clientes
INSERT INTO Clientes (ID_Cliente, Nombre, Direccion, Telefono, Email) VALUES
(1, 'Juan Pérez', 'Calle de la Amargura 789', '123-456-789', 'juan.perez@example.com'),
(2, 'Ana Gómez', 'Avenida del Sol 321', '987-654-321', 'ana.gomez@example.com');

-- Inserción de datos en la tabla de Productos
INSERT INTO Productos (ID_Producto, Nombre, Descripcion, Precio, Stock, ID_Categoria) VALUES
(1, 'Martillo', 'Martillo de acero forjado', 120.00, 15, 1),
(2, 'Taladro', 'Taladro eléctrico 500W', 450.50, 8, 1),
(3, 'Pintura blanca 1L', 'Pintura blanca de 1 litro', 150.00, 40, 2);

-- Inserción de datos en la tabla de Proveedores
INSERT INTO Proveedores (ID_Proveedor, Nombre, Direccion, Telefono, Email) VALUES
(1, 'Proveedor 1', 'Calle Falsa 123', '999-888-777', 'contacto@proveedor1.com'),
(2, 'Proveedor 2', 'Avenida Siempreviva 456', '666-555-444', 'contacto@proveedor2.com');

-- Inserción de datos en la tabla de Ventas
INSERT INTO Ventas (ID_Venta, Fecha, Total, ID_Cliente) VALUES
(1, '2023-01-15', 570.50, 1),
(2, '2023-01-17', 150.00, 2);