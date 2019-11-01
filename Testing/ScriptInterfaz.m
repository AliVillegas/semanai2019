           import mlreportgen.dom.*
           D=Document('FromTemplate','docx','Reporte.dotx')
           open(D)
           moveToNextHole(D)
           append(D, "Hello World chido")
           close(D)