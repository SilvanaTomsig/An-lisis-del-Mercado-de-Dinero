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
