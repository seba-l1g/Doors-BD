# DOOR'S --- Modelo documental con MongoDB

Sistema de control de acceso para condominios mediante invitaciones
digitales y códigos QR.

## Descripción del proyecto

DOOR'S busca mejorar la gestión de visitas en condominios, reemplazando
los registros manuales por invitaciones digitales con códigos QR
temporales.

Esta evaluación desarrolla un modelo de base de datos NoSQL utilizando
MongoDB. Cada documento representa una invitación creada por un
residente e incluye la información de la visita, el código QR, su
vigencia, los acompañantes y el historial de movimientos de acceso.

## Tecnologías utilizadas

-   **MongoDB:** gestor de base de datos NoSQL.
-   **MongoDB Atlas:** plataforma para alojar y administrar la base de
    datos en la nube.
-   **Visual Studio Code:** entorno de trabajo.
-   **MongoDB for VS Code:** extensión utilizada para conectarse a
    MongoDB.
-   **MongoDB Playground:** ejecución de consultas y operaciones CRUD.

## Modelo de datos

-   **Base de datos:** `DOORS_DB`
-   **Colección:** `invitaciones`
-   **Tipo de base de datos:** No relacional (NoSQL).
-   **Modelo de datos:** Documental.

Cada documento representa una invitación e incluye:

-   Datos del residente que autoriza la visita.
-   Nombre y correo de la visita.
-   Información del código QR y su estado.
-   Fecha de inicio y término de la vigencia.
-   Lista de acompañantes.
-   Historial de ingresos y salidas.
-   Estado general de la invitación.

Se utilizan **subdocumentos** (`{}`) para agrupar información
relacionada y **arreglos** (`[]`) para almacenar acompañantes y
movimientos de acceso.

## Reglas principales del negocio

-   Cada documento representa una invitación creada por un residente.
-   El QR utiliza un token aleatorio que no contiene datos personales.
-   El QR permite registrar múltiples ingresos y salidas durante la
    vigencia.
-   Cada movimiento se almacena en el arreglo `accesos`.
-   La invitación puede estar en estado `ACTIVA`, `CANCELADA`,
    `EXPIRADA` o `COMPLETADA`.
-   Las invitaciones canceladas, expiradas o completadas no deben
    autorizar nuevos movimientos.

## Operaciones CRUD

La evaluación demuestra las operaciones principales sobre la colección
`invitaciones`:

  Operación   Métodos utilizados
  ----------- -------------------------------
  CREATE      `insertOne()`, `insertMany()`
  READ        `find()`, `distinct()`
  UPDATE      `updateOne()`, `updateMany()`
  DELETE      `deleteOne()`, `deleteMany()`

También se utilizan operadores de consulta y actualización como `$gte`,
`$lte`, `$in`, `$all`, `$nin`, `$or`, `$set`, `$inc`, `$unset` y
`$push`.

## Estructura del repositorio

``` text
DOORS-MongoDB/
├── DOORS_MongoDB.mongodb.js
├── README.md
├── Informe_DOORS_MongoDB.pdf
└── Presentacion_DOORS_MongoDB.pdf
```

> Los nombres y archivos de esta estructura pueden ajustarse a los
> archivos que finalmente se suban al repositorio.

## Ejecución

1.  Clonar o descargar este repositorio.
2.  Abrir el proyecto en Visual Studio Code.
3.  Instalar y configurar la extensión MongoDB for VS Code.
4.  Conectarse al cluster de MongoDB Atlas.
5.  Abrir el archivo `DOORS_MongoDB.mongodb.js` desde MongoDB
    Playground.
6.  Ejecutar el script para crear la colección, insertar documentos y
    demostrar las operaciones CRUD.

## Contexto académico

Proyecto desarrollado para la asignatura **Taller de Base de Datos**,
como evaluación práctica de diseño documental y operaciones CRUD con
MongoDB.
