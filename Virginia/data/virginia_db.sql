-- Tabla Administradores Actualizada
CREATE TABLE administradores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Contraseña cifrada
    pregunta_seguridad_1 VARCHAR(255) NOT NULL,
    respuesta_seguridad_1_hash VARCHAR(255) NOT NULL, -- Respuesta cifrada
    pregunta_seguridad_2 VARCHAR(255) NOT NULL,
    respuesta_seguridad_2_hash VARCHAR(255) NOT NULL -- Respuesta cifrada
);

INSERT INTO administradores (username, nombre, password_hash, pregunta_seguridad_1, respuesta_seguridad_1_hash, pregunta_seguridad_2, respuesta_seguridad_2_hash)
VALUES (
    'admin123',
    'Administrador',
    SHA2('12345678', 256), -- Contraseña cifrada
    '¿Nombre de tu primera mascota?',
    SHA2('Rex', 256), -- Respuesta 1 cifrada
    '¿Ciudad donde naciste?',
    SHA2('Caracas', 256) -- Respuesta 2 cifrada
);

-- Tabla Años Académicos y Lapsos
CREATE TABLE anios_academicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    anio_inicio YEAR NOT NULL,
    anio_fin YEAR NOT NULL,
    lapsos INT NOT NULL CHECK (lapsos > 0 AND lapsos <= 3)
);

-- Tabla Representantes
CREATE TABLE representantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    direccion TEXT
);

-- Tabla Estudiantes
CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    genero ENUM('masculino', 'femenino', 'otro') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    edad INT NOT NULL,
    parentesco_con_representante VARCHAR(50),
    direccion TEXT,
    anio_academico_id INT NOT NULL,
    representante_id INT NOT NULL,
    FOREIGN KEY (anio_academico_id) REFERENCES anios_academicos(id) ON DELETE CASCADE,
    FOREIGN KEY (representante_id) REFERENCES representantes(id) ON DELETE CASCADE
);

-- Tabla Materias
CREATE TABLE materias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    anio_academico_id INT NOT NULL,
    FOREIGN KEY (anio_academico_id) REFERENCES anios_academicos(id) ON DELETE CASCADE
);

-- Tabla Notas
CREATE TABLE notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    materia_id INT NOT NULL,
    calificacion DECIMAL(5, 2) NOT NULL CHECK (calificacion >= 0 AND calificacion <= 20),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id) ON DELETE CASCADE,
    FOREIGN KEY (materia_id) REFERENCES materias(id) ON DELETE CASCADE
);
