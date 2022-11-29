workspace {

    model {
        ciudadano = person "Ciudadano"
       
    


        sistemaMonitoreo = softwareSystem "Sistema de Alerta de Sismos peruano SASpe." {
            WebApp = container "Aplicacion web"
            webAppIOTControl = container "Aplicacion de IOT control"
            webAppIGPLima = container "Aplicacion de IGP Lima"
            mobileApp = container "Aplicacion movil"
            database = container "Base de datos"
            notificacion = container "notifica"
            detector = container "Dectector"    
            acelerometro = container "Acelerometro"
            baterias = container "Baterias"{
                alimentadorEnergia = component "Alimentador de energia"
                ProcesoCarga = component "Proceso de carga"
            }
            radioFreacuencia = container "Antena de radio frecuencia"
            informacion = container "Informacion del sismo"

            PythonLanguage = container "Lenguaje de programacion"
            JavaLanguage = container "Lenguaje de programacion empresarial"


        }

        sistemaConsolidacion = softwareSystem "Sistema de consolidacion"
        sistemaProcesamientoIGP = softwareSystem "Sistema de procesamiento en IGP Lima"
        sistemaDeBorde = softwareSystem "Sistema de borde"
        sistemaNotificacion = softwareSystem "Sistema de notificacion de alerta"
        sistemaIndeci = softwareSystem "Sistema externo de indeci"
        sistemaCoen = softwareSystem "Sistema externo COEN"
        sistemaSismate = softwareSystem "Sistema externo SISMATE"
        NodeJS = softwareSystem "Software Node JS"

        sistemaAPIUbicacionMaps = softwareSystem "dashboard la ubicación georreferenciada"

        sistemaConsultas = softwareSystem "Sistema de consulta de Sismos"
        //sistemaDetector = softwareSystem "Sistema detector de sismos"
       // sistemaAcelerometro = softwareSystem "Sistema del acelerometro"

        //sistemaPanelSolar = softwareSystem "Sistema panel solar"
       // sistemaControlador = softwareSystem "Sistema controlador"
        

        ciudadano -> sistemaMonitoreo
        sistemaMonitoreo -> sistemaConsolidacion "Utiliza"
        sistemaMonitoreo -> sistemaProcesamientoIGP "Utiliza"
        sistemaMonitoreo -> sistemaNotificacion "Utiliza"
        sistemaMonitoreo -> sistemaConsultas "Utiliza"



        ciudadano -> informacion "visualiza informacion del sismo"
        informacion -> sistemaDeBorde "solicita informacion del sismo"

        ciudadano -> acelerometro "Recolecta informacion de la acelaracion"
        acelerometro -> sistemaDeBorde "solicita la informacion de la aceleracion"

        sistemaDeBorde -> database "consulta datos"
        sistemaDeBorde -> webAppIOTControl "Ejecuta la aplicacion"

        sistemaDeBorde -> baterias "identifica el estado de las baterias"
        sistemaConsolidacion -> database "consulta datos"
        sistemaConsolidacion -> webAppIGPLima "triangula informacion de transmision a transmision"
        sistemaConsolidacion -> PythonLanguage "Usa"

        webAppIGPLima -> database "consulta datos"
        webAppIGPLima -> notificacion "notifica alerta"
        notificacion -> sistemaNotificacion "notifica nueva alerta"
        webAppIGPLima -> PythonLanguage "Usa"
        webAppIGPLima -> JavaLanguage "Usa"


        sistemaNotificacion -> sistemaIndeci "Se comunica con INDECI"
        sistemaNotificacion -> sistemaCoen "Se comunica con COEN"
        sistemaMonitoreo -> NodeJS "Hecha con Nodejs"


        WebApp -> sistemaNotificacion "Visualiza alertas"
        mobileApp -> sistemaNotificacion "Visualiza alertas"

        radioFreacuencia -> sistemaDeBorde "Comunicacion"
        notificacion -> sistemaNotificacion "visualiza alertas"
        sistemaNotificacion -> database "Guardar alertas"
        

        sistemaProcesamientoIGP -> database "Almacena alertas sismicas"
        sistemaProcesamientoIGP -> sistemaAPIUbicacionMaps "soliticita mostrar un dashboard de la ubicacion georreferenciada"

        sistemaProcesamientoIGP -> notificacion "notifica alerta"
        notificacion -> sistemaNotificacion "alerta notificada "

        sistemaNotificacion -> sistemaIndeci "alerta telefonica"
        sistemaNotificacion -> sistemaCoen "alerta telefonica"



    }
      views {
            systemContext sistemaMonitoreo {
                include *
                autolayout lr
            }
            container sistemaMonitoreo {
                include *
                autoLayout lr
            }
            component baterias {
                include *
                autolayout lr
            }


            theme default    
        }
        
}