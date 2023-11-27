# Base de Datos para Ferretería

La base de datos está diseñada para gestionar la información de una ferretería. Contiene tablas que registran detalles sobre los productos disponibles, las categorías a las que pertenecen, los proveedores que suministran los productos, los clientes que realizan compras y las ventas realizadas por la ferretería. La relación entre estas tablas permite un seguimiento eficiente de los productos, las transacciones y la gestión de la información relacionada con proveedores y clientes.

## Estructura de la Base de Datos

1. **Productos:**
   - Registro de productos disponibles en la ferretería.
   - Detalles como nombre, descripción, precio, stock y la categoría a la que pertenecen.

2. **Categorías:**
   - Categorización de productos para facilitar su búsqueda y organización.
   - Detalles como nombre y descripción de la categoría.

3. **Proveedores:**
   - Información sobre los proveedores que abastecen a la ferretería.
   - Detalles como nombre, dirección, teléfono y correo electrónico del proveedor.

4. **Clientes:**
   - Almacena datos de los clientes que realizan compras en la ferretería.
   - Detalles como nombre completo, dirección, teléfono y correo electrónico del cliente.

5. **Ventas:**
   - Registra las ventas realizadas por la ferretería.
   - Detalles como la fecha de la venta, el monto total y el cliente asociado.


## Estructura de la Base de Datos

### Productos:
- Registro de productos disponibles en la ferretería.
- Detalles como nombre, descripción, precio, stock y la categoría a la que pertenecen.

### Categorías:
- Categorización de productos para facilitar su búsqueda y organización.
- Detalles como nombre y descripción de la categoría.

### Proveedores:
- Información sobre los proveedores que abastecen a la ferretería.
- Detalles como nombre, dirección, teléfono y correo electrónico del proveedor.

### Clientes:
- Almacena datos de los clientes que realizan compras en la ferretería.
- Detalles como nombre completo, dirección, teléfono y correo electrónico del cliente.

### Ventas:
- Registra las ventas realizadas por la ferretería.
- Detalles como la fecha de la venta, el monto total y el cliente asociado.

## Vistas de la Base de Datos

### Vista_ProductosPorCategoria:
- Muestra la relación entre los productos y sus categorías correspondientes.

### Vista_VentasClientes:
- Presenta las ventas realizadas junto con los detalles completos de los clientes asociados a cada venta.

### Vista_ProveedoresProductos:
- (Nota: La vista asume la existencia de una tabla de relación entre productos y proveedores que no ha sido definida en el script proporcionado.)

### Vista_ProductosStockBajo:
- Lista los productos con un nivel de stock por debajo de un umbral específico, lo que puede ser crucial para la gestión de inventario.

### Vista_VentasTotalesPorFecha:
- Muestra el total de ingresos generados por las ventas para cada fecha, lo cual es útil para reportes de ingresos diarios.
