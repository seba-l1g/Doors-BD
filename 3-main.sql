SELECT OBJECT_NAME, OBJECT_TYPE, STATUS
FROM USER_OBJECTS
WHERE OBJECT_NAME IN ('PKG_DOORS', 'TRG_LOG_ACCESO')
ORDER BY OBJECT_TYPE;

SET SERVEROUTPUT ON;
DECLARE
    V_ID_DPTO NUMBER;
    V_CODIGO VARCHAR2(100);
    V_ID_QR NUMBER;
    V_ID_ACCESO NUMBER;
    V_VALIDO NUMBER;
    V_LOGS NUMBER;
    V_CORREO VARCHAR2(150);
BEGIN
    -- Buscar un departamento existente.
    SELECT MIN(ID_DPTO)
    INTO V_ID_DPTO
    FROM DPTO;

    IF V_ID_DPTO IS NULL THEN
        RAISE_APPLICATION_ERROR(
            -20010, 'No existen departamentos para realizar la prueba');
    END IF;

    -- Generar un correo unico para la prueba.
    V_CORREO := 'prueba_'||TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF3')||'@example.com';

    -- Generar visita y QR.
    PKG_DOORS.GENERAR_QR(V_CORREO, 'Visita de prueba DOORS', V_ID_DPTO, V_CODIGO);
    DBMS_OUTPUT.PUT_LINE('QR generado: ' || V_CODIGO);

    -- Validar QR.
    V_VALIDO := PKG_DOORS.VALIDAR_QR(V_CODIGO);
    DBMS_OUTPUT.PUT_LINE('Resultado validacion: ' || V_VALIDO);

    -- Obtener ID real del QR.
    SELECT ID_QR
    INTO V_ID_QR
    FROM QR
    WHERE CODIGO = V_CODIGO;

    -- Insertar acceso y activar el trigger.
    INSERT INTO ACCESO (ID_QR, ID_USUARIO, RESULTADO, OBSERVACION)
    VALUES(V_ID_QR, NULL, 'AUTORIZADO', 'Prueba del trigger DOORS')
    RETURNING ID_ACCESO INTO V_ID_ACCESO;

    -- Verificar que el trigger haya creado el log.
    SELECT COUNT(*)
    INTO V_LOGS
    FROM LOGS
    WHERE TABLA_AFECTADA = 'ACCESO'
    AND OPERACION = 'INSERT'
    AND ID_REGISTRO = V_ID_ACCESO;
    DBMS_OUTPUT.PUT_LINE('ID del acceso: ' || V_ID_ACCESO);
    DBMS_OUTPUT.PUT_LINE('Logs creados: ' || V_LOGS);
    COMMIT;
END;
/

SELECT * FROM USUARIO;
SELECT * FROM DPTO;