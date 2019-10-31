[~,~,DATA] = xlsread('Base.xlsx','Equipos');
[dataRows, dataColumns] = size(DATA);
containsNumbers = cellfun(@isnumeric,DATA);
DATA(containsNumbers) = cellfun(@num2str,DATA(containsNumbers),'UniformOutput',false);
equipos = [];
areas ={'-','INGENIERIA BIOMEDICA','MORGUE','HEMODIALISIS','RADIOTERAPIA','CUARTO DE MAQUINAS','REHABILITACION FISICA', 'ONCOLOGIA','POLICLINICA','IMAGEN','URGENCIAS','ENDOSCOPIA','MEDICINA NUCLEAR','QUIROFANO CENTRAL', 'CEyE','TERAPIA INTERMEDIA','TERAPIA INTENSIVA', 'LABOR', 'CUNERO','HOSPITALIZACION SEGUNDO PISO', 'HOSPITALIZACION TERCER PISO','FARMACIA, FLORES y REGALOS','FARMACIA, HOSPITALIZACION','ALMACEN Y SUBALMACENES','CIRUGIA', 'APOYO RESPIRATORIO'};
proveedoresDeServicio = [];
servicios = [];
modelos = [];
ubicaciones = ['-'];
dbfile = fullfile(pwd,'Inventario.db');
conn = sqlite(dbfile);
query = 'SELECT * FROM Equipo';
columnNamesProveedorServicio = {'nombre','contacto','telefono'};

%curs = fetch(conn, query);
%curs = fetch(curs);
%disp(curs.Data);

for row = 2 : dataRows
    for column = 1: 1
 foundModelExists = isempty(find(strcmp(modelos,DATA(row,column + 3)), 1));
        foundLocationExists = isempty(find(strcmp(ubicaciones,DATA(row,column + 9)), 1));
        if foundModelExists
            if ~strcmp(DATA(row,column + 3),'NaN')
               modelos = [modelos,DATA(row,column + 3)];
            end
        end
        if foundLocationExists
            if ~strcmp(DATA(row,column + 3),'NaN')
               ubicaciones = [ubicaciones,DATA(row,column + 9)];
            end
        end
        
    end
end
for row = 2 :  dataRows
    for column = 1 : 1
        nc = DATA(row,column);
        n = DATA(row,column + 1);
        ma = DATA(row,column + 2);
        mo = DATA(row,column + 3);
       % mo = find(strcmp(modelos,DATA(row,column + 3)));
        ac = DATA(row,column + 7);
        af = DATA(row,column + 8);
        ns = DATA(row,column + 4);
        pc = DATA(row,column + 6);
        u = DATA(row,column + 9);
        ar = DATA(row,column + 5);
        fi = DATA(row,column + 10);
        ee = DATA(row,column + 11);
        rc = DATA(row,column + 15);
        co = DATA(row,column + 16);
        nombre = DATA(row,column + 12);
        contacto = DATA(row,column + 13);
        telefono = DATA(row,column + 14);
        if strcmp(nombre,'NaN')
            nombre = '-';
        end
        if strcmp(contacto,'NaN')
            contacto = '-';
        end
        if strcmp(telefono,'NaN')
            telefono = '-';
        end
        if strcmp(nc,'NaN')
            nc = '';
        end
        if strcmp(af,'NaN')
            nc = '';
        end
        if strcmp(ac,'NaN')
            nc = '';
        end
        if strcmp(n,'NaN')
            n = '';
        end
        if strcmp(ar,'NaN')
            ar = '';
        end
        if strcmp(ma,'NaN')
            ma = '';
        end
        if strcmp(mo,'NaN')
            mo = '';
        end
        if strcmp(ns,'NaN')
            ns = '';
        end
        if strcmp(pc,'NaN')
            pc = '';
        end
        if strcmp(u,'NaN')
            u = '';
        end
        if strcmp(fi,'NaN')
            fi = '';
        end
        if strcmp(ee,'NaN')
            ee = '';
        end
        if strcmp(rc,'NaN')
            rc = 'NA';
        end
        if strcmp(co,'NaN')
            co = '-';
        end
        if isempty(mo)
            mo = -1;
        end
        
        [~, areaC] = size(areas);
        areaExiste = [];
        for area = 1 : areaC
            if(strcmp(string(ar),string(areas(1,area))))
                areaExiste = area;
                break
            end
        end
        if size(areaExiste) == 0
            ar = 1;
        else
            ar = areaExiste;
        end
        [~, ubicacionC] = size(ubicaciones);
        ubicacionExiste = [];
        for ubicacion = 1 : ubicacionC
            %disp(ubicacion)
            %disp(string(u))
            %disp(string(ubicaciones(1,ubicacion)))
            if(strcmp(string(u),string(ubicaciones(1,ubicacion))))
                ubicacionExiste = ubicacion;
                break
            end
        end
        if size(ubicacionExiste) == 0
            u = 1;
        else
            u = ubicacionExiste;
        end
        ps = ProveedorServicio(nombre,contacto,telefono);
        proveedorYaExiste =[];
        [proveedorR, proveedorC] = size(proveedoresDeServicio);
        
        for proveedor = 1 : proveedorC
            prS = proveedoresDeServicio(1,proveedor);
            if(strcmp(string(ps.nombre),string(prS.nombre)))
                proveedorYaExiste = proveedor;
                break
                %disp(proveedorYaExiste);
            end
        end
        
        if size(proveedorYaExiste)  == 0
           proveedoresDeServicio = [proveedoresDeServicio,ps];
           [proveedorR, proveedorC] = size(proveedoresDeServicio);
           ps = proveedorC;
        else
           ps = proveedorYaExiste;
           %disp(ps)
        end
        [eR, eC] = size(equipos);
        equipo = Equipo(nc,n,ma,mo,ns,pc,u,fi,ee,rc,co,ps,1,ar,ac,af);
        if ~strcmp(nc,'')
          equipos = [equipos,equipo];
        end
      % disp(equipo);
    end
end

months = ["Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"];



%LLENAR AREAS
[~, areaC] = size(areas);
for area = 1 : areaC
    datos = string(areas(1,area));
    insertArea = sprintf('insert into Area(nombre) values ("%s");', datos);
    exec(conn, insertArea);
end


%LLENAR UBICACIONES
[~, ubicacionC] = size(ubicaciones);
for ubicacion = 1 : ubicacionC
    datos = string(ubicaciones(1,ubicacion));
    insertUbicacion = sprintf('insert into Ubicacion(nombre) values ("%s");', datos);
    exec(conn, insertUbicacion);
end

% %LLENAR SERVICIOS
% datos = ["-", "-"];
% insertServicio = sprintf('insert into Servicio(mes,tipo) values ("%s","%s");', datos);
% exec(conn, insertServicio);
% for month = 1 : 12
%     for type = 1 : 2
%         if type == 1
%             datos = [string(months(1,month)), "Pendiente"]
%             insertServicio = sprintf('insert into Servicio(mes,tipo) values ("%s","%s");', datos);
%             exec(conn, insertServicio);
%         else
%             datos = [string(months(1,month)), "Realizado"]
%             insertServicio = sprintf('insert into Servicio(mes,tipo) values ("%s","%s");', datos);
%             exec(conn, insertServicio);
%         end
%     end
% end

%LLENAR PROVEEDORES DE SERVICIO
[proveedorR, proveedorC] = size(proveedoresDeServicio);

for prov = 1 : proveedorC
    ps = proveedoresDeServicio(1,prov);
    if ~strcmp(string(ps.nombre),'-')
         datos = [string(ps.nombre),string(ps.contacto), string(ps.telefono)]
         insertProveedorServicio = sprintf('insert into ProveedorServicio(nombre,contacto,telefono) values ("%s","%s","%s");', datos);
         exec(conn, insertProveedorServicio);
    end
end

%LLENAR EQUIPOS
[equiposR, equiposC] = size(equipos);

for equipo = 1 : equiposC
    e = equipos(1,equipo);
    datos = [string(e.equipo),string(e.marca), string(e.modelo), string(e.numSerie),string(e.accesorios),string(e.numActivoFijo),string(e.proveedorCompra),string(e.fechaInstalacion),string(e.estadoEquipo),string(e.refaccionesCambiadas),string(e.consumibles),e.proveedorServicio,e.servicio, e.ubicacion,e.area]
    insertEquipo = sprintf('insert into Equipo(equipo,marca,modelo,numeroSerie,accesorios,numActivoFijo,proveedor,fechaInstal,estado,refaccionesCambiadas,consumibles,proveedorServicio,servicio,ubicacion,area) values ("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s");', datos);
    exec(conn, insertEquipo);
end
clearvars -except areas conn
close(conn);
