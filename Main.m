[~,~,DATA] = xlsread('Base.xlsx','Equipos');
[dataRows, dataColumns] = size(DATA);
containsNumbers = cellfun(@isnumeric,DATA);
DATA(containsNumbers) = cellfun(@num2str,DATA(containsNumbers),'UniformOutput',false);
equipos = [];
areas =['INGENIER�A BIOM�DICA','MORGUE','HEMODIALISIS','RADIOTERAPIA','CUARTO DE M�GUINAS','REHABILITACI�N F�SICA', 'ONCOLOG�A','POL�CLINICA','IMAGEN','URGENCIAS','ENDOSCOP�A','MEDICINA NUCLEAR','QUIR�FANO CENTRAL', 'CEYE','TERAPIA INTERMEDIA','QUIR�FANO CENTRAIL', 'CEYE','TERAPIA INTERMEDIA','TERAPIA INTENSIVA', 'LABOR', 'CUNERO','HOSPITALIZACI�N SEGUNDO PISO', 'HOSPITALICACI�N TERCER PISO','FARMACIA,FLORES y REGALOS','FARMACIA,HOSPITALIZACI�N','ALMACEN y SUBALMACENES', 'APOYO RESPIRATORIO'];
proveedoresDeServicio = [];
modelos = [];
ubicaciones = [];
dbfile = fullfile(pwd,'Inventario.db');
conn = sqlite(dbfile);
query = 'SELECT * FROM Equipo';
columnNamesProveedorServicio = {'nombre','contacto','telefono'};

%curs = fetch(conn, query);
%curs = fetch(curs);
%disp(curs.Data);
for row = 2 :  dataRows
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
    for column = 1 : 1
        nc = DATA(row,column);
        n = DATA(row,column + 1);
        ma = DATA(row,column + 2);
        mo = DATA(row,column + 3);
       % mo = find(strcmp(modelos,DATA(row,column + 3)));
        ns = DATA(row,column + 4);
        pc = DATA(row,column + 6);
        u = DATA(row,column + 9);
        fi = DATA(row,column + 10);
        ee = DATA(row,column + 11);
        rc = DATA(row,column + 15);
        nombre = DATA(row,column + 12);
        contacto = DATA(row,column + 13);
        telefono = DATA(row,column + 14);
        if strcmp(nombre,'NaN')
            nombre = '';
        end
        if strcmp(contacto,'NaN')
            contacto = '';
        end
        if strcmp(telefono,'NaN')
            telefono = '';
        end
        if strcmp(nc,'NaN')
            nc = '';
        end
        if strcmp(n,'NaN')
            n = '';
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
            rc = '';
        end
        if isempty(mo)
            mo = -1;
        end
        ps = ProveedorServicio(nombre,contacto,telefono);
        proveedorYaExiste =[];
        [proveedorR, proveedorC] = size(proveedoresDeServicio);
        if size(proveedoresDeServicio) == 0
           proveedoresDeServicio = [proveedoresDeServicio,ps];
        else
            %%PROVEEDOR SIEMPRE ES 1
            for proveedor = 1 : proveedorC
                prS = proveedoresDeServicio(1,proveedor);
                if(strcmp(ps.nombre,prS.nombre))
                    proveedorYaExiste = proveedor;
                    break
                    %disp(proveedorYaExiste);
                end
            end
        end
        if size(proveedorYaExiste)  == 0
           proveedoresDeServicio = [proveedoresDeServicio,ps];
        else
           if size(proveedoresDeServicio) > 0
                ps = proveedoresDeServicio(1,proveedorYaExiste);
           end
           %disp(ps)
        end
        
        if ~strcmp(nc,'')
            equipo = Equipo(nc,n,ma,mo,ns,pc,u,fi,ee,rc,ps);
            equipos = [equipos,equipo];
        end
       % disp(equipo);
    end
end
[proveedorR, proveedorC] = size(proveedoresDeServicio);

for prov = 1 : proveedorC
    ps = proveedoresDeServicio(1,prov);
    insert(conn,'ProveedorServicio', columnNamesProveedorServicio,  {ps.nombre,ps.contacto,ps.telefono});
end

close(conn);