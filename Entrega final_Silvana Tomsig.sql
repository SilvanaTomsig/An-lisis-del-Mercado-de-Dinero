-- Archivo: creacion_db_tablas.sql
-- Script para la creación de la base de datos y tablas del proyecto final.

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS `proyecto_final_db`;
USE `proyecto_final_db`;

-- Tabla `Sectores`
CREATE TABLE `Sectores` (
    `sec_id` INT AUTO_INCREMENT,
    `sec_letra` VARCHAR(2) NOT NULL,
    `sec_nombre` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`sec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla `Cuentas`
CREATE TABLE `Cuentas` (
    `cue_id` INT AUTO_INCREMENT,
    `cue_tipo` VARCHAR(255) NOT NULL,
    `cue_subtipo` VARCHAR(255) NOT NULL,
    `cue_detalle` VARCHAR(255) NOT NULL,
    `cue_descripcion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`cue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla `Transacciones`
CREATE TABLE `Transacciones` (
    `tra_id` INT AUTO_INCREMENT,
    `tra_fecha` DATE NOT NULL,
    `tra_monto` DECIMAL(15, 2) NOT NULL,
    `tra_sec_id` INT,
    `tra_cue_id` INT,
    `tra_anexo` VARCHAR(255),
    `tra_dos_digitos` VARCHAR(255),
    PRIMARY KEY (`tra_id`),
    INDEX `idx_fecha` (`tra_fecha`),
    FOREIGN KEY (`tra_sec_id`) REFERENCES `Sectores`(`sec_id`) ON DELETE SET NULL,
    FOREIGN KEY (`tra_cue_id`) REFERENCES `Cuentas`(`cue_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Comentarios sobre el script:
-- 1. Se crea la base de datos `proyecto_final_db`.
-- 2. Se definen las tablas `Sectores`, `Cuentas` y `Transacciones`.
-- 3. Se establecen las claves primarias (`PK`) para cada tabla.
-- 4. En la tabla `Transacciones`, se establecen las claves foráneas (`FK`) que se vinculan con las tablas `Sectores` y `Cuentas`.
-- 5. Se añade un índice (`INDEX`) a la columna `tra_fecha` en la tabla `Transacciones` para optimizar las consultas por fecha.
-- 6. Las claves foráneas están configuradas con `ON DELETE SET NULL` para manejar la integridad referencial de los datos. Esto significa que si un registro en `Sectores` o `Cuentas` se elimina, el valor de la clave foránea correspondiente en `Transacciones` se establecerá en NULL.


-- Segunda Pre entrega
-- Archivo: objetos_db.sql
-- Script para la creación de Vistas, Funciones, Stored Procedures y Triggers.

-- Archivo: insertar_datos.sql
-- Script para la inserción de datos en las tablas del proyecto final.

USE `proyecto_final_db`;

-- Datos para la tabla `Sectores`
INSERT INTO `Sectores` (`sec_letra`, `sec_nombre`) VALUES
('A', 'Agricultura, ganaderia, caza, silvicultura y pesca'),
('B', 'Explotacion de minas y canteras'),
('C', 'Industria manufacturera'),
('D', 'Suministro de electricidad, gas, vapor y aire acondicionado'),
('E', 'Suministro de agua, evacuacion de aguas residuales, gestion de desechos y saneamiento'),
('F', 'Construccion'),
('G', 'Comercio al por mayor y al por menor; reparacion de vehiculos automotores y motocicletas'),
('H', 'Servicio de transporte y almacenamiento'),
('I', 'Servicios de alojamiento y servicios de comida'),
('J', 'Informacion y comunicaciones'),
('K', 'Actividades financieras y de seguros'),
('L', 'Actividades inmobiliarias'),
('M', 'Servicios profesionales, cientificos y tecnicos'),
('N', 'Actividades de servicios administrativos y de apoyo'),
('O', 'Administracion publica y defensa; planes de seguridad social de afiliacion obligatoria'),
('P', 'Ensenanza'),
('Q', 'Actividades de atencion de la salud humana y de asistencia social'),
('R', 'Servicios artisticos, culturales, deportivos y de esparcimiento'),
('S', 'Otras actividades de servicios'),
('T', 'Actividades de los hogares como empleadores; actividades no diferenciadas de los hogares como productores de bienes y servicios para uso propio'),
('U', 'Actividades de organizaciones y organos extraterritoriales');

-- Datos para la tabla `Cuentas`
INSERT INTO `Cuentas` (`cue_tipo`, `cue_subtipo`, `cue_detalle`, `cue_descripcion`) VALUES
('Cuenta Corriente', 'Bienes', 'Cobros de exportaciones de bienes', 'Cobros de exportaciones'),
('Cuenta Corriente', 'Servicios', 'Servicios - Ingresos', 'Servicios - Ingresos'),
('Cuenta Financiera', 'Compra/Venta de billetes y divisas sin fines especificos', 'Compras de billetes y divisas sin fines especificos', 'Billetes - Egresos'),
('Cuenta Corriente', 'Ingreso primario', 'Ingreso Primario - Egresos', 'Intereses - Egresos');

-- Datos para la tabla `Transacciones`
INSERT INTO `Transacciones` (`tra_fecha`, `tra_monto`, `tra_sec_id`, `tra_cue_id`, `tra_anexo`, `tra_dos_digitos`) VALUES
('2003-01-01', 926901, 6, 1, '1', 'Actividades especializadas de construccion'),
('2003-01-01', 664164, 13, 1, '1', 'Oficinas centrales y servicios de asesoramiento empresarial'),
('2003-01-01', 13182, 18, 1, '1', 'Servicios relacionados con juegos de azar y apuestas'),
('2003-01-01', 20719468, 3, 1, '1', 'Fabricacion de productos textiles'),
('2003-01-01', 676747, 10, 1, '1', 'Servicios de radio y television'),
('2003-01-01', 423528, 10, 1, '1', 'Servicios de telecomunicaciones'),
('2003-01-01', 198813, 13, 1, '1', 'Servicios juridicos, de contabilidad y de asesoria de gestion'),
('2003-01-01', 345244, 10, 1, '1', 'Servicios de programacion, consultoria y actividades relacionadas con la informatica'),
('2003-01-01', 194726, 18, 1, '1', 'Actividades creativas, artisticas y de espectaculos'),
('2003-01-01', 252093, 18, 1, '1', 'Actividades de bibliotecas, archivos y museos, y otras actividades culturales'),
('2003-01-01', -1669460.7, 3, 2, '25', 'Fabricacion de productos textiles'),
('2003-01-01', 250689.9, 10, 2, '2', 'Servicios de programacion, consultoria y actividades relacionadas con la informatica'),
('2003-01-01', 82563.18, 10, 2, '2', 'Servicios de telecomunicaciones'),
('2003-01-01', -92440.49, 11, 3, '3', 'Actividades de las sociedades de cartera, los fondos fiduciarios y entidades financieras similares'),
('2003-01-01', -4747140.4, 3, 4, '36', 'Fabricacion de metales comunes'),
('2003-01-01', -6385914.48, 10, 2, '32', 'Servicios de telecomunicaciones');


-- Archivo: objetos_db.sql
-- Script para la creación de Vistas, Funciones, Stored Procedures y Triggers.
USE `proyecto_final_db`;

-- =======================
-- VISTAS
-- =======================
CREATE OR REPLACE VIEW vw_transacciones_sector AS
SELECT t.tra_id, t.tra_fecha, t.tra_monto, s.sec_nombre, s.sec_letra, t.tra_anexo, t.tra_dos_digitos
FROM Transacciones t
LEFT JOIN Sectores s ON t.tra_sec_id = s.sec_id;

CREATE OR REPLACE VIEW vw_transacciones_cuenta AS
SELECT t.tra_id, t.tra_fecha, t.tra_monto, c.cue_tipo, c.cue_subtipo, c.cue_detalle, c.cue_descripcion
FROM Transacciones t
LEFT JOIN Cuentas c ON t.tra_cue_id = c.cue_id;

CREATE OR REPLACE VIEW vw_resumen_sector_mensual AS
SELECT YEAR(t.tra_fecha) AS anio, MONTH(t.tra_fecha) AS mes, s.sec_nombre, SUM(t.tra_monto) AS total_mensual
FROM Transacciones t
JOIN Sectores s ON t.tra_sec_id = s.sec_id
GROUP BY anio, mes, s.sec_nombre;


-- =======================
-- FUNCIONES
-- =======================
DELIMITER //
CREATE FUNCTION fn_total_por_sector(p_sec_id INT, p_anio INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(15,2);
    SELECT SUM(tra_monto) INTO total
    FROM Transacciones
    WHERE tra_sec_id = p_sec_id AND YEAR(tra_fecha) = p_anio;
    RETURN IFNULL(total,0);
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_crecimiento_mensual(p_sec_id INT, p_anio INT, p_mes INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE actual DECIMAL(15,2);
    DECLARE anterior DECIMAL(15,2);
    DECLARE resultado DECIMAL(10,2);

    SELECT SUM(tra_monto) INTO actual
    FROM Transacciones
    WHERE tra_sec_id = p_sec_id AND YEAR(tra_fecha) = p_anio AND MONTH(tra_fecha) = p_mes;

    SELECT SUM(tra_monto) INTO anterior
    FROM Transacciones
    WHERE tra_sec_id = p_sec_id AND YEAR(tra_fecha) = p_anio AND MONTH(tra_fecha) = p_mes - 1;

    IF anterior IS NULL OR anterior = 0 THEN
        SET resultado = NULL;
    ELSE
        SET resultado = ((actual - anterior) / anterior) * 100;
    END IF;

    RETURN resultado;
END;
//
DELIMITER ;

-- =======================
-- STORED PROCEDURES
-- =======================
DELIMITER //
CREATE PROCEDURE sp_insertar_transaccion(
    IN p_fecha DATE,
    IN p_monto DECIMAL(15,2),
    IN p_sec_id INT,
    IN p_cue_id INT,
    IN p_anexo VARCHAR(255),
    IN p_dos_digitos VARCHAR(255)
)
BEGIN
    -- Validar existencia de sector y cuenta
    IF (SELECT COUNT(*) FROM Sectores WHERE sec_id = p_sec_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sector no válido';
    END IF;
    IF (SELECT COUNT(*) FROM Cuentas WHERE cue_id = p_cue_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta no válida';
    END IF;

    INSERT INTO Transacciones(tra_fecha, tra_monto, tra_sec_id, tra_cue_id, tra_anexo, tra_dos_digitos)
    VALUES(p_fecha, p_monto, p_sec_id, p_cue_id, p_anexo, p_dos_digitos);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_reporte_anual(IN p_anio INT)
BEGIN
    SELECT s.sec_nombre, c.cue_tipo, c.cue_subtipo, SUM(t.tra_monto) AS total_anual
    FROM Transacciones t
    JOIN Sectores s ON t.tra_sec_id = s.sec_id
    JOIN Cuentas c ON t.tra_cue_id = c.cue_id
    WHERE YEAR(t.tra_fecha) = p_anio
    GROUP BY s.sec_nombre, c.cue_tipo, c.cue_subtipo
    ORDER BY total_anual DESC;
END;
//
DELIMITER ;

-- =======================
-- TRIGGERS
-- =======================
DELIMITER //
CREATE TRIGGER trg_valida_monto
BEFORE INSERT ON Transacciones
FOR EACH ROW
BEGIN
    IF NEW.tra_monto IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto no puede ser NULL';
    END IF;
END;
//
DELIMITER ;

-- =====================================


CREATE DATABASE IF NOT EXISTS `proyecto_final_db`;
USE `proyecto_final_db`;

-- =====================================
-- TABLAS
-- =====================================
CREATE TABLE IF NOT EXISTS `Sectores` (
    `sec_id` INT AUTO_INCREMENT,
    `sec_letra` VARCHAR(2) NOT NULL,
    `sec_nombre` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`sec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `Cuentas` (
    `cue_id` INT AUTO_INCREMENT,
    `cue_tipo` VARCHAR(255) NOT NULL,
    `cue_subtipo` VARCHAR(255) NOT NULL,
    `cue_detalle` VARCHAR(255) NOT NULL,
    `cue_descripcion` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`cue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `Transacciones` (
    `tra_id` INT AUTO_INCREMENT,
    `tra_fecha` DATE NOT NULL,
    `tra_monto` DECIMAL(15, 2) NOT NULL,
    `tra_sec_id` INT,
    `tra_cue_id` INT,
    `tra_anexo` VARCHAR(255),
    `tra_dos_digitos` VARCHAR(255),
    PRIMARY KEY (`tra_id`),
    INDEX `idx_fecha` (`tra_fecha`),
    FOREIGN KEY (`tra_sec_id`) REFERENCES `Sectores`(`sec_id`) ON DELETE SET NULL,
    FOREIGN KEY (`tra_cue_id`) REFERENCES `Cuentas`(`cue_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================
-- DATOS INICIALES
-- =====================================
INSERT INTO `Sectores` (`sec_letra`, `sec_nombre`) VALUES
('A', 'Agricultura, ganadería y pesca'),
('B', 'Explotación de minas y canteras'),
('C', 'Industria manufacturera'),
('D', 'Energía'),
('E', 'Construcción');

INSERT INTO `Cuentas` (`cue_tipo`, `cue_subtipo`, `cue_detalle`, `cue_descripcion`) VALUES
('Cuenta Corriente', 'Bienes', 'Cobros de exportaciones', 'Exportaciones - Ingresos'),
('Cuenta Corriente', 'Servicios', 'Servicios varios', 'Servicios - Ingresos'),
('Cuenta Financiera', 'Divisas', 'Compra de divisas', 'Egresos de divisas'),
('Cuenta Corriente', 'Intereses', 'Pago de intereses', 'Intereses - Egresos');

INSERT INTO `Transacciones` (`tra_fecha`, `tra_monto`, `tra_sec_id`, `tra_cue_id`, `tra_anexo`, `tra_dos_digitos`) VALUES
('2023-01-01', 1000000, 1, 1, '1', 'Exportación soja'),
('2023-01-05', 500000, 2, 2, '2', 'Servicios mineros'),
('2023-02-10', -200000, 3, 3, '3', 'Compra de divisas'),
('2023-03-15', -150000, 4, 4, '4', 'Pago intereses'),
('2023-03-20', 750000, 5, 1, '5', 'Obra pública');

-- =====================================
-- VISTAS
-- =====================================
CREATE OR REPLACE VIEW vw_transacciones_sector AS
SELECT t.tra_id, t.tra_fecha, t.tra_monto, s.sec_nombre, s.sec_letra
FROM Transacciones t
LEFT JOIN Sectores s ON t.tra_sec_id = s.sec_id;

CREATE OR REPLACE VIEW vw_transacciones_cuenta AS
SELECT t.tra_id, t.tra_fecha, t.tra_monto, c.cue_tipo, c.cue_subtipo
FROM Transacciones t
LEFT JOIN Cuentas c ON t.tra_cue_id = c.cue_id;

CREATE OR REPLACE VIEW vw_resumen_sector_mensual AS
SELECT YEAR(t.tra_fecha) AS anio, MONTH(t.tra_fecha) AS mes, s.sec_nombre, SUM(t.tra_monto) AS total_mensual
FROM Transacciones t
JOIN Sectores s ON t.tra_sec_id = s.sec_id
GROUP BY anio, mes, s.sec_nombre;

-- Nueva vista 1: Top sectores por monto
CREATE OR REPLACE VIEW vw_top_sectores AS
SELECT s.sec_nombre, SUM(t.tra_monto) AS total
FROM Transacciones t
JOIN Sectores s ON t.tra_sec_id = s.sec_id
GROUP BY s.sec_nombre
ORDER BY total DESC;

-- Nueva vista 2: Balance por cuenta (ingresos vs egresos)
CREATE OR REPLACE VIEW vw_balance_cuentas AS
SELECT c.cue_tipo, c.cue_subtipo,
       SUM(CASE WHEN t.tra_monto > 0 THEN t.tra_monto ELSE 0 END) AS ingresos,
       SUM(CASE WHEN t.tra_monto < 0 THEN t.tra_monto ELSE 0 END) AS egresos,
       SUM(t.tra_monto) AS balance_total
FROM Transacciones t
JOIN Cuentas c ON t.tra_cue_id = c.cue_id
GROUP BY c.cue_tipo, c.cue_subtipo;

-- Nueva vista 3: Vista_promedio_monto_por_tipo_cuenta (Calcula el monto promedio de transacciones por el tipo de cuenta principal)
CREATE VIEW vista_promedio_monto_por_tipo_cuenta AS
SELECT c.cue_tipo, AVG(t.tra_monto) AS promedio_monto
FROM Transacciones t JOIN Cuentas c ON t.tra_cue_id = c.cue_id
GROUP BY c.cue_tipo ORDER BY promedio_monto DESC;

-- Nueva vista 4: Vista_total_mensual_anual (Muestra el monto total de transacciones por cada mes y año, ideal para análisis de tendencias.)
CREATE VIEW vista_total_mensual_anual AS
SELECT YEAR(tra_fecha) AS anio, MONTH(tra_fecha) AS mes, SUM(tra_monto) AS total_mensual
FROM Transacciones
GROUP BY anio, mes ORDER BY anio, mes;

-- Nueva vista 5: Vista_transacciones_maximas (Identifica la transacción con el monto más alto por cada sector económico.)
CREATE VIEW vista_transacciones_maximas AS
SELECT s.sec_nombre, MAX(t.tra_monto) AS monto_maximo
FROM Transacciones t JOIN Sectores s ON t.tra_sec_id = s.sec_id
GROUP BY s.sec_nombre ORDER BY monto_maximo DESC;


-- =====================================
-- FUNCIONES
-- =====================================
DELIMITER //
CREATE FUNCTION fn_total_por_sector(p_sec_id INT, p_anio INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(15,2);
    SELECT SUM(tra_monto) INTO total
    FROM Transacciones
    WHERE tra_sec_id = p_sec_id AND YEAR(tra_fecha) = p_anio;
    RETURN IFNULL(total,0);
END;
//
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_crecimiento_mensual(p_sec_id INT, p_anio INT, p_mes INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE actual DECIMAL(15,2);
    DECLARE anterior DECIMAL(15,2);
    DECLARE resultado DECIMAL(10,2);

    SELECT SUM(tra_monto) INTO actual
    FROM Transacciones
    WHERE tra_sec_id = p_sec_id AND YEAR(tra_fecha) = p_anio AND MONTH(tra_fecha) = p_mes;

    SELECT SUM(tra_monto) INTO anterior
    FROM Transacciones
    WHERE tra_sec_id = p_sec_id AND YEAR(tra_fecha) = p_anio AND MONTH(tra_fecha) = p_mes - 1;

    IF anterior IS NULL OR anterior = 0 THEN
        SET resultado = NULL;
    ELSE
        SET resultado = ((actual - anterior) / anterior) * 100;
    END IF;

    RETURN resultado;
END;
//
DELIMITER ;

-- =====================================
-- STORED PROCEDURES
-- =====================================
DELIMITER //
CREATE PROCEDURE sp_insertar_transaccion(
    IN p_fecha DATE,
    IN p_monto DECIMAL(15,2),
    IN p_sec_id INT,
    IN p_cue_id INT,
    IN p_anexo VARCHAR(255),
    IN p_dos_digitos VARCHAR(255)
)
BEGIN
    -- Validar existencia de sector y cuenta
    IF (SELECT COUNT(*) FROM Sectores WHERE sec_id = p_sec_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sector no válido';
    END IF;
    IF (SELECT COUNT(*) FROM Cuentas WHERE cue_id = p_cue_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta no válida';
    END IF;

    INSERT INTO Transacciones(tra_fecha, tra_monto, tra_sec_id, tra_cue_id, tra_anexo, tra_dos_digitos)
    VALUES(p_fecha, p_monto, p_sec_id, p_cue_id, p_anexo, p_dos_digitos);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_reporte_anual(IN p_anio INT)
BEGIN
    SELECT s.sec_nombre, c.cue_tipo, c.cue_subtipo, SUM(t.tra_monto) AS total_anual
    FROM Transacciones t
    JOIN Sectores s ON t.tra_sec_id = s.sec_id
    JOIN Cuentas c ON t.tra_cue_id = c.cue_id
    WHERE YEAR(t.tra_fecha) = p_anio
    GROUP BY s.sec_nombre, c.cue_tipo, c.cue_subtipo
    ORDER BY total_anual DESC;
END;
//
DELIMITER ;


-- =====================================
-- TRIGGERS
-- =====================================
DELIMITER //
CREATE TRIGGER trg_valida_monto
BEFORE INSERT ON Transacciones
FOR EACH ROW
BEGIN
    IF NEW.tra_monto IS NULL OR NEW.tra_monto = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto no puede ser NULL ni cero';
    END IF;
END;
//
DELIMITER ;

-- =====================================
-- CASOS DE PRUEBA
-- =====================================
-- Caso 1: Inserción válida
CALL sp_insertar_transaccion('2023-04-01', 300000, 1, 1, '6', 'Exportación trigo');

-- Caso 2: Inserción inválida (sector inexistente -> error)
CALL sp_insertar_transaccion('2023-04-01', 100000, 99, 1, '7', 'Error sector');

-- Caso 3: Inserción inválida (monto nulo -> trigger lo bloquea)
INSERT INTO Transacciones (tra_fecha, tra_monto, tra_sec_id, tra_cue_id) VALUES ('2023-05-01', NULL, 1, 1);

-- Caso 4: Uso de función para total por sector
SELECT fn_total_por_sector(1,2023);

-- Caso 5: Vista de balance por cuenta
SELECT * FROM vw_balance_cuentas;

-- Caso 5: Insertar una transacción válida --Una nueva fila en la tabla Transacciones.
CALL sp_insertar_transaccion('2025-10-20', 1500.50, 1, 3, 'A3', '10');

-- Caso 6: Intentar insertar con un sec_id o cue_id que no existe. --Error de SQL: Sector no válido.
CALL sp_insertar_transaccion('2025-10-21', 500.00, 999, 1, 'B2', '20');

-- Caso 7: Intentar insertar un monto cero o nulo. --Error de SQL: La inserción es cancelada por el Trigger, ya que el monto debe ser positivo.
INSERT INTO Transacciones (tra_fecha, tra_monto, tra_sec_id, tra_cue_id) VALUES ('2025-10-22', 0.00, 1, 1);


-- =====================================
-- Scripts
-- =====================================

-- Script: insercion_datos.sql

-- 1. Inserción de Sectores (Dimensión)
INSERT INTO Sectores (sec_letra, sec_nombre) VALUES
('A', 'Agricultura, ganadería, caza y silvicultura'),
('C', 'Industria manufacturera');

-- 2. Inserción de Cuentas (Dimensión)
INSERT INTO Cuentas (cue_tipo, cue_subtipo, cue_detalle, cue_descripcion) VALUES
('01- Cuenta Corriente', '01- Bienes', '01- Cobros de exportaciones de bienes', 'Cobros de exportaciones');

-- 3. Inserción de Transacciones (Hecho)
INSERT INTO Transacciones (tra_fecha, tra_monto, tra_sec_id, tra_cue_id, tra_anexo, tra_dos_digitos) VALUES
('2003-01-01', 926901.00, 1, 1, '1', 'Actividades especializadas de construccion'),
('2003-01-01', 20719468.00, 2, 1, '1', 'Fabricacion de productos textiles');

