dbfile = fullfile(pwd,'Inventario.db');
conn = sqlite(dbfile);
query = 'SELECT * FROM Equipo';
equipos = fetch(conn,query);

close(conn);