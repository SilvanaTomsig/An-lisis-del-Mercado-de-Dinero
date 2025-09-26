-- Archivo: insercion_datos.sql
-- Inserción de datos iniciales en las tablas

USE `proyecto_final_db`;

-- Sectores
INSERT INTO `Sectores` (`sec_letra`, `sec_nombre`) VALUES
('A', 'Agricultura, ganadería y pesca'),
('B', 'Explotación de minas y canteras'),
('C', 'Industria manufacturera'),
('D', 'Energía'),
('E', 'Construcción');

-- Cuentas
INSERT INTO `Cuentas` (`cue_tipo`, `cue_subtipo`, `cue_detalle`, `cue_descripcion`) VALUES
('Cuenta Corriente', 'Bienes', 'Cobros de exportaciones', 'Exportaciones - Ingresos'),
('Cuenta Corriente', 'Servicios', 'Servicios varios', 'Servicios - Ingresos'),
('Cuenta Financiera', 'Divisas', 'Compra de divisas', 'Egresos de divisas'),
('Cuenta Corriente', 'Intereses', 'Pago de intereses', 'Intereses - Egresos');

-- Transacciones
INSERT INTO `Transacciones` (`tra_fecha`, `tra_monto`, `tra_sec_id`, `tra_cue_id`, `tra_anexo`, `tra_dos_digitos`) VALUES
('2023-01-01', 1000000, 1, 1, '1', 'Exportación soja'),
('2023-01-05', 500000, 2, 2, '2', 'Servicios mineros'),
('2023-02-10', -200000, 3, 3, '3', 'Compra de divisas'),
('2023-03-15', -150000, 4, 4, '4', 'Pago intereses'),
('2023-03-20', 750000, 5, 1, '5', 'Obra pública');
