-- Crear la base de datos si no existe y usarla
CREATE SCHEMA IF NOT EXISTS dw_turismo_alicante;
USE dw_turismo_alicante;

-- 0. Limpieza (borrar tablas si ya existían para evitar errores)
DROP TABLE IF EXISTS Hecho_Turismo_Clima;
DROP TABLE IF EXISTS Dim_Tiempo;
DROP TABLE IF EXISTS Dim_Ubicacion;

-- 1. Crear Dimensión Tiempo
CREATE TABLE Dim_Tiempo (
    id_tiempo INT PRIMARY KEY,      -- Formato AAAAMM (Ej: 202601)
    mes INT NOT NULL,
    nombre_mes VARCHAR(20),
    temporada VARCHAR(20),          -- Alta, Media, Baja
    anio INT NOT NULL
);

-- 2. Crear Dimensión Ubicación
CREATE TABLE Dim_Ubicacion (
    id_ubicacion INT PRIMARY KEY,   -- Código INE (Ej: 3014 para Alicante)
    municipio VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    comunidad_autonoma VARCHAR(100) NOT NULL
);

-- 3. Crear Tabla de Hechos
CREATE TABLE Hecho_Turismo_Clima (
    id_tiempo INT,
    id_ubicacion INT,
    
    -- Medidas Aditivas
    viajeros_nacionales INT,
    viajeros_extranjeros INT,
    pernoctaciones INT,
    precipitacion_total DECIMAL(6,2),
    
    -- Medidas No Aditivas
    estancia_media DECIMAL(5,2),
    grado_ocupacion DECIMAL(5,2),
    temperatura_media DECIMAL(5,2),
    
    -- Claves
    PRIMARY KEY (id_tiempo, id_ubicacion),
    FOREIGN KEY (id_tiempo) REFERENCES Dim_Tiempo(id_tiempo),
    FOREIGN KEY (id_ubicacion) REFERENCES Dim_Ubicacion(id_ubicacion)
);