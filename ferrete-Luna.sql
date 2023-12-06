
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


-- Vista 1: Productos por Categoría
CREATE VIEW Vista_ProductosPorCategoria AS
SELECT p.ID_Producto, p.Nombre AS NombreProducto, p.Descripcion, p.Precio, p.Stock, c.Nombre AS NombreCategoria
FROM Productos p
JOIN Categorias c ON p.ID_Categoria = c.ID_Categoria;

-- Vista 2: Ventas con Detalles de Clientes
CREATE VIEW Vista_VentasClientes AS
SELECT v.ID_Venta, v.Fecha, v.Total, c.ID_Cliente, c.Nombre AS NombreCliente, c.Dirección AS DirecciónCliente, c.Teléfono AS TeléfonoCliente, c.Email AS EmailCliente
FROM Ventas v
JOIN Clientes c ON v.ID_Cliente = c.ID_Cliente;

-- Vista 3: Proveedores y Productos
-- Esta vista muestra la relación entre los productos y sus proveedores (asumiendo que hay una tabla de relación que no se menciona en el ejemplo).
CREATE VIEW Vista_ProveedoresProductos AS
SELECT pr.ID_Proveedor, pr.Nombre AS NombreProveedor, pr.Dirección, pr.Teléfono, pr.Email, p.Nombre AS NombreProducto, p.Descripción
FROM Proveedores pr
JOIN Productos_Proveedores pp ON pr.ID_Proveedor = pp.ID_Proveedor
JOIN Productos p ON pp.ID_Producto = p.ID_Producto;

-- Vista 4: Productos con Stock Bajo
-- Esta vista muestra los productos con un stock menor a un umbral específico.
CREATE VIEW Vista_ProductosStockBajo AS
SELECT ID_Producto, Nombre, Descripción, Precio, Stock
FROM Productos
WHERE Stock < 10;

-- Vista 5: Ventas Totales por Fecha
CREATE VIEW Vista_VentasTotalesPorFecha AS
SELECT Fecha, SUM(Total) AS VentasTotales
FROM Ventas
GROUP BY Fecha;

DELIMITER $$

CREATE FUNCTION valor_inventario_categoria(categoria_id INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE valor_total DECIMAL(10,2) DEFAULT 0.0;
    SELECT SUM(Precio * Stock) INTO valor_total
    FROM Productos
    WHERE ID_Categoria = categoria_id;
    RETURN valor_total;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION obtener_email_cliente(cliente_id INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE correo_cliente VARCHAR(255);
    SELECT Email INTO correo_cliente
    FROM Clientes
    WHERE ID_Cliente = cliente_id;
    RETURN correo_cliente;
END$$

DELIMITER ;


SELECT valor_inventario_categoria(1);

SELECT obtener_email_cliente(1);

-- Stored Procedure 1: OrdenarRegistrosDeTabla
-- Este SP permite ordenar los registros de una tabla específica por un campo y orden especificado.
DELIMITER //
CREATE PROCEDURE OrdenarRegistrosDeTabla(IN nombreCampo VARCHAR(255), IN tipoOrden VARCHAR(4))
BEGIN
    IF tipoOrden = 'ASC' OR tipoOrden = 'DESC' THEN
        SET @tSQL = CONCAT('SELECT * FROM Productos ORDER BY ', nombreCampo, ' ', tipoOrden, ';');
        PREPARE stmt FROM @tSQL;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    ELSE
        SELECT 'Error: El tipo de orden debe ser ASC o DESC.';
    END IF;
END //
DELIMITER ;

-- Ejemplo de uso:
-- CALL OrdenarRegistrosDeTabla('Precio', 'ASC');
-- Este ejemplo ordenará todos los productos por el campo 'Precio' de forma ascendente.

-- Stored Procedure 2: InsertarOEliminarClienteProducto
-- Este SP permite insertar un nuevo cliente o eliminar un producto específico.
DELIMITER //
CREATE PROCEDURE InsertarOEliminarClienteProducto(IN accion VARCHAR(8), IN id INT, IN nombre VARCHAR(255), IN direccion VARCHAR(255), IN telefono VARCHAR(20), IN email VARCHAR(255))
BEGIN
    IF accion = 'INSERTAR' THEN
        INSERT INTO Clientes (ID_Cliente, Nombre, Direccion, Telefono, Email) VALUES (id, nombre, direccion, telefono, email);
    ELSEIF accion = 'ELIMINAR' THEN
        DELETE FROM Productos WHERE ID_Producto = id;
    ELSE
        SELECT 'Error: La acción debe ser INSERTAR o ELIMINAR.';
    END IF;
END //
DELIMITER ;

-- Ejemplo de uso:
-- CALL InsertarOEliminarClienteProducto('INSERTAR', NULL, 'Laura Martínez', 'Calle del Bosque 123', '321-654-987', 'laura.mtz@example.com');
-- Este ejemplo insertará un nuevo cliente con los datos proporcionados.

-- CALL InsertarOEliminarClienteProducto('ELIMINAR', 3, '', '', '', '');
-- Este ejemplo eliminará el producto con el ID_Producto 3.

