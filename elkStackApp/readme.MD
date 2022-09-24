# Elastic Stack
Elastic stack es una tecnologia que usa Elasticsearch, Logstash, Kibana y Beats para el monitoreo, analisis y visualizacion de datos a escala. Esta tecnologia puede ser usada para multiples propositos y uno de los principales es el usos es como SIEM en equipos de seguridad. Algunas de sus caracteristicas mas relevantes son:
	- Escalamiento Horizontal
	- Cluster y alta disponibilidad
	- Monitoreo y alerta en multiples partes del stack
	- Multiple tipos de datos 
	- Compatible con multiples sistema operativos
	- Recoleccion de datos de red, sistema y de seguridad.
	- etc

## Arquitectura

El primer componete que tiene contacto con el servidor es Beats, un agente que se encarga de enviar los datos a el servidor de recoleccion (Elasticsearch o Logstash). Este agente se configura para enviar los distintos tipos de eventos. Despues se encuentra Logstash, este componente se encarga del parseado y transformacion de los datos. Por otro lado, estos datos son enviados a Elasticsearch el motor de busqueda y analitica de datos. Finalmente, Kibana se encarga de la visualizacion de los datos.


![Arquitectura de Elactic Stack](./images/architecture.png)


## Funcionalidad

El caso de uso para este proyecto es el de SIEM (Security Information and Event Management) en este caso los agentes Beats recolectan datos de seguridad como eventos de sistema de Windows y Linux. Estos eventos son procesados para identificar comportamientos anomalos o para su analisis en respuesta de incidentes de ciberseguridad.

## Despliege

Para el despliegue se usan los siguientes comandos:
	
1. helm repo add elastic https://helm.elastic.co
2. helm repo update
3. helm search hub elasticsearch
4. helm install elasticsearch elastic/elasticsearch
5. kubectl port-forward svc/elasticsearch-master 9200:9200
6. curl http://localhost:9200/
7. helm install filebeat elastic/filebeat
8. curl http://localhost:9200/_cat/indices
9. helm install kibana elastic/kibana
10. kubectl port-forward svc/kibana-kibana 5601:5601
11.  