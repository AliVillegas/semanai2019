classdef Equipo
    properties
        numControl
        equipo
        marca
        modelo
        numSerie
        proveedorCompra
        ubicacion
        accesorios
        numActivoFijo
        fechaInstalacion
        estadoEquipo  
        refaccionesCambiadas
        consumibles
        proveedorServicio
        servicio
        area
    end
    
    methods
        function obj = Equipo(nc,n,ma,mo,ns,pc,u,fi,ee,rc,co,ps,se,ar,ac,af)
             if nargin > 0
                obj.equipo = n;
                obj.marca = ma;
                obj.modelo = mo;
                obj.numSerie = ns;
                obj.numControl = nc;
                obj.proveedorCompra = pc;
                obj.ubicacion = u;
                obj.fechaInstalacion = fi;
                obj.estadoEquipo = ee;
                obj.refaccionesCambiadas = rc;
                obj.proveedorServicio = ps;
                obj.servicio = se;
                obj.area = ar;
                obj.consumibles = co;
                obj.accesorios = ac; 
                obj.numActivoFijo = af;
             end
        end
    end
end

