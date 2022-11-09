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
### Elastic ṕod	
1. ```helm repo add elastic https://helm.elastic.co```
2. ```helm repo update```
3. ```helm search hub elasticsearch```
4. ```helm install elasticsearch elastic/elasticsearch -f values_elastic.yaml```
5. ```kubectl port-forward svc/elasticsearch-master 9200:9200 --address='0.0.0.0'```

### Definir credenciales de elastic
1. ```cd bin```
2. ```./elasticsearch-setup-passwords interactive```
3. Definir contraseñas para cada servicio. Importante no olvidarlas, pues de ser así deberá creerse el pod nuevamente.

### Filebeat ṕod
1. ```curl http://localhost:9200/ -u <user>:<password>```
2. ```helm install filebeat elastic/filebeat -f values_filebeat.yaml```
3. ```curl http://localhost:9200/_cat/indices -u <user>:<password>```
### Kibana ṕod
1. helm install kibana elastic/kibana
2. kubectl port-forward svc/kibana-kibana 5601:5601
### Configurar cowrie
1. Iniciar una VM e [instalar cowrie](https://cowrie.readthedocs.io/en/latest/INSTALL.html)
2. Ingresar a ```cowrie/var/log/cowrie```
3. Descargar [Elastic Agent](https://www.elastic.co/downloads/past-releases/elastic-agent-7-17-3) y descomprimir en esa carpeta
4. Ingresar a carpeta descomprimida y ejecutar ```./elastic-agent install```
5. Copiar dirección de archivo cowrie.log para siguiente paso
### Añadir custom log para recibir de cowrie
1. Ingresar a Add Integrations y elegir [Custom Logs](http://localhost:5601/app/fleet/integrations/log-1.1.0/add-integration)
2. Integration name: cowriw
3. Llenar log file path con direccion de cowrie.log

[Link a tutorial](https://www.linode.com/docs/guides/how-to-deploy-the-elastic-stack-on-kubernetes/)
