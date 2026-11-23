use("DOORS_DB");
if (!db.getCollectionNames().includes("invitaciones")) {
    db.createCollection("invitaciones");
}

// Insertar una invitacion individual con insertOne
db.invitaciones.insertOne({
    codigoInvitacion: "INV-0001",
    residente: {
        residenteId: "RES-001",
        nombre: "Sebastian Barros",
        rut: "12.345.678-9",
        departamento: "304",
        torre: "A"
    },
    visita: {
        nombre: "Camila Soto",
        correo: "camila@email.com"
    },
    qr: {
        token: "QR-TOKEN-001",
        estado: "ACTIVO",
        fechaGeneracion: ISODate("2026-11-23T12:00:00Z")
    },
    vigencia: {
        fechaInicio: ISODate("2026-11-24T14:00:00Z"),
        fechaFin: ISODate("2026-11-24T22:00:00Z")
    },
    tipoVisita: "FAMILIAR",
    acompanantes: [
        { nombre: "Pedro Soto" },
        { nombre: "Ana Soto" }
    ],
    accesos: [],
    intentosValidacion: 0,
    estado: "ACTIVA",
    fechaCreacion: ISODate("2026-11-23T12:00:00Z")
});

// Insertar nueve invitaciones adicionales con insertMany
db.invitaciones.insertMany([
    {
        codigoInvitacion: "INV-0002",
        residente: {
            residenteId: "RES-002",
            nombre: "Maria Gonzalez",
            rut: "15.222.333-4",
            departamento: "102",
            torre: "B"
        },
        visita: {
            nombre: "Pedro Ramirez",
            correo: "pedro@email.com"
        },
        qr: {
            token: "QR-TOKEN-002",
            estado: "ACTIVO",
            fechaGeneracion: ISODate("2026-11-23T13:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-25T10:00:00Z"),
            fechaFin: ISODate("2026-11-25T18:00:00Z")
        },
        tipoVisita: "AMISTAD",
        acompanantes: [
            { nombre: "Laura Ramirez" }
        ],
        accesos: [],
        intentosValidacion: 1,
        observacionInterna: "Campo temporal de prueba",
        estado: "ACTIVA",
        fechaCreacion: ISODate("2026-11-23T13:00:00Z")
    },
    {
        codigoInvitacion: "INV-0003",
        residente: {
            residenteId: "RES-003",
            nombre: "Carlos Muñoz",
            rut: "16.444.555-6",
            departamento: "205",
            torre: "A"
        },
        visita: {
            nombre: "Jorge Perez",
            correo: "jorge@email.com"
        },
        qr: {
            token: "QR-TOKEN-003",
            estado: "ACTIVO",
            fechaGeneracion: ISODate("2026-11-23T14:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-26T09:00:00Z"),
            fechaFin: ISODate("2026-11-26T17:00:00Z")
        },
        tipoVisita: "PROVEEDOR",
        acompanantes: [],
        accesos: [],
        intentosValidacion: 0,
        estado: "ACTIVA",
        fechaCreacion: ISODate("2026-11-23T14:00:00Z")
    },
    {
        codigoInvitacion: "INV-0004",
        residente: {
            residenteId: "RES-001",
            nombre: "Sebastian Barros",
            rut: "12.345.678-9",
            departamento: "304",
            torre: "A"
        },
        visita: {
            nombre: "Daniela Torres",
            correo: "daniela@email.com"
        },
        qr: {
            token: "QR-TOKEN-004",
            estado: "ACTIVO",
            fechaGeneracion: ISODate("2026-11-23T15:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-27T12:00:00Z"),
            fechaFin: ISODate("2026-11-27T20:00:00Z")
        },
        tipoVisita: "FAMILIAR",
        acompanantes: [
            { nombre: "Pedro Soto" },
            { nombre: "Ana Soto" }
        ],
        accesos: [
            {
                tipo: "INGRESO",
                fecha: ISODate("2026-11-27T13:00:00Z"),
                resultado: "AUTORIZADO",
                observacion: "Ingreso registrado"
            },
            {
                tipo: "SALIDA",
                fecha: ISODate("2026-11-27T16:00:00Z"),
                resultado: "AUTORIZADO",
                observacion: "Salida registrada"
            }
        ],
        intentosValidacion: 2,
        estado: "COMPLETADA",
        fechaCreacion: ISODate("2026-11-23T15:00:00Z")
    },
    {
        codigoInvitacion: "INV-0005",
        residente: {
            residenteId: "RES-004",
            nombre: "Ana Martinez",
            rut: "17.555.666-7",
            departamento: "401",
            torre: "C"
        },
        visita: {
            nombre: "Francisco Diaz",
            correo: "francisco@email.com"
        },
        qr: {
            token: "QR-TOKEN-005",
            estado: "CANCELADO",
            fechaGeneracion: ISODate("2026-11-23T16:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-28T10:00:00Z"),
            fechaFin: ISODate("2026-11-28T18:00:00Z")
        },
        tipoVisita: "AMISTAD",
        acompanantes: [],
        accesos: [],
        intentosValidacion: 0,
        estado: "CANCELADA",
        fechaCreacion: ISODate("2026-11-23T16:00:00Z")
    },
    {
        codigoInvitacion: "INV-0006",
        residente: {
            residenteId: "RES-002",
            nombre: "Maria Gonzalez",
            rut: "15.222.333-4",
            departamento: "102",
            torre: "B"
        },
        visita: {
            nombre: "Valentina Rojas",
            correo: "valentina@email.com"
        },
        qr: {
            token: "QR-TOKEN-006",
            estado: "ACTIVO",
            fechaGeneracion: ISODate("2026-11-23T17:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-29T11:00:00Z"),
            fechaFin: ISODate("2026-11-29T19:00:00Z")
        },
        tipoVisita: "FAMILIAR",
        acompanantes: [
            { nombre: "Javiera Rojas" }
        ],
        accesos: [],
        intentosValidacion: 3,
        estado: "ACTIVA",
        fechaCreacion: ISODate("2026-11-23T17:00:00Z")
    },
    {
        codigoInvitacion: "INV-0007",
        residente: {
            residenteId: "RES-005",
            nombre: "Diego Fernandez",
            rut: "18.666.777-8",
            departamento: "502",
            torre: "C"
        },
        visita: {
            nombre: "Ignacio Silva",
            correo: "ignacio@email.com"
        },
        qr: {
            token: "QR-TOKEN-007",
            estado: "EXPIRADO",
            fechaGeneracion: ISODate("2026-11-20T10:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-20T12:00:00Z"),
            fechaFin: ISODate("2026-11-20T20:00:00Z")
        },
        tipoVisita: "PROVEEDOR",
        acompanantes: [],
        accesos: [],
        intentosValidacion: 1,
        estado: "EXPIRADA",
        fechaCreacion: ISODate("2026-11-20T10:00:00Z")
    },
    {
        codigoInvitacion: "INV-0008",
        residente: {
            residenteId: "RES-003",
            nombre: "Carlos Muñoz",
            rut: "16.444.555-6",
            departamento: "205",
            torre: "A"
        },
        visita: {
            nombre: "Fernanda Lopez",
            correo: "fernanda@email.com"
        },
        qr: {
            token: "QR-TOKEN-008",
            estado: "ACTIVO",
            fechaGeneracion: ISODate("2026-11-23T18:00:00Z")
        },
        vigencia: {
            fechaInicio: ISODate("2026-11-30T14:00:00Z"),
            fechaFin: ISODate("2026-11-30T22:00:00Z")
        },
        tipoVisita: "AMISTAD",
        acompanantes: [
            { nombre: "Matias Lopez" },
            { nombre: "Sofia Lopez" }
        ],
        accesos: [],
        intentosValidacion: 0,
        estado: "ACTIVA",
        fechaCreacion: ISODate("2026-11-23T18:00:00Z")
    },
    {
        codigoInvitacion: "TEST-001",
        residente: {
            residenteId: "RES-001",
            nombre: "Sebastian Barros",
            rut: "12.345.678-9",
            departamento: "304",
            torre: "A"
        },
        visita: {
            nombre: "Visita de prueba uno",
            correo: "prueba1@email.com"
        },
        qr: {
            token: "QR-TEST-001",
            estado: "CANCELADO",
            fechaGeneracion: new Date()
        },
        vigencia: {
            fechaInicio: new Date(),
            fechaFin: new Date()
        },
        tipoVisita: "PRUEBA",
        acompanantes: [],
        accesos: [],
        intentosValidacion: 0,
        estado: "CANCELADA",
        fechaCreacion: new Date()
    },
    {
        codigoInvitacion: "TEST-002",
        residente: {
            residenteId: "RES-002",
            nombre: "Maria Gonzalez",
            rut: "15.222.333-4",
            departamento: "102",
            torre: "B"
        },
        visita: {
            nombre: "Visita de prueba dos",
            correo: "prueba2@email.com"
        },
        qr: {
            token: "QR-TEST-002",
            estado: "CANCELADO",
            fechaGeneracion: new Date()
        },
        vigencia: {
            fechaInicio: new Date(),
            fechaFin: new Date()
        },
        tipoVisita: "PRUEBA",
        acompanantes: [],
        accesos: [],
        intentosValidacion: 0,
        estado: "CANCELADA",
        fechaCreacion: new Date()
    }
]);

// Contar documentos totales
print(db.invitaciones.countDocuments());

// Consultar todas las invitaciones
db.invitaciones.find();

// Consultar invitaciones activas
db.invitaciones.find({
    estado: "ACTIVA"
});

// Consultar por rango de fechas
db.invitaciones.find({
    "vigencia.fechaInicio": {
        $gte: ISODate("2026-11-24T00:00:00Z"),
        $lte: ISODate("2026-11-28T23:59:59Z")
    }
});

// Consultar varios tipos de visita con IN
db.invitaciones.find({
    tipoVisita: {$in: ["FAMILIAR", "AMISTAD"]}
});

// Consultar invitaciones que tengan ambos acompanantes con ALL
db.invitaciones.find({
    acompanantes: {
        $all: [
            { nombre: "Pedro Soto" },
            { nombre: "Ana Soto" }
        ]
    }
});

// Excluir estados con NIN
db.invitaciones.find({
    estado: {$nin: ["CANCELADA", "EXPIRADA"]}
});

// Consultar un subdocumento
db.invitaciones.find({
    "residente.departamento": "304"
});

// Consultar con OR
db.invitaciones.find({
    $or: [
        { tipoVisita: "PROVEEDOR" },
        { estado: "CANCELADA" }
    ]
});

// Mostrar campos seleccionados y ocultar ID
db.invitaciones.find(
    {},
    {
        _id: 0,
        codigoInvitacion: 1,
        "visita.nombre": 1,
        estado: 1
    }
);

// Ordenar por fecha de creacion
db.invitaciones.find().sort({
    fechaCreacion: -1
});

// Limitar resultados
db.invitaciones.find().limit(3);

// Obtener tipos de visita sin repetir
db.invitaciones.distinct("tipoVisita");

// UPDATE
// Modificar una invitacion con SET
db.invitaciones.updateOne(
    { codigoInvitacion: "INV-0001" },
    {
        $set: {"visita.correo": "camila.soto@email.com"}
    }
);

// Incrementar los intentos de validacion con INC
db.invitaciones.updateOne(
    { codigoInvitacion: "INV-0001" },
    {
        $inc: {intentosValidacion: 1}
    }
);

// Eliminar un campo con UNSET
db.invitaciones.updateOne(
    { codigoInvitacion: "INV-0002" },
    {
        $unset: {observacionInterna: ""}
    }
);

// Agregar un movimiento al arreglo con PUSH
db.invitaciones.updateOne(
    { codigoInvitacion: "INV-0001" },
    {
        $push: {
            accesos: {
                tipo: "INGRESO",
                fecha: new Date(),
                resultado: "AUTORIZADO",
                observacion: "Ingreso registrado"
            }
        }
    }
);

// Actualizar varias invitaciones con updateMany
db.invitaciones.updateMany(
    { estado: "ACTIVA" },
    {
        $set: {revisionRealizada: true}
    }
);

// Comprobar las actualizaciones
db.invitaciones.find(
    { codigoInvitacion: "TEST-001" }
);

// DELETE
// Eliminar una invitacion de prueba
db.invitaciones.deleteOne({
    codigoInvitacion: "TEST-001"
});

// Eliminar las invitaciones de prueba restantes
db.invitaciones.deleteMany({
    tipoVisita: "PRUEBA",
    estado: "CANCELADA"
});