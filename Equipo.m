classdef Equipo
    properties
        numControl
        equipo
        marca
        modelo
        numSerie
        proveedorCompra
        ubicacion
        fechaInstalacion
        estadoEquipo  
        refaccionesCambiadas
        provedorServicio = ProveedorServicio
    end
    
    methods
        function obj = Equipo(nc,n,ma,mo,ns,pc,u,fi,ee,rc,ps)
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
                obj.provedorServicio = ps;
             end
        end
    end
end

