# DOORS BD

## Descripción

DOORS es una base de datos para administrar la información de un condominio, incluyendo departamentos, usuarios, residentes, visitas, códigos QR y registros de acceso.

La base de datos incorpora restricciones de integridad, un paquete PL/SQL para generar y validar códigos QR y un trigger que registra automáticamente los accesos autorizados en una bitácora de auditoría.

## Tablas principales

- `USUARIO`: almacena los datos de los usuarios, incluyendo nombre, correo y tipo de usuario.
- `RESIDENTE`: contiene la información de los residentes, como RUT, teléfono y estado.
- `VIVIENDA`: almacena los datos de las viviendas del condominio.
- `RESIDENTE_VIVIENDA`: relaciona a los residentes con sus viviendas.
- `VISITA`: registra las visitas y el residente al que están asociadas.
- `QR`: almacena los códigos QR, sus fechas de inicio y vencimiento, y su estado.
- `ACCESO`: registra los accesos autorizados mediante un código QR válido.
- `LOGS`: mantiene una bitácora con información del acceso, usuario, tipo de usuario, vivienda, fecha, código QR, resultado y motivo del evento.

## Package `PKG_DOORS`

El paquete concentra las operaciones principales relacionadas con la generación y validación de códigos QR.

### `PROCEDURE GENERAR_QR`

Recibe el correo y el nombre de la visita, además del ID del residente que autoriza la visita.

El procedimiento valida que el nombre y el correo no estén vacíos y comprueba que el residente exista y se encuentre activo. Luego registra al usuario visitante, crea la visita asociada al residente y genera un código QR único con una vigencia de 24 horas.

Finalmente, relaciona el código con la visita y devuelve el QR generado mediante el parámetro `P_CODIGO OUT`.

Si los datos no cumplen las validaciones, se generan errores mediante `RAISE_APPLICATION_ERROR`.

### `FUNCTION VALIDAR_QR`

Recibe un código QR y comprueba que exista, que su estado sea `ACTIVO` y que se encuentre dentro de su período de vigencia.

- Devuelve `1` si el QR es válido y registra el acceso en la tabla `ACCESO`.
- Devuelve `0` si el QR no existe, está vencido o no se encuentra activo.

La función se ejecuta desde un bloque PL/SQL para permitir el registro del acceso cuando la validación es exitosa.

## Trigger `TRG_LOG_ACCESO`

El trigger se ejecuta automáticamente después de cada inserción en la tabla `ACCESO`.

Cuando se registra un acceso, obtiene los datos relacionados con el QR, la visita, el usuario y la vivienda asociada al residente. Luego inserta en `LOGS` la información correspondiente al evento, incluyendo:

- ID del acceso.
- ID y tipo de usuario.
- ID de la vivienda asociada.
- Fecha y hora del registro.
- Código QR utilizado.
- Resultado de la operación.
- Motivo del registro.

De esta manera, cada acceso autorizado queda registrado tanto en `ACCESO` como en `LOGS`, sin necesidad de insertar manualmente los datos en la bitácora.

El trigger permite mantener un registro consistente de los eventos y facilita la revisión de los accesos realizados en el condominio.

## Orden de ejecución

1. Ejecutar el script de creación de tablas y los datos de prueba.
2. Crear el package `PKG_DOORS`.
3. Crear el body del package con las implementaciones de `GENERAR_QR` y `VALIDAR_QR`.
4. Crear el trigger `TRG_LOG_ACCESO`.
5. Verificar que los objetos estén en estado `VALID`.
6. Ejecutar las pruebas de generación y validación de códigos QR.
7. Consultar las tablas `ACCESO` y `LOGS` para comprobar que los registros se hayan generado correctamente.

## Consultas de verificación

```sql
-- Consultar los accesos registrados
SELECT *
FROM ACCESO
ORDER BY ID_ACCESO DESC;

-- Consultar la bitácora de auditoría
SELECT *
FROM LOGS
ORDER BY ID_LOGS DESC;
```

## Consideraciones

- Los códigos QR tienen una vigencia de 24 horas desde su generación.
- Solo los códigos QR activos y vigentes permiten registrar un acceso.
- El trigger registra automáticamente los accesos autorizados que se insertan en `ACCESO`.
- Los registros antiguos no se actualizan automáticamente al modificar el trigger.
- Para evitar errores, se deben respetar las relaciones y restricciones de integridad definidas en la base de datos.