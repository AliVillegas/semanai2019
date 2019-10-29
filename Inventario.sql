CREATE TABLE "Equipo" (
	equipo	TEXT,
	marca	TEXT,
	modelo	TEXT,
	numeroSerie	TEXT,
	numControl	TEXT,
	proveedor	TEXT,
	fechaInstal	TEXT,
	estado	TEXT,
    refaccionesCambiadas	TEXT,
    proveedorServicio TEXT,
    servicio INTEGER,
    FOREIGN KEY(servicio) REFERENCES Servicio(ser_id),
  	FOREIGN KEY(proveedorServicio) REFERENCES ProvedorServicio(nombre),
	PRIMARY KEY(numControl)
);
CREATE TABLE "OrdenServicio" (
	departamento	TEXT,
	folio	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
	Equipo	TEXT,
	fechaSolicitud	TEXT,
	fechaTerminacion	TEXT,
	quienReporta	TEXT,
	fallaReportada	TEXT,
	Recibe	TEXT,
	asignadoA	TEXT,
	trabajoRealizado	TEXT,
	tipoFallaEncontrada	TEXT,
	partesNuevas	TEXT,
	observaciones	TEXT,
	horasIngeniero	INTEGER,
	costoRefacciones	NUMERIC,
	costoServicioExterno	NUMERIC,
	recibidoConfirmidadPor	TEXT,
	fecha	TEXT,
	comentarios	TEXT,
	FOREIGN KEY(Equipo) REFERENCES Equipo(numControl)
);
CREATE TABLE "ProveedorServicio" (
	nombre	TEXT UNIQUE,
	contacto	TEXT,
	telefono	INTEGER,
	id	INTEGER PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE "Servicio" (
	mes	TEXT UNIQUE,
	tipo	TEXT UNIQUE,
    ser_Id integer PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE "Inventario" (
  Equipo TEXT UNIQUE,
  Area TEXT,
  Ubicacion TEXT,
  FOREIGN KEY(Equipo) REFERENCES Equipo(numControl)
);