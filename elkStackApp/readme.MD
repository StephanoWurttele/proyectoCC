# Elastic Stack
Elastic stack es una tecnología que usa Elasticsearch, Logstash, Kibana y Beats para el monitoreo, análisis y visualización de datos a escala. Esta tecnología puede ser usada para múltiples propósitos y uno de los principales es el de SIEM en equipos de seguridad. Algunas de sus características más relevantes son:
	- Escalamiento Horizontal
	- Clúster y alta disponibilidad
	- Monitoreo y alerta en múltiples partes del stack
	- Múltiples tipos de datos 
	- Compatible con múltiples sistemas operativos
	- Recolección de datos de red, sistema y de seguridad.
	- etc.

## Arquitectura

El primer componente que tiene contacto con el servidor es Beats, un agente que se encarga de enviar los datos al servidor de recolección (Elasticsearch o Logstash). Este agente se configura para enviar los distintos tipos de eventos. Después se encuentra Logstash, este componente se encarga del parseado y transformación de los datos. Por otro lado, estos datos son enviados a Elasticsearch, el motor de búsqueda y analítica de datos. Finalmente, Kibana se encarga de la visualización de los datos.


![Arquitectura de Elactic Stack](./images/architecture.png)


## Funcionalidad

El caso de uso para este proyecto es el de SIEM (Security Information and Event Management) en este caso los agentes Beats recolectan datos de seguridad como eventos de sistema de Windows y Linux. Estos eventos son procesados para identificar comportamientos anómalos o para su análisis en respuesta de incidentes de ciberseguridad.

## Despliegue

Para el despliegue se usan los siguientes comandos:
### Elastic pod	
1. ```helm repo add elastic https://helm.elastic.co```
2. ```helm repo update```
3. ```helm search hub elasticsearch```
4. ```helm install elasticsearch --version 7.17.3 elastic/elasticsearch -f values_elastic.yaml```
5. ```kubectl port-forward svc/elasticsearch-master 9200:9200 --address='0.0.0.0'```

### Definir credenciales de elastic
1. ```kubectl exec --stdin --tty elasticsearch-master-0 -- /bin/bash```
1. ```cd bin```
2. ```./elasticsearch-setup-passwords interactive```
3. Definir contraseñas para cada servicio. Importante no olvidarlas, pues de ser así deberá creerse el pod nuevamente.

### Filebeat pod
1. ```curl http://localhost:9200/ -u <user>:<password>```
2. ```helm install filebeat --version 7.17.3 elastic/filebeat -f values_filebeat.yaml```
3. ```curl http://localhost:9200/_cat/indices -u <user>:<password>```
### Kibana pod
1. ```helm install kibana --version 7.17.3 elastic/kibana```
2. ```kubectl port-forward svc/kibana-kibana 5601:5601```
### Configurar cowrie
1. Iniciar una VM e [instalar cowrie](https://cowrie.readthedocs.io/en/latest/INSTALL.html)
2. Ingresar a ```cowrie/var/log/cowrie```
3. Descargar [Elastic Agent](https://www.elastic.co/downloads/past-releases/elastic-agent-7-17-3) y descomprimir en esa carpeta
4. Ingresar a carpeta descomprimida, ingresar a elastic-agent.yml, y modificar el host ip al ip del host donde se ejecuta elastic, junto a su puerto.
5. Ejecutar ```./elastic-agent install```
5. Copiar dirección de archivo cowrie.log para siguiente paso
### Añadir custom log para recibir de cowrie
1. Ingresar a Add Integrations y elegir [Custom Logs](http://localhost:5601/app/fleet/integrations/log-1.1.0/add-integration)
2. Integration name: cowrie
3. Llenar log file path con direccion de cowrie.log (direccion completa desde root)
### Casi listo
1. A este punto ya deberías poder ver los logs dirigiendote a las tres barras de la izquierda, observability, y logs. 
2. Para poder ver la información de un login que tu hagas, debes regresar a la maquina virtual e ir a cowrie. Dentro de la carpeta bin, cambiar el usuario a cowrie con ```su cowrie``` y ejecutar ```cowrie start```
3. Desde este punto, puedes realizar una conexión ssh en el puerto 2222 y mandar contraseñas para intentar hacer un login. Estas contraseñas enviadas serán registradas en el log y mostradas en Kibana.

[Link a tutorial](https://www.linode.com/docs/guides/how-to-deploy-the-elastic-stack-on-kubernetes/)
