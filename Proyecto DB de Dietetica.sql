-- RODRIGUEZ EMILIANO FEDERICO
# ESTE PROYECTO ESTA PENSADO PARA CREAR LA BASE DE DATOS DE UNA DIETETICA, DONDE SE MANEJAN LISTADOS DE PRODUCTOS, CLIENTES, EMPLEADOS, PROVEEDORES, VENTAS, ENTRE OTROS.

########################################################
-- CREACION DE LA BASE DE DATOS
CREATE DATABASE DIETETICA;

########################################################
-- CREACION DE LAS TABLAS
USE DIETETICA;

CREATE TABLE IF NOT EXISTS DIETETICA.tipo_responsable (
	id INT AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS DIETETICA.telefono (
	id INT AUTO_INCREMENT,
	telefono VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS DIETETICA.email (
	id INT AUTO_INCREMENT,
	email VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS DIETETICA.domicilio (
	id INT AUTO_INCREMENT,
	domicilio VARCHAR(50) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS DIETETICA.be_life (
	id INT AUTO_INCREMENT,
	CUIT VARCHAR(30) NOT NULL,
	razon_social VARCHAR(120) NOT NULL,
	id_tipo_responsable INT NOT NULL,
	id_domicilio INT NOT NULL,
	id_telefono INT NOT NULL,
	id_email INT NOT NULL,
	PRIMARY KEY (id),
    CONSTRAINT fk_be_life_tipo_responsable FOREIGN KEY (id_tipo_responsable) REFERENCES tipo_responsable (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_be_life_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_be_life_telefono FOREIGN KEY (id_telefono) REFERENCES telefono (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_be_life_email FOREIGN KEY (id_email) REFERENCES email (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.clientes (
	id INT AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
	apellido VARCHAR(30) NOT NULL,
	dni VARCHAR(14) NOT NULL,
	id_domicilio INT NOT NULL,
	id_telefono INT NOT NULL,
	id_email INT NOT NULL,
	PRIMARY KEY (id),
    INDEX nombre (nombre, apellido),
	CONSTRAINT fk_clientes_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_clientes_telefono FOREIGN KEY (id_telefono) REFERENCES telefono (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_clientes_email FOREIGN KEY (id_email) REFERENCES email (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.empleados (
	id INT AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
	apellido VARCHAR(30) NOT NULL,
	dni VARCHAR(14) NOT NULL,
	id_domicilio INT NOT NULL,
	id_telefono INT NOT NULL,
	id_email INT NOT NULL,
	PRIMARY KEY (id),
    INDEX nombre (nombre, apellido, dni),
	CONSTRAINT fk_empleados_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_empleados_telefono FOREIGN KEY (id_telefono) REFERENCES telefono (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_empleados_email FOREIGN KEY (id_email) REFERENCES email (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.categoria_articulos (
	id INT AUTO_INCREMENT,
    categoria VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (id),
    INDEX categoria (categoria)
    );

CREATE TABLE IF NOT EXISTS DIETETICA.marca_articulos (
	id INT AUTO_INCREMENT,
    marca VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    INDEX marca (marca)
    );

CREATE TABLE IF NOT EXISTS DIETETICA.articulos (
	id INT AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    id_categoria_articulos INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    id_marca_articulos INT DEFAULT NULL,
    precio DECIMAL(11,2) NOT NULL,
    unidad DECIMAL(11,2) NOT NULL,
    img VARCHAR(500) DEFAULT NULL,
    descripcion VARCHAR(150) NOT NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_id_categoria_articulos FOREIGN KEY (id_categoria_articulos) REFERENCES categoria_articulos (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_id_marca_articulos FOREIGN KEY (id_marca_articulos) REFERENCES marca_articulos (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX nombre (nombre)
);

CREATE TABLE IF NOT EXISTS DIETETICA.proveedores (
	id INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
	CUIT VARCHAR(30) NOT NULL,
	razon_social VARCHAR(120) NOT NULL,
	id_tipo_responsable INT NOT NULL,
	id_domicilio INT NOT NULL,
	id_telefono INT NOT NULL,
	id_email INT NOT NULL,
	id_marca_proveedores INT NOT NULL,
	PRIMARY KEY (id),
    CONSTRAINT fk_proveedores_tipo_responsable FOREIGN KEY (id_tipo_responsable) REFERENCES tipo_responsable (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_id_marca_proveedores FOREIGN KEY (id_marca_proveedores) REFERENCES marca_articulos (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_proveedores_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_proveedores_telefono FOREIGN KEY (id_telefono) REFERENCES telefono (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_proveedores_email FOREIGN KEY (id_email) REFERENCES email (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	INDEX nombre (nombre, apellido, CUIT)
);
CREATE TABLE IF NOT EXISTS DIETETICA.stock (
	id INT AUTO_INCREMENT,
    id_articulo INT NOT NULL,
    stock INT NOT NULL,
    minimo INT DEFAULT 5,
    ideal INT DEFAULT 10,
    id_proveedor INT DEFAULT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_articulo_stock FOREIGN KEY (id_articulo) REFERENCES articulos (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedores (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.pedido_cliente (
	id INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_articulos_cliente INT NOT NULL,
    cantidad DECIMAL(11,2) NOT NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_articulo_pedido_cliente FOREIGN KEY (id_articulos_cliente) REFERENCES articulos (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.facturacion (
	id INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_be_life INT DEFAULT 1,
    subtotal DECIMAL(11,2) NULL,
    iva DECIMAL(11,2) NULL,
    total DECIMAL(11,2) NULL,
    fecha_hora DATETIME NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_cliente_facturacion FOREIGN KEY (id_cliente) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_be_life_facturacion FOREIGN KEY (id_be_life) REFERENCES be_life (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.productos_facturados (
	id INT AUTO_INCREMENT,
    id_factura INT NOT NULL,
    id_articulo INT NOT NULL,
    cantidad INT DEFAULT 1,
    precio DECIMAL(11,2) DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT fk_venta_factura FOREIGN KEY (id_factura) REFERENCES facturacion (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_venta_articulo FOREIGN KEY (id_articulo) REFERENCES articulos (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.sueldos (
	id INT AUTO_INCREMENT,
    id_be_life INT NOT NULL,
    id_empleado INT NOT NULL,
    inicio_periodo DATE NOT NULL,
    fin_periodo DATE NOT NULL,
    total DECIMAL (11,2) NOT NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_be_life FOREIGN KEY (id_be_life) REFERENCES be_life (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES empleados (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

########################################################
-- TABLAS COMPLEMENTARIAS

CREATE TABLE IF NOT EXISTS DIETETICA.log_nuevos_clientes (
	id INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_agregado DATETIME NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_cliente_nuevo FOREIGN KEY (id_cliente) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.log_actualizacion_clientes (
	id INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_modificacion DATETIME NOT NULL,
    domicilio_nuevo INT NOT NULL,
    domicilio_viejo INT NOT NULL,
	telefono_nuevo INT DEFAULT NULL,
	telefono_viejo INT DEFAULT NULL,
	email_nuevo VARCHAR(120) NOT NULL,
	email_viejo VARCHAR(120) NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_id_cliente_actualizado FOREIGN KEY (id_cliente) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.log_nuevos_sueldos (
	id INT AUTO_INCREMENT,
    id_sueldo INT NOT NULL,
    fecha_generado DATETIME NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
	CONSTRAINT fk_sueldo_nuevo FOREIGN KEY (id_sueldo) REFERENCES sueldos (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS DIETETICA.log_facturacion (
	id INT AUTO_INCREMENT,
    id_factura INT NOT NULL,
    total DECIMAL(11,2),
    iva DECIMAL(11,2),
    fecha DATE NOT NULL,
    usuario VARCHAR(100),
    PRIMARY KEY (id),
    CONSTRAINT fk_factura FOREIGN KEY (id_factura) REFERENCES facturacion (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

########################################################
-- CREACION DE TRIGGERS
# Trigger para registrar cada nuevo cliente
CREATE TRIGGER tr_nuevo_cliente
AFTER INSERT ON clientes
FOR EACH ROW
	INSERT INTO log_nuevos_clientes (id_cliente, fecha_agregado, usuario)
	VALUES (NEW.id, CURDATE(), USER());

# Trigger para registrar cada actualizacion de datos de los clientes
CREATE TRIGGER tr_actualizacion_clientes
AFTER UPDATE ON clientes
FOR EACH ROW
	INSERT INTO log_actualizacion_clientes (id_cliente, fecha_modificacion, domicilio_nuevo, domicilio_viejo, telefono_nuevo, telefono_viejo, email_nuevo, email_viejo, usuario)
	VALUES (OLD.id, CURDATE(), NEW.id_domicilio, OLD.id_domicilio, NEW.id_telefono, OLD.id_telefono, NEW.id_email, OLD.id_email, USER());
    
# Trigger para registrar cada nuevo sueldo
CREATE TRIGGER tr_nuevo_sueldo
AFTER INSERT ON sueldos
FOR EACH ROW
	INSERT INTO log_nuevos_sueldos (id_sueldo, fecha_generado, usuario)
	VALUES (NEW.id, CURDATE(), USER());
    
# Trigger para auditar cada monto facturado
CREATE TRIGGER tr_registro_facturacion
AFTER UPDATE ON facturacion
FOR EACH ROW
	INSERT INTO log_facturacion (id_factura, total, iva, fecha, usuario)
	VALUES (OLD.id, NEW.total, NEW.iva, CURDATE(), USER());
    
   ########################################################
-- CREACION DE FUNCIONES

# Funcion para calcular el impuesto discriminado de cualquier monto.
DELIMITER $$

CREATE FUNCTION calcular_iva(monto DECIMAL(11,2))
RETURNS DECIMAL(11,2)
NO SQL
BEGIN
	DECLARE resultado DECIMAL(11,2);
    DECLARE impuesto DECIMAL(11,2);
    SET impuesto = 00.21;
    SET resultado = monto * impuesto;
    RETURN resultado;
END$$

# Funcion para calcular el precio de venta total con IVA incluido, usando la funcion "calcular_iva"
CREATE FUNCTION calcular_total(monto DECIMAL(11,2))
RETURNS DECIMAL(11,2)
NO SQL
BEGIN
	DECLARE resultado DECIMAL(11,2);
    SET resultado = monto + calcular_iva(monto);
    RETURN resultado;
END$$

DELIMITER ;

########################################################
-- CREACION DE STORE PROCEDURE

# Stored Procedure para agregar productos a una tabla temporal de una venta para un cliente
DELIMITER $$

CREATE PROCEDURE sp_pedido_cliente (IN in_id_cliente INT, IN in_id_articulos_cliente INT, IN in_cantidad INT)
BEGIN	
	IF in_id_cliente <= 0 OR in_id_articulos_cliente <= 0 OR in_cantidad <= 0 THEN
		SIGNAL SQLSTATE '45054'
		SET MESSAGE_TEXT = 'Todos los campos deben ser completados';
	ELSE
		INSERT INTO pedido_cliente (id_cliente, id_articulos_cliente, cantidad)
		VALUES (in_id_cliente, in_id_articulos_cliente, in_cantidad);
	END IF;
END$$

# Stored Procedure para crear una factura y finalizar una venta
CREATE PROCEDURE sp_generar_factura(IN in_id_cliente INT, IN in_id_comercio INT)
BEGIN
	DECLARE let_id_factura INT DEFAULT 0;
	DECLARE subtotal, iva, total DECIMAL(11,2);
    DECLARE RB BOOL DEFAULT FALSE; -- ROLLBACK
    DECLARE MSG TEXT DEFAULT 'ERROR DESC.';
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET RB := TRUE; -- SETEAMOS UN NUEVO VALOR EN LA VARIABLE CON " := "SIN QUE SE ACTIVE LA VAR.
    
	IF in_id_cliente <= 0 THEN
		SIGNAL SQLSTATE '45054'
		SET MESSAGE_TEXT = 'Todos los campos deben ser completados';
	ELSE
		START TRANSACTION;
        
			INSERT INTO facturacion
			VALUES (NULL, in_id_cliente, in_id_comercio, NULL, NULL, NULL, NOW());
			
			SET @let_id_factura = LAST_INSERT_ID();
            
            IF @let_id_factura = 0 THEN
				SET RB := TRUE;
                SET MSG := 'NO SE PUEDE GENERAR UNA NUEVA FACTURA';
			END IF;
			
			INSERT INTO productos_facturados (id_factura, id_articulo, cantidad, precio)
			SELECT
				@let_id_factura,
				pedido_cliente.id_articulos_cliente,
				pedido_cliente.cantidad,
				articulos.precio
			FROM pedido_cliente
			JOIN articulos ON pedido_cliente.id_articulos_cliente = articulos.id
			WHERE pedido_cliente.id_cliente = in_id_cliente;
			
			DELETE FROM pedido_cliente WHERE id_cliente = in_id_cliente;
			
			# CTE (Common Table Expression) es una FUNCION VENTANA
			WITH tabla_temporal_1 AS (
				SELECT
					id_factura,
					SUM(cantidad * precio) AS suma_total
				FROM DIETETICA.productos_facturados
				WHERE id_factura = @let_id_factura
				GROUP BY id_factura
			)
			
			SELECT suma_total
			INTO @subtotal
			FROM tabla_temporal_1;
            
            IF @subtotal = 0 THEN
				SET RB := TRUE;
				SET MSG := 'EL TOTAL A FACTURAR ES DE $00.00';
			END IF;
			
			UPDATE facturacion
			SET subtotal = @subtotal, iva = calcular_iva(@subtotal), total = calcular_total(@subtotal)
			WHERE id = @let_id_factura;
            
            IF RB THEN
				ROLLBACK;
                SELECT CONCAT('ERROR: ', MSG) AS 'ERROR';
			ELSE
				COMMIT;
			END IF;
	END IF;
END$$

# Stored Procedure para cargar un nuevo cliente a la base de datos
CREATE PROCEDURE sp_nuevo_cliente (IN in_nombre VARCHAR(30), IN in_apellido VARCHAR(30), IN in_dni VARCHAR(14), IN in_domicilio VARCHAR(30), IN in_telefono VARCHAR(30), IN in_email VARCHAR(30))
BEGIN
	DECLARE let_id_domicilio INT DEFAULT 0;
	DECLARE let_id_telefono INT DEFAULT 0;
	DECLARE let_id_email INT DEFAULT 0;

	IF in_nombre = NULL OR in_apellido = NULL OR in_dni = NULL OR in_domicilio = NULL OR in_telefono = NULL OR in_email = NULL THEN
		SIGNAL SQLSTATE '45054'
		SET MESSAGE_TEXT = 'Todos los campos deben ser completados correctamente';
	ELSE
            INSERT INTO domicilio (domicilio)
        VALUES (in_domicilio);
			SET @let_id_domicilio = LAST_INSERT_ID();
        
        INSERT INTO telefono (telefono)
        VALUES (in_telefono);
        	SET @let_id_telefono = LAST_INSERT_ID();
        
        INSERT INTO email (email)
        VALUES (in_email);
        	SET @let_id_email = LAST_INSERT_ID();
        
		INSERT INTO clientes (nombre, apellido, dni, id_domicilio, id_telefono, id_email)
        VALUES (in_nombre, in_apellido, in_dni,@let_id_domicilio, @let_id_telefono, @let_id_email);
                
	END IF;
END$$

DELIMITER ;
  
########################################################
-- CREACION DE VISTAS

# VISTA "DATOS_LOCAL_VW" MUESTRA TODOS LOS DATOS DEL LOCAL "BE LIFE"
CREATE VIEW DATOS_LOCAL_VW AS (
	SELECT  be_life.razon_social,
			tipo_responsable.tipo,
            be_life.CUIT,
            domicilio.domicilio,
            telefono.telefono,
            email.email
	FROM dietetica.be_life
    JOIN dietetica.tipo_responsable ON be_life.id_tipo_responsable = tipo_responsable.id
    JOIN dietetica.domicilio ON be_life.id_domicilio = domicilio.id
    JOIN dietetica.telefono ON be_life.id_telefono = telefono.id
    JOIN dietetica.email ON be_life.id_email = email.id
);

# VISTA "LISTA_DE_EMPLEADOS_VW" MUESTRA TODOS LOS EMPLEADOS Y SUS DATOS REGISTRADOS EN NUESTRA DB 
CREATE VIEW LISTA_DE_EMPLEADOS_VW AS (
	SELECT  empleados.apellido,
			empleados.nombre,
            empleados.dni,
            domicilio.domicilio,
            telefono.telefono,
            email.email
    FROM dietetica.empleados
    JOIN dietetica.domicilio ON empleados.id_domicilio = domicilio.id
    JOIN dietetica.telefono ON empleados.id_telefono = telefono.id
    JOIN dietetica.email ON empleados.id_email = email.id
);

# VISTA "PROVEEDORES_MARCAS_VW" NOS AYUDA A VER QUE MARCA VENDE CADA PROVEEDOR
CREATE VIEW PROVEEDORES_MARCAS_VW AS (
	SELECT 	proveedores.nombre,
            proveedores.apellido,
            proveedores.razon_social,
            marca_articulos.marca
	FROM dietetica.proveedores
    JOIN dietetica.marca_articulos ON proveedores.id_marca_proveedores = marca_articulos.id
);


# VISTA "ARTICULOS_COMPLETOS_VW" PODEMOS VER TODOS LOS ARTICULOS DETALLANDO SU CATEGORIA Y SU MARCA
CREATE VIEW ARTICULOS_COMPLETOS_VW AS (
	SELECT articulos.nombre,
			categoria_articulos.categoria,
            marca_articulos.marca,
            articulos.precio,
            articulos.tipo
    FROM dietetica.articulos
    JOIN dietetica.categoria_articulos ON articulos.id_categoria_articulos = categoria_articulos.id
    JOIN dietetica.marca_articulos ON articulos.id_marca_articulos = marca_articulos.id
);

CREATE VIEW CONTROL_DE_STOCK_VW AS (
	SELECT  ARTICULOS.NOMBRE,
			STOCK.STOCK
	FROM DIETETICA.STOCK
    JOIN DIETETICA.ARTICULOS ON STOCK.ID_ARTICULO = ARTICULOS.ID
);


# VISTA "SUELDOS_EMPLEADOS_VW" MUESTRA LOS EMPLEADOS Y SUS RESPECTIVOS SUELDOS DEL PERIODO, TAMBIEN EN LA ULTIMA COLUMNA SE MUESTRA QUIEN REALIZA EL PAGO.
CREATE VIEW SUELDOS_EMPLEADOS_VW AS (
	SELECT 	empleados.nombre,
			empleados.apellido,
            sueldos.inicio_periodo,
            sueldos.fin_periodo,
            sueldos.total,
            be_life.razon_social
	FROM dietetica.sueldos
    JOIN dietetica.empleados ON sueldos.id_empleado = empleados.id
    JOIN dietetica.be_life ON sueldos.id_be_life = be_life.id
);

# Vista para ver el ranking de los productos mas vendidos
CREATE VIEW RANKING_ARTICULOS_VENDIDOS_VW AS (
	SELECT
		ARTICULOS.NOMBRE AS NOMBRE,
		SUM(PRODUCTOS_FACTURADOS.CANTIDAD) AS CANTIDAD
	FROM DIETETICA.ARTICULOS
	JOIN productos_facturados ON ARTICULOS.ID = PRODUCTOS_FACTURADOS.id_ARTICULO
	GROUP BY ARTICULOS.NOMBRE
	ORDER BY CANTIDAD DESC
);

########################################################
-- CREACION DE USUARIOS
CREATE USER 'USERLVL1'@'LOCALHOST' IDENTIFIED WITH mysql_native_password BY 'Password0.';
CREATE USER 'USERLVL2'@'LOCALHOST' IDENTIFIED WITH mysql_native_password BY 'Password0.';
CREATE USER 'USERLVL3'@'LOCALHOST' IDENTIFIED WITH mysql_native_password BY 'Password0.';

-- PERMISOS Y PRIVILEGIOS
# USERLVL1 Solo tiene permisos para hacer un select a las vistas seleccionadas y controlar stock de articulos
GRANT SELECT ON DIETETICA.ARTICULOS_COMPLETOS_VW TO 'USERLVL1'@'LOCALHOST';
GRANT SELECT ON DIETETICA.CONTROL_DE_STOCK_VW TO 'USERLVL1'@'LOCALHOST';

# USERLVL2 tiene permisos para actualizar datos, insertar o solo consultar en las tablas seleccionadas
GRANT SELECT, INSERT, UPDATE ON DIETETICA.ARTICULOS TO 'USERLVL2'@'LOCALHOST';
GRANT SELECT, INSERT, UPDATE ON DIETETICA.STOCK TO 'USERLVL2'@'LOCALHOST';
GRANT SELECT, INSERT ON DIETETICA.PEDIDO_CLIENTE TO 'USERLVL2'@'LOCALHOST';

# USERLVL3 tiene permisos de actualizar, borrar, insertar y consultas datos de todas las tablas de la base de datos.
GRANT SELECT, INSERT, UPDATE, DELETE ON DIETETICA.* TO 'USERLVL3'@'LOCALHOST';


########################################################
-- INSERCION DE DATOS

INSERT INTO tipo_responsable VALUES
	(1, "IVA Responsable Inscripto"),
    (2, "IVA Responsable no Inscripto"),
    (3, "IVA no Responsable"),
    (4, "IVA Sujeto Exento"),
    (5, "Consumidor Final"),
    (6, "Responsable Monotributo"),
    (7, "Sujeto no Categorizado"),
    (8, "Proveedor del Exterior"),
    (9, "Cliente del Exterior"),
    (10, "IVA Liberado – Ley Nº 19.640"),
    (11, "IVA Responsable Inscripto – Agente de Percepción"),
    (12, "Pequeño Contribuyente Eventual"),
    (13, "Monotributista Social"),
    (14, "Pequeño Contribuyente Eventual Social");
    
INSERT INTO telefono VALUES
	(1, '341-000-0000'),
    (2, '341486111'),
    (3, '341486222'),
    (4, '341486333'),
    (5, '341486444'),
    (6, '341498111'),
    (7, '341498222'),
    (8, '341498333'),
    (9, '341498444'),
    (10, '341457111'),
    (11, '341457222'),
    (12, '341457333'),
    (13, '341457444');
    
INSERT INTO email VALUES
	(1, 'belife@belife.com'),
    (2, 'marcocarola@gmail.com'),
    (3, 'pacoosuna@gmail.com'),
    (4, 'hotsince82@gmail.com'),
    (5, 'staceypullen@gmail.com'),
    (6, 'maxverstappen@gmail.com'),
    (7, 'sebastianvettel@gmail.com'),
    (8, 'fernandonanoalonso@gmail.com'),
    (9, 'alexalbon@gmail.com'),
    (10, 'redhotcp@gmail.com'),
    (11, 'arcticmonkeys@gmail.com'),
    (12, 'twentyonepilots@gmail.com'),
    (13, 'tameimpala@gmail.com');
    
INSERT INTO domicilio VALUES
	(1, 'SALTA 555'),
    (2, 'ITALIA 1975'),
    (3, 'ESPAÑA 1974'),
    (4, 'INGLATERRA 1982'),
    (5, 'DETROIT 1969'),
    (6, 'BELGICA 1997'),
    (7, 'ALEMANIA 1987'),
    (8, 'ESPAÑA 1981'),
    (9, 'INGLATERRA 1996'),
    (10, 'CALIFORNIA 1962'),
    (11, 'INGLATERRA 1986'),
    (12, 'COLOMBUS 1988'),
    (13, 'AUSTRALIA 1986');

INSERT INTO be_life VALUES
	(1,'27-11-111-111-4','BE LIFE',1,1,1,1);

INSERT INTO clientes VALUES
	(1,'MARCO','CAROLA','15111111',2,2,2),
	(2,'PACO','OSUNA','15222222',3,3,3),
	(3,'DALEY','PADLEY','15333333',4,4,4),
    (4,'STACEY','PULLEN','15444444',5,5,5);

INSERT INTO empleados VALUES
	(1,'MAX','VERTAPPEN','33003333',6,6,6),
    (2,'SEBASTIAN','VETTEL','05000550',7,7,7),
    (3,'FERNANDO','ALONSO','14001441',8,8,8),
    (4,'ALEXANDER','ALBON','23002332',9,9,9);

INSERT INTO categoria_articulos VALUES
	(1,'SIN TACC'),
    (2,'VEGGIE'),
    (3,'CEREALES'),
    (4,'SUPLEMENTOS');

INSERT INTO marca_articulos VALUES
	(1,'LULEMUU'),
    (2,'CRISPINO'),
    (3,'DIMAX'),
    (4,'FELICES LAS VACAS'),
    (5,'UFF'),
    (6,'MUNDO VEGETAL'),
    (7,'VIA VEG'),
    (8,'BODY EXTREME NUTRITION');
    
INSERT INTO articulos VALUES
	(1,'Tostada de Arroz',1,'Tostada',1,90,120,'https://i.ibb.co/q54GRNV/Tostada-de-arroz-lulemuu.png','Tostada de Arroz SIN TACC'),
	(2,'Galletitas de Arroz',1,'Galletitas',2,100,100,'https://i.ibb.co/6y43qTv/Galletitas-de-Arroz-Crispino.png','Galletitas de Arroz SIN TACC'),
	(3,'Harina de Quínoa',1,'Harina',NULL,330,250,'https://i.ibb.co/hZjWzY9/Harina-de-quinoa.jpg','Harina de Quínoa SIN TACC'),
	(4,'Harina de Castañas de cajú',1,'Harina',NULL,330,180,'https://i.ibb.co/yyBfkc4/Harina-de-casta-as-de-Caju.png','Harina de Castañas de cajú SIN TACC'),
	(5,'Polenta Organica',1,'Polenta',NULL,130,450,'https://i.ibb.co/HntcDCR/Polenta-Organica.jpg','Polenta Organica SIN TACC'),
	(6,'Fécula de Mandioca',1,'Harina',NULL,230,500,'https://i.ibb.co/S6Jk2s8/Fecula-de-Mandioca.jpg','Fécula de Mandioca SIN TACC'),
	(7,'Polvo para hornear',1,'Harina',NULL,140,200,'https://i.ibb.co/nCYFWt4/Polvo-para-Hornear.jpg','Polvo para hornear SIN TACC'),
	(8,'Pan Rallado',1,'Pan',NULL,220,500,'https://i.ibb.co/SXK2gP9/Pan-Rallado-sin-tacc.jpg','Pan rallado SIN TACC'),
	(9,'Azucar Negar',1,'Azucar',NULL,240,1000,'https://i.ibb.co/VgTfXV1/Azucar-negra.png','Azucar Negar SIN TACC'),
	(10,'Pre-Mezcla base Multiple para Panificados, Pastas, y Postres',1,'Premezcla',3,1500,500,'https://i.ibb.co/Y2zg4XD/Pre-Mezcla-para-Panificados.png','Pre-Mezcla base Multiple para Panificados, Pastas, y Postres SIN TACC'),
	(11,'Almohaditas rellenas de frutilla',3,'Cereal',NULL,70,200,'https://i.ibb.co/swC7jMT/Almohaditas-Rellenas-de-frutilla.png','Cereales de Almohaditas rellenas de frutilla'),
	(12,'Almohaditas rellenas de avellana',3,'Cereal',NULL,70,200,'https://i.ibb.co/qMwWNvM/Almohaditas-Rellenas-de-avellanas.png','Cereales de Almohaditas rellenas de avellana'),
	(13,'Almohaditas rellenas de chocolate blanco',3,'Cereal',NULL,70,100,'https://i.ibb.co/6NQDGyz/Almohaditas-Rellenas-de-chocolate-blanco.jpg','Cereales de Almohaditas rellenas de chocolate blanco'),
	(14,'Almohaditas rellenas de limon',3,'Cereal',NULL,70,100,'https://i.ibb.co/DWCvDWq/Almohaditas-Rellenas-de-Limon.png','Cereales de Almohaditas rellenas de limon'),
	(15,'Almohaditas de Salvado rellenas',3,'Cereal',NULL,60,100,'https://i.ibb.co/1bhrd5c/Almohaditas-Integrales.jpg','Cereales de Almohaditas de Salvado rellenas'),
	(16,'Copos de maiz sin azucar',3,'Cereal',NULL,60,200,'https://i.ibb.co/HH8XgTH/Copos-de-maiz-sin-azucar.png','Cereales de Copos de maiz sin azucar'),
	(17,'Copos de maiz con azucar',3,'Cereal',NULL,80,200,'https://i.ibb.co/nRQbZw7/Copoz-de-maiz-con-azucar.webp','Cereales de Copos de maiz con azucar'),
	(18,'Copos de maiz con miel',3,'Cereal',NULL,80,200,'https://i.ibb.co/W0bNB6H/Copoz-de-maiz-con-miel.png','Cereales de Copos de maiz con miel'),
	(19,'Aritos de colores',3,'Cereal',NULL,150,200,'https://i.ibb.co/QdVqZQ7/Aritos-de-colores.jpg','Cereales de Aritos de colores'),
	(20,'Aritos de miel',3,'Cereal',NULL,150,200,'https://i.ibb.co/FYTngc4/Aritos-de-miel.png','Cereales de Aritos de miel'),
	(21,'Ositos de miel',3,'Cereal',NULL,160,200,'https://i.ibb.co/MpWg98R/Ositos-de-miel.jpg','Cereales de Ositos de miel'),
	(22,'Ositos de frutilla',3,'Cereal',NULL,160,200,'https://i.ibb.co/82DWcG1/Ositos-de-frutilla.png','Cereales de Ositos de frutilla'),
	(23,'Pizza de Muzzalmendras - SIN TACC',2,'Congelados',4,740,1,'https://i.ibb.co/dWQVrR5/Pizza-Muzzalmendras.png','Pizza Veggie de Muzzalmendras - SIN TACC'),
	(24,'Medallones vegetales',2,'Congelados',5,290,1,'https://i.ibb.co/RcP70Mv/Medallones-UFF.jpg','Medallones vegetales X4 UNIDADES'),
	(25,'Medallones vegetales rellenos',2,'Congelados',5,350,1,'https://i.ibb.co/RcP70Mv/Medallones-UFF.jpg','Medallones vegetales rellenos X4 UNIDADES'),
	(26,'Medallones vegetales Sin TACC de quinoa, zanahoria y cebolla caramelizada',1,'Congelados',6,290,1,'https://i.ibb.co/M7ZqvN1/Medallones-vegetales-Sin-TACC-de-quinoa-zanahoria-y-cebolla-caramelizada-x4-unidades.png','Medallones vegetales Sin TACC de quinoa, zanahoria y cebolla caramelizada X4 UNIDADES'),
	(27,'Medallones vegetales sin TACC de quinoa, espinaca y zucchini',1,'Congelados',6,290,1,'https://i.ibb.co/H4m1FH6/Medallones-vegetales-sin-TACC-de-quinoa-espinaca-y-zucchini-x4-unidades.jpg','Medallones vegetales sin TACC de quinoa, espinaca y zucchini X4 UNIDADES'),
	(28,'Bastoncitos vegetales sin TACC de espinaca, remolacha, morron y berenjena',2,'Congelados',6,270,1,'https://i.ibb.co/PT7Zm6R/Medallones-vegetales-sin-TACC-de-espinaca-remolacha-morron-y-berenjena.jpg','Bastoncitos vegetales sin TACC de espinaca, remolacha, morron y berenjena X4 UNIDADES'),
	(29,'Bastoncitos vegetales sin TACC de espinaca, proteina de arveja y arroz yamani',2,'Congelados',6,270,1,'https://i.ibb.co/ncZL4hc/Bastoncitos-vegetales-sin-TACC-de-espinaca-proteina-de-arveja-y-arroz-yamani.png','Bastoncitos vegetales sin TACC de espinaca, proteina de arveja y arroz yamani X8 UNIDADES'),
	(30,'Bastoncitos vegetales sin TACC de morron, berenjena, soja organica y arroz yamani',2,'Congelados',6,270,1,'https://i.ibb.co/H7WJVjq/Bastoncitos-vegetales-sin-TACC-de-morron-berenjena-soja-organica-y-arroz-yamani.png','Bastoncitos vegetales sin TACC de morron, berenjena, soja organica y arroz yamani X8 UNIDADES'),
	(31,'Milanesas vegetales de soja sin TACC',1,'Congelados',7,370,1,'https://i.ibb.co/wYnM5ry/Milanesa-de-soja-Viaveg.png','Milanesas vegetales de soja sin TACC X2 UNIDADES'),
	(32,'Milanesas vegetales de arvejas sin TACC',1,'Congelados',7,370,1,'https://i.ibb.co/YyB3tgM/Milanesa-de-arvejas-Viaveg.png','Milanesas vegetales de arvejas sin TACC X2 UNIDADES'),
	(33,'Milanesas vegetales de garvanzos sin TACC',1,'Congelados',7,370,1,'https://i.ibb.co/m5tng6s/Milanesa-de-garbanzos-Viaveg.png','Milanesas vegetales de garvanzos sin TACC X2 UNIDADES'),
	(34,'Milanesas vegetales de lentejas sin TACC',1,'Congelados',7,370,1,'https://i.ibb.co/X4twCzB/Milanesa-de-lentejas-Viaveg.png','Milanesas vegetales de lentejas sin TACC X2 UNIDADES'),
	(35,'Ñoquis sin TACC',1,'Congelados',NULL,320,500,'https://i.ibb.co/dLJZn1f/oquis-libre-de-gluten.jpg','Ñoquis sin TACC'),
	(36,'Proteina Gold 1kg',4,'SUPLEMENTO',8,10200,1,'https://i.ibb.co/f09281P/Proteina-Gold-1kg.png','Proteina Gold 1kg'),
	(37,'Animal Max',4,'SUPLEMENTO',8,13300,1,'https://i.ibb.co/4RbJ3q5/Animal-Max.png','Animal Max'),
	(38,'BCAA Explosive Power 120 Cap.',4,'SUPLEMENTO',8,8800,1,'https://i.ibb.co/MfVm2Dp/BCAA.png','BCAA Explosive Power 120 Cap.'),
	(39,'Carblock 4000',4,'SUPLEMENTO',8,8800,1,'https://i.ibb.co/gRB7QJf/CARBLOCK-4000.png','Carblock 4000'),
	(40,'Power Complex 9000',4,'SUPLEMENTO',8,12700,1,'https://i.ibb.co/vhnWSzn/POWER-COMPLEX-9000.png','Power Complex 9000');
    
    INSERT INTO stock VALUES
	(1,1,8,5,10,NULL),
	(2,2,9,5,10,NULL),
	(3,3,35,5,10,NULL),
	(4,4,22,5,10,NULL),
	(5,5,57,5,10,NULL),
	(6,6,14,5,10,NULL),
	(7,7,21,5,10,NULL),
	(8,8,33,5,10,NULL),
	(9,9,14,5,10,NULL),
	(10,10,6,5,10,NULL),
	(11,11,40,5,10,NULL),
	(12,12,23,5,10,NULL),
	(13,13,18,5,10,NULL),
	(14,14,22,5,10,NULL),
	(15,15,12,5,10,NULL),
	(16,16,35,5,10,NULL),
	(17,17,24,5,10,NULL),
	(18,18,21,5,10,NULL),
	(19,19,31,5,10,NULL),
	(20,20,10,5,10,NULL),
	(21,21,12,5,10,NULL),
	(22,22,32,5,10,NULL),
	(23,23,22,5,10,NULL),
	(24,24,10,5,10,NULL),
	(25,25,12,5,10,NULL),
	(26,26,10,5,10,NULL),
	(27,27,12,5,10,NULL),
	(28,28,26,5,10,NULL),
	(29,29,21,5,10,NULL),
	(30,30,9,5,10,NULL),
	(31,31,33,5,10,NULL),
	(32,32,23,5,10,NULL),
	(33,33,12,5,10,NULL),
	(34,34,32,5,10,NULL),
	(35,35,22,5,10,NULL),
	(36,35,12,5,10,NULL),
	(37,37,5,5,10,NULL),
	(38,38,13,5,10,NULL),
	(39,39,12,5,10,NULL),
	(40,40,7,5,10,NULL);

INSERT INTO proveedores VALUES
	(1,'ANTHONY','KIEDIS','27-11000111-4','RED HOT CHILI PEPPERS',1,10,10,10,8),
    (2,'ALEXANDER DAVID','TURNER','27-22000222-4','ARCTIC MONKEYS',1,11,11,11,3),
    (3,'TYLER ROBERT','JOSEPH','27-33000333-4','TWENTY ONE PILOTS',1,12,12,12,4),
    (4,'KEVIN RICHARD','PARKER','27-44000400-4','TAME IMPALA',1,13,13,13,6);
    
INSERT INTO sueldos VALUES
	(1,1,4,'2023-06-01','2023-06-30',350400),
	(2,1,1,'2023-06-01','2023-06-30',250100),
	(3,1,3,'2023-06-01','2023-06-30',375000),
	(4,1,2,'2023-06-01','2023-06-30',330200);

#En esta parte se llama al SP "sp_nuevo_cliente", luego inserto datos en las tablas "email" y "domicilio" para generar nuevos ID.
#Llamamos de nuevo el SP "sp_nuevo_cliente" y asi controlamos el funcionamiento del mismo al cargar diferentes ID.
call dietetica.sp_nuevo_cliente('EMILIANO', 'RODRIGUEZ', '123', 'CATAMARCA 675', '3476395847', 'EMILIANO@GMAIL.COM');
INSERT INTO DIETETICA.DOMICILIO VALUES (NULL, 'CHACO 123');
INSERT INTO DIETETICA.EMAIL VALUES
	(NULL, 'CHACO@GMAIL.COM'),
    (NULL, 'SANTAFE@GMAIL.COM');

call dietetica.sp_nuevo_cliente('FEDERICO', 'SANCHEZ', '321', 'SAN MARTIN 526', '3476395847', 'FEDERICO@GMAIL.COM');

# REALIZO PEDIDOS CON 3 CLIENTES DIFERENTES Y DESPUES GENERO LAS FACTURAS DE CADA UNO
call dietetica.sp_pedido_cliente(1, 12, 3);
call dietetica.sp_pedido_cliente(1, 13, 3);
call dietetica.sp_pedido_cliente(1, 15, 3);
call dietetica.sp_pedido_cliente(1, 32, 2);
call dietetica.sp_pedido_cliente(1, 40, 1);
call dietetica.sp_pedido_cliente(1, 27, 9);

call dietetica.sp_pedido_cliente(2, 8, 3);
call dietetica.sp_pedido_cliente(2, 10, 3);
call dietetica.sp_pedido_cliente(2, 9, 3);
call dietetica.sp_pedido_cliente(2, 29, 2);
call dietetica.sp_pedido_cliente(2, 25, 6);
call dietetica.sp_pedido_cliente(2, 38, 2);

call dietetica.sp_pedido_cliente(3, 25, 4);
call dietetica.sp_pedido_cliente(3, 7, 12);
call dietetica.sp_pedido_cliente(3, 2, 2);
call dietetica.sp_pedido_cliente(3, 31, 3);
call dietetica.sp_pedido_cliente(3, 33, 5);
call dietetica.sp_pedido_cliente(3, 40, 1);

call dietetica.sp_generar_factura(1, 1);
call dietetica.sp_generar_factura(2, 1);
call dietetica.sp_generar_factura(3, 1);