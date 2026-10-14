CREATE OR REPLACE PACKAGE PKG_DOORS AS
    PROCEDURE GENERAR_QR(
        P_CORREO  IN VARCHAR2,
        P_NOMBRE  IN VARCHAR2,
        P_ID_DPTO IN NUMBER,
        P_CODIGO  OUT VARCHAR2
    );

    FUNCTION VALIDAR_QR(
        P_CODIGO IN VARCHAR2
    ) RETURN NUMBER;
END PKG_DOORS;
/

CREATE OR REPLACE PACKAGE BODY PKG_DOORS AS
    PROCEDURE GENERAR_QR(
        P_CORREO  IN VARCHAR2,
        P_NOMBRE  IN VARCHAR2,
        P_ID_DPTO IN NUMBER,
        P_CODIGO  OUT VARCHAR2
    ) IS
        V_ID_VISITA NUMBER;
        V_ID_QR     NUMBER;
        V_EXISTE    NUMBER;
        V_CORREO    VARCHAR2(150);
    BEGIN
        -- Validar correo obligatorio
        IF P_CORREO IS NULL OR TRIM(P_CORREO) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'El correo es obligatorio');
        END IF;
        V_CORREO := LOWER(TRIM(P_CORREO));

        -- Validar formato basico del correo
        IF INSTR(V_CORREO, '@') <= 1
           OR INSTR(V_CORREO, '@') = LENGTH(V_CORREO)
           OR INSTR(V_CORREO, '.') = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'El formato del correo no es valido');
        END IF;

        -- Validar nombre obligatorio
        IF P_NOMBRE IS NULL OR TRIM(P_NOMBRE) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20002, 'El nombre es obligatorio');
        END IF;

        -- Validar departamento obligatorio
        IF P_ID_DPTO IS NULL THEN
            RAISE_APPLICATION_ERROR(-20003, 'Debe indicar un departamento');
        END IF;

        -- Comprobar que el departamento exista
        SELECT COUNT(*)
        INTO V_EXISTE
        FROM DPTO
        WHERE ID_DPTO = P_ID_DPTO;

        IF V_EXISTE = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'El departamento indicado no existe');
        END IF;

        -- Registrar la visita
        INSERT INTO VISITA(NOMBRE, CORREO, ID_DPTO)
        VALUES (TRIM(P_NOMBRE), V_CORREO, P_ID_DPTO)
        RETURNING ID_VISITA INTO V_ID_VISITA;

        -- Generar un codigo unico para el QR
        P_CODIGO := RAWTOHEX(SYS_GUID());

        -- Crear QR con vigencia de 24 horas
        INSERT INTO QR(CODIGO, FECHA_EXPIRACION, ESTADO)
        VALUES (P_CODIGO, SYSTIMESTAMP + INTERVAL '24' HOUR, 'ACTIVO')
        RETURNING ID_QR INTO V_ID_QR;

        -- Asociar visita y QR
        INSERT INTO VISITA_QR(ID_VISITA, ID_QR)
        VALUES (V_ID_VISITA, V_ID_QR);
    END GENERAR_QR;

    FUNCTION VALIDAR_QR(
        P_CODIGO IN VARCHAR2
    ) RETURN NUMBER IS
        V_CANTIDAD NUMBER;
    BEGIN
        -- Si el codigo esta vacio, no es valido
        IF P_CODIGO IS NULL OR TRIM(P_CODIGO) IS NULL THEN
            RETURN 0;
        END IF;

        -- Verificar existencia, estado y vencimiento
        SELECT COUNT(*)
        INTO V_CANTIDAD
        FROM QR
        WHERE CODIGO = TRIM(P_CODIGO)
        AND ESTADO = 'ACTIVO'
        AND FECHA_EXPIRACION > SYSTIMESTAMP;
        
        IF V_CANTIDAD > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END VALIDAR_QR;
END PKG_DOORS;
/