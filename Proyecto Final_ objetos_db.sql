-- Archivo: objetos_db.sql
-- Creación de vistas, funciones, procedimientos y triggers

USE `proyecto_final_db`;

-- =======================
-- VISTAS
-- =======================
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

CREATE OR REPLACE VIEW vw_top_sectores AS
SELECT s.sec_nombre, SUM(t.tra_monto) AS total
FROM Transacciones t
JOIN Sectores s ON t.tra_sec_id = s.sec_id
GROUP BY s.sec_nombre
ORDER BY total DESC;

CREATE OR REPLACE VIEW vw_balance_cuentas AS
SELECT c.cue_tipo, c.cue_subtipo,
       SUM(CASE WHEN t.tra_monto > 0 THEN t.tra_monto ELSE 0 END) AS ingresos,
       SUM(CASE WHEN t.tra_monto < 0 THEN t.tra_monto ELSE 0 END) AS egresos,
       SUM(t.tra_monto) AS balance_total
FROM Transacciones t
JOIN Cuentas c ON t.tra_cue_id = c.cue_id
GROUP BY c.cue_tipo, c.cue_subtipo;

CREATE OR REPLACE VIEW vista_promedio_monto_por_tipo_cuenta AS
SELECT c.cue_tipo, AVG(t.tra_monto) AS promedio_monto
FROM Transacciones t
JOIN Cuentas c ON t.tra_cue_id = c.cue_id
GROUP BY c.cue_tipo ORDER BY promedio_monto DESC;

CREATE OR REPLACE VIEW vista_total_mensual_anual AS
SELECT YEAR(tra_fecha) AS anio, MONTH(tra_fecha) AS mes, SUM(tra_monto) AS total_mensual
FROM Transacciones
GROUP BY anio, mes ORDER BY anio, mes;

CREATE OR REPLACE VIEW vista_transacciones_maximas AS
SELECT s.sec_nombre, MAX(t.tra_monto) AS monto_maximo
FROM Transacciones t
JOIN Sectores s ON t.tra_sec_id = s.sec_id
GROUP BY s.sec_nombre ORDER BY monto_maximo DESC;

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
    IF NEW.tra_monto IS NULL OR NEW.tra_monto = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto no puede ser NULL ni cero';
    END IF;
END;
//
DELIMITER ;
