-- ============================================================
-- DOORS - CREACION DE TABLAS E INSERTS DE DATOS DE PRUEBA
-- ============================================================

BEGIN
    FOR T IN (
        SELECT TABLE_NAME
        FROM USER_TABLES
        WHERE TABLE_NAME IN (
            'LOGS', 'ACCESO', 'VISITA_QR', 'QR',
            'VISITA', 'USUARIO_DPTO', 'USUARIO', 'DPTO'
        )
    ) LOOP
        EXECUTE IMMEDIATE
            'DROP TABLE ' || T.TABLE_NAME || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/

-- ============================================================
-- 2. DPTO
-- ============================================================

CREATE TABLE DPTO (
    ID_DPTO NUMBER GENERATED ALWAYS AS IDENTITY,
    NUMERO  VARCHAR2(20) NOT NULL,
    BLOQUE  VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_DPTO PRIMARY KEY (ID_DPTO),
    CONSTRAINT UQ_DPTO UNIQUE (NUMERO, BLOQUE)
);

-- ============================================================
-- 3. USUARIO
-- ============================================================

CREATE TABLE USUARIO (
    ID_USUARIO NUMBER GENERATED ALWAYS AS IDENTITY,
    NOMBRE     VARCHAR2(100) NOT NULL,
    CORREO     VARCHAR2(150) NOT NULL,
    ROL        VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO),
    CONSTRAINT UQ_USUARIO_CORREO UNIQUE (CORREO),
    CONSTRAINT CK_USUARIO_ROL
        CHECK (ROL IN ('RESIDENTE', 'CONSERJE', 'ADMIN'))
);

-- ============================================================
-- 4. USUARIO_DPTO
-- Relaciona residentes con sus departamentos.
-- ============================================================

CREATE TABLE USUARIO_DPTO (
    ID_USUARIO_DPTO NUMBER GENERATED ALWAYS AS IDENTITY,
    ID_USUARIO      NUMBER NOT NULL,
    ID_DPTO         NUMBER NOT NULL,
    CONSTRAINT PK_USUARIO_DPTO PRIMARY KEY (ID_USUARIO_DPTO),
    CONSTRAINT FK_UD_USUARIO FOREIGN KEY (ID_USUARIO)
        REFERENCES USUARIO (ID_USUARIO),
    CONSTRAINT FK_UD_DPTO FOREIGN KEY (ID_DPTO)
        REFERENCES DPTO (ID_DPTO),
    CONSTRAINT UQ_USUARIO_DPTO UNIQUE (ID_USUARIO, ID_DPTO)
);

-- ============================================================
-- 5. VISITA
-- ============================================================

CREATE TABLE VISITA (
    ID_VISITA      NUMBER GENERATED ALWAYS AS IDENTITY,
    NOMBRE         VARCHAR2(100) NOT NULL,
    CORREO         VARCHAR2(150) NOT NULL,
    ID_DPTO        NUMBER NOT NULL,
    FECHA_REGISTRO TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT PK_VISITA PRIMARY KEY (ID_VISITA),
    CONSTRAINT FK_VISITA_DPTO FOREIGN KEY (ID_DPTO)
        REFERENCES DPTO (ID_DPTO)
);

-- ============================================================
-- 6. QR
-- ============================================================

CREATE TABLE QR (
    ID_QR            NUMBER GENERATED ALWAYS AS IDENTITY,
    CODIGO           VARCHAR2(100) NOT NULL,
    FECHA_GENERACION TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    FECHA_EXPIRACION TIMESTAMP NOT NULL,
    ESTADO           VARCHAR2(15) DEFAULT 'ACTIVO' NOT NULL,
    CONSTRAINT PK_QR PRIMARY KEY (ID_QR),
    CONSTRAINT UQ_QR_CODIGO UNIQUE (CODIGO),
    CONSTRAINT CK_QR_ESTADO
        CHECK (ESTADO IN ('ACTIVO', 'REVOCADO', 'UTILIZADO')),
    CONSTRAINT CK_QR_FECHAS
        CHECK (FECHA_EXPIRACION > FECHA_GENERACION)
);

-- ============================================================
-- 7. VISITA_QR
-- Relacion N a N entre VISITA y QR.
-- ============================================================

CREATE TABLE VISITA_QR (
    ID_VISITA NUMBER NOT NULL,
    ID_QR     NUMBER NOT NULL,
    CONSTRAINT PK_VISITA_QR PRIMARY KEY (ID_VISITA, ID_QR),
    CONSTRAINT FK_VQ_VISITA FOREIGN KEY (ID_VISITA)
        REFERENCES VISITA (ID_VISITA),
    CONSTRAINT FK_VQ_QR FOREIGN KEY (ID_QR)
        REFERENCES QR (ID_QR)
);

-- ============================================================
-- 8. ACCESO
-- ============================================================

CREATE TABLE ACCESO (
    ID_ACCESO     NUMBER GENERATED ALWAYS AS IDENTITY,
    ID_QR         NUMBER NOT NULL,
    ID_USUARIO    NUMBER,
    FECHA_ACCESO  TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    RESULTADO     VARCHAR2(15) NOT NULL,
    OBSERVACION   VARCHAR2(250),
    CONSTRAINT PK_ACCESO PRIMARY KEY (ID_ACCESO),
    CONSTRAINT FK_ACCESO_QR FOREIGN KEY (ID_QR)
        REFERENCES QR (ID_QR),
    CONSTRAINT FK_ACCESO_USUARIO FOREIGN KEY (ID_USUARIO)
        REFERENCES USUARIO (ID_USUARIO),
    CONSTRAINT CK_ACCESO_RESULTADO
        CHECK (RESULTADO IN ('AUTORIZADO', 'RECHAZADO'))
);

-- ============================================================
-- 9. LOGS
-- ============================================================

CREATE TABLE LOGS (
    ID_LOG          NUMBER GENERATED ALWAYS AS IDENTITY,
    TABLA_AFECTADA  VARCHAR2(50) NOT NULL,
    OPERACION       VARCHAR2(20) NOT NULL,
    ID_REGISTRO     NUMBER,
    DETALLE         VARCHAR2(400),
    FECHA_LOG       TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT PK_LOGS PRIMARY KEY (ID_LOG)
);

-- ============================================================
-- 10. DATOS DE PRUEBA: DEPARTAMENTOS
-- ============================================================

INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('101', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('102', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('103', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('104', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('201', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('202', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('203', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('204', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('301', 'A');
INSERT INTO DPTO (NUMERO, BLOQUE) VALUES ('302', 'A');

-- ============================================================
-- 11. DATOS DE PRUEBA: USUARIOS
-- ============================================================

INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Camila Rojas', 'camila.rojas@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Matias Gonzalez', 'matias.gonzalez@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Valentina Munoz', 'valentina.munoz@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Benjamin Soto', 'benjamin.soto@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Antonia Silva', 'antonia.silva@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Vicente Torres', 'vicente.torres@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Isidora Morales', 'isidora.morales@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Joaquin Herrera', 'joaquin.herrera@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Florencia Diaz', 'florencia.diaz@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Tomas Contreras', 'tomas.contreras@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Martina Silva', 'martina.silva@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Diego Fuentes', 'diego.fuentes@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Josefa Reyes', 'josefa.reyes@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Agustin Castro', 'agustin.castro@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Catalina Vargas', 'catalina.vargas@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Nicolas Alvarez', 'nicolas.alvarez@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Emilia Sepulveda', 'emilia.sepulveda@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Maximiliano Castillo', 'maximiliano.castillo@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Amanda Ramirez', 'amanda.ramirez@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Gabriel Fernandez', 'gabriel.fernandez@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Daniela Paredes', 'daniela.paredes@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Felipe Navarro', 'felipe.navarro@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Constanza Vega', 'constanza.vega@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Pablo Araya', 'pablo.araya@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Francisca Lagos', 'francisca.lagos@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Sebastian Molina', 'sebastian.molina@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Ignacio Campos', 'ignacio.campos@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Paula Carrasco', 'paula.carrasco@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Andres Vidal', 'andres.vidal@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Javiera Nunez', 'javiera.nunez@example.com', 'RESIDENTE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Carlos Mendez', 'carlos.mendez@example.com', 'CONSERJE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Patricia Leiva', 'patricia.leiva@example.com', 'CONSERJE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Rodrigo Salas', 'rodrigo.salas@example.com', 'CONSERJE');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Andrea Fuentes', 'andrea.fuentes@example.com', 'ADMIN');
INSERT INTO USUARIO (NOMBRE, CORREO, ROL) VALUES ('Mauricio Herrera', 'mauricio.herrera@example.com', 'ADMIN');

-- ============================================================
-- 12. RELACIONAR RESIDENTES CON DEPARTAMENTOS
-- Se asigna un departamento existente a cada residente.
-- Los IDs se obtienen por consulta; no se asumen valores fijos.
-- ============================================================

INSERT INTO USUARIO_DPTO (ID_USUARIO, ID_DPTO)
SELECT U.ID_USUARIO, D.ID_DPTO
FROM (
    SELECT ID_USUARIO,
           ROW_NUMBER() OVER (ORDER BY ID_USUARIO) AS N
    FROM USUARIO
    WHERE ROL = 'RESIDENTE'
) U
JOIN (
    SELECT ID_DPTO,
           ROW_NUMBER() OVER (ORDER BY ID_DPTO) AS N
    FROM DPTO
) D
  ON D.N = MOD(U.N - 1, (SELECT COUNT(*) FROM DPTO)) + 1;

-- ============================================================
-- 13. VISITAS DE PRUEBA
-- ============================================================

INSERT INTO VISITA (NOMBRE, CORREO, ID_DPTO)
SELECT V.NOMBRE, V.CORREO, D.ID_DPTO
FROM (
    SELECT 'Pedro Ramirez' NOMBRE, 'visita01@example.com' CORREO, '101' NUMERO, 'A' BLOQUE FROM DUAL UNION ALL
    SELECT 'Laura Castillo', 'visita02@example.com', '102', 'A' FROM DUAL UNION ALL
    SELECT 'Diego Martinez', 'visita03@example.com', '103', 'A' FROM DUAL UNION ALL
    SELECT 'Sofia Torres', 'visita04@example.com', '104', 'A' FROM DUAL UNION ALL
    SELECT 'Martin Silva', 'visita05@example.com', '201', 'A' FROM DUAL UNION ALL
    SELECT 'Valeria Soto', 'visita06@example.com', '202', 'A' FROM DUAL UNION ALL
    SELECT 'Benjamin Reyes', 'visita07@example.com', '203', 'A' FROM DUAL UNION ALL
    SELECT 'Antonia Fuentes', 'visita08@example.com', '204', 'A' FROM DUAL UNION ALL
    SELECT 'Joaquin Morales', 'visita09@example.com', '301', 'A' FROM DUAL UNION ALL
    SELECT 'Emilia Vargas', 'visita10@example.com', '302', 'A' FROM DUAL UNION ALL
    SELECT 'Tomas Herrera', 'visita11@example.com', '101', 'B' FROM DUAL UNION ALL
    SELECT 'Florencia Diaz', 'visita12@example.com', '102', 'B' FROM DUAL UNION ALL
    SELECT 'Agustin Castro', 'visita13@example.com', '103', 'B' FROM DUAL UNION ALL
    SELECT 'Catalina Vargas', 'visita14@example.com', '104', 'B' FROM DUAL UNION ALL
    SELECT 'Nicolas Alvarez', 'visita15@example.com', '201', 'B' FROM DUAL UNION ALL
    SELECT 'Josefa Reyes', 'visita16@example.com', '202', 'B' FROM DUAL UNION ALL
    SELECT 'Gabriel Fernandez', 'visita17@example.com', '203', 'B' FROM DUAL UNION ALL
    SELECT 'Daniela Paredes', 'visita18@example.com', '204', 'B' FROM DUAL UNION ALL
    SELECT 'Felipe Navarro', 'visita19@example.com', '301', 'B' FROM DUAL UNION ALL
    SELECT 'Francisca Lagos', 'visita20@example.com', '302', 'B' FROM DUAL
) V
JOIN DPTO D
  ON D.NUMERO = V.NUMERO
 AND D.BLOQUE = V.BLOQUE;

-- ============================================================
-- 15. RELACIONAR VISITAS Y QR
-- La numeracion del correo de visita coincide con el codigo QR.
-- ============================================================

INSERT INTO VISITA_QR (ID_VISITA, ID_QR)
SELECT V.ID_VISITA, Q.ID_QR
FROM VISITA V
JOIN QR Q
  ON TO_NUMBER(REGEXP_SUBSTR(V.CORREO, '[0-9]+')) =
     TO_NUMBER(REGEXP_SUBSTR(Q.CODIGO, '[0-9]+$'));

-- ============================================================
-- 16. ACCESOS DE PRUEBA
-- Se toman los QR existentes; no se asumen IDs fijos.
-- ============================================================

INSERT INTO ACCESO (ID_QR, ID_USUARIO, RESULTADO, OBSERVACION)
SELECT Q.ID_QR,
       (SELECT MIN(U.ID_USUARIO)
        FROM USUARIO U
        WHERE U.ROL = 'CONSERJE'),
       CASE
           WHEN MOD(TO_NUMBER(REGEXP_SUBSTR(Q.CODIGO, '[0-9]+$')), 3) = 0
               THEN 'RECHAZADO'
           ELSE 'AUTORIZADO'
       END,
       'Registro de prueba DOORS'
FROM QR Q;

COMMIT;