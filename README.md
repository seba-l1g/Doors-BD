# DOORS BD

## Descripción

DOORS administra la información de departamentos, usuarios, visitas, códigos QR e intentos de acceso a un condominio. La base de datos incluye restricciones de integridad, un paquete PL/SQL para generar y validar códigos QR y un trigger para registrar los accesos en una bitácora.

## Tablas principales

- `DPTO`: departamentos del condominio.
- `USUARIO`: residentes, conserjes y administradores.
- `USUARIO_DPTO`: relación entre residentes y departamentos.
- `VISITA`: datos de las visitas registradas.
- `QR`: códigos QR, con fecha de generación, vencimiento y estado.
- `VISITA_QR`: relación entre visitas y códigos QR.
- `ACCESO`: intentos de acceso y su resultado.
- `LOGS`: bitácora de operaciones registradas por el trigger.

## Package `PKG_DOORS`

El paquete concentra las operaciones principales relacionadas con los códigos QR.

### `PROCEDURE GENERAR_QR`

Recibe el correo y el nombre de la visita, además del ID del departamento. Valida los datos de entrada y comprueba que el departamento exista. Luego registra la visita, genera un código QR único con una vigencia de 24 horas y relaciona el QR con la visita. El código generado se devuelve mediante el parámetro `P_CODIGO OUT`.

Si los datos no cumplen las validaciones, el procedimiento genera errores con `RAISE_APPLICATION_ERROR`.

### `FUNCTION VALIDAR_QR`

Recibe un código y comprueba que exista, que su estado sea `ACTIVO` y que no haya vencido. Devuelve `1` si es válido y `0` si no lo es.

## Trigger `TRG_LOG_ACCESO`

El trigger se ejecuta automáticamente después de cada `INSERT` en `ACCESO`. Inserta en `LOGS` la tabla afectada, la operación, el ID del acceso, el resultado registrado y la fecha del evento.

Su objetivo es mantener una **bitácora de auditoría** que permita llevar un seguimiento de los intentos de acceso registrados en el sistema. Esto facilita la revisión de eventos y la investigación de posibles problemas, sin necesidad de registrar esta información manualmente cada vez que se inserta un acceso. Además, al ejecutarse automáticamente, ayuda a mantener un registro consistente de las operaciones realizadas.

## Orden de ejecución

Ejecuta primero el script de creación de tablas y datos de prueba. Después, crea el package `PKG_DOORS` y su body, y finalmente el trigger `TRG_LOG_ACCESO`. Luego en Main verifica que los objetos estén en estado `VALID` antes de ejecutar las pruebas.
