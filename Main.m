[~,~,DATA] = xlsread('Base.xlsx','Equipos');
[dataRows, dataColumns] = size(DATA);
containsNumbers = cellfun(@isnumeric,DATA);
DATA(containsNumbers) = cellfun(@num2str,DATA(containsNumbers),'UniformOutput',false);
equipos = [];
areas =['INGENIERÍA BIOMÉDICA','MORGUE','HEMODIALISIS','RADIOTERAPIA','CUARTO DE MÁGUINAS','REHABILITACIÓN FÍSICA', 'ONCOLOGÍA','POLÍCLINICA','IMAGEN','URGENCIAS','ENDOSCOPÍA','MEDICINA NUCLEAR','QUIRÓFANO CENTRAL', 'CEYE','TERAPIA INTERMEDIA','QUIRÓFANO CENTRAIL', 'CEYE','TERAPIA INTERMEDIA','TERAPIA INTENSIVA', 'LABOR', 'CUNERO','HOSPITALIZACIÓN SEGUNDO PISO', 'HOSPITALICACIÓN TERCER PISO','FARMACIA,FLORES y REGALOS','FARMACIA,HOSPITALIZACIÓN','ALMACEN y SUBALMACENES', 'APOYO RESPIRATORIO'];
proveedoresDeCompra = [];
modelos = [];
ubicaciones = [];
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
        mo = find(strcmp(modelos,DATA(row,column + 3)));
        ns = DATA(row,column + 4);
        pc = DATA(row,column + 6);
        u = DATA(row,column + 9);
        fi = DATA(row,column + 10);
        ee = DATA(row,column + 11);
        rc = DATA(row,column + 14);
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
        if isempty(mo)
            mo = -1;
        end
        if ~strcmp(nc,'')
            equipo = Equipo(nc,n,ma,mo,ns,pc,u,fi,ee);
            equipos = [equipos,equipo];
        end
        disp(equipo);
    end
end




%{
if column == 1 %% num de Control 
end
if column == 2 %% Equipo
end
if column == 3 %% marca
end
if column == 4 %% Modelo
      disp(x);
end
if column == 5 %% num Serie
      disp(x);
end
if column == 6 %% area
      disp(x);
end
if column == 7 %% Proveedor de Compra
      disp(x);
end

if column == 8 %% Accesorios
      disp(x);
end

if column == 9 %% Num activo fijo
      disp(x);
end

if column == 10 %% Ubicacion
      disp(x);
end
if column == 11 %% fecha de instalacion
      disp(x);
end
if column == 12 %% Estado
      disp(x);
end
if column == 13 %% Proveedor de servicio 
      disp(x);
end
if column == 14 %% Contacto
      disp(x);
end
if column == 15 %% tel
      disp(x);
end
if column == 16 %% refacciones
      disp(x);
end
if column == 17 %% consumibles
      disp(x);
end
%}