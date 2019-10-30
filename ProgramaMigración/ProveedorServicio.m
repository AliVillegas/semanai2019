classdef ProveedorServicio
    properties
        nombre
        contacto
        telefono
    end
    
    methods
        function obj = ProveedorServicio(nombre,contacto,tel)
             if nargin > 0
                obj.nombre = nombre;
                obj.contacto = contacto;
                obj.telefono = tel;
                
             end
        end
    end
end

