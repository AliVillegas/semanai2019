classdef Equipo
    properties
        numControl
        nombre
        marca
        modelo
        numSerie
        proveedorCompra
        ubicacion
        fechaInstalacion
        estadoEquipo       
    end
    
    methods
        function obj = Equipo(nc,n,ma,mo,ns,pc,u,fi,ee)
             if nargin > 0
                obj.nombre = n;
                obj.marca = ma;
                obj.modelo = mo;
                obj.numSerie = ns;
                obj.numControl = nc;
                obj.proveedorCompra = pc;
                obj.ubicacion = u;
                obj.fechaInstalacion = fi;
                obj.estadoEquipo = ee;
             end
        end
    end
end

