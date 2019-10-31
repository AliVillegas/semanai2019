dbfile = fullfile(pwd,'Inventario.db');
conn = sqlite(dbfile);
mainQuery = 'SELECT Equipo.numControl,Equipo.equipo,Equipo.marca,Equipo.modelo,Equipo.numeroSerie,Area.nombre,Ubicacion.nombre,Equipo.proveedor,Equipo.fechaInstal,Equipo.estado,Equipo.consumibles,Equipo.refaccionesCambiadas,ProveedorServicio.nombre,ProveedorServicio.contacto,ProveedorServicio.telefono FROM Equipo JOIN Area ON Equipo.area = Area.id JOIN Ubicacion ON Equipo.ubicacion=Ubicacion.id JOIN ProveedorServicio ON Equipo.proveedorServicio = ProveedorServicio.id;'
inventario = fetch(conn,mainQuery);
disp(inventario)
palabra = "E";
buscarPorEquipo = sprintf('SELECT Equipo.numControl,Equipo.equipo,Equipo.marca,Equipo.modelo,Equipo.numeroSerie,Area.nombre,Ubicacion.nombre,Equipo.proveedor,Equipo.fechaInstal,Equipo.estado,Equipo.consumibles,Equipo.refaccionesCambiadas,ProveedorServicio.nombre,ProveedorServicio.contacto,ProveedorServicio.telefono FROM Equipo JOIN Area ON Equipo.area = Area.id JOIN Ubicacion ON Equipo.ubicacion=Ubicacion.id JOIN ProveedorServicio ON Equipo.proveedorServicio = ProveedorServicio.id WHERE Equipo.equipo LIKE "%s%%" ;',palabra);
filtroEquipo = fetch(conn,buscarPorEquipo);


areaVisible = 'Area.nombre,';
proveedorCompraVisible = 'Equipo.proveedor,';
accesoriosVisible = 'Equipo.accesorios,';
numActivoFijoVisible = 'Equipo.accesorios,';
ubicacionVisible = 'Ubicacion.nombre,';
fechaInstalVisible = 'Equipo.fechaInstal,';
estadoVisible = 'Equipo.estado,';
consumiblesVisible = 'Equipo.consumibles,'
proveedorServicioVisible = 'ProveedorServicio.nombre,';
refaccionesVisible = 'Equipo.refaccionesCambiadas,'
contactoVisible = 'ProveedorServicio.contacto,';
telefonoVisible = 'ProveedorServicio.telefono';
mainQuery = sprintf('SELECT Equipo.numControl,Equipo.equipo,Equipo.marca,Equipo.modelo,Equipo.numeroSerie,%s %s %s %s %s %s %s %s %s FROM Equipo JOIN Area ON Equipo.area = Area.id JOIN Ubicacion ON Equipo.ubicacion=Ubicacion.id JOIN ProveedorServicio ON Equipo.proveedorServicio = ProveedorServicio.id;',areaVisible,proveedorCompraVisible,fechaInstalVisible,estadoVisible,consumiblesVisible,refaccionesVisible,proveedorServicioVisible,contactoVisible,telefonoVisible);
sql = fetch(conn,mainQuery)
close(conn);
