
# Contrato Sistema de Votación

Este contrato inteligente implementa un sistema de votación en la cadena de bloques Ethereum. Permite a un administrador crear propuestas y a los votantes autorizados votar por las propuestas durante un período de tiempo determinado.


## Características del contrato

- Admin: Dirección del administrador del contrato, quien tiene el control sobre la creación de propuestas y la gestión de la lista de votantes autorizados.

- Tiempo de Despliegue: Marca de tiempo en la que se desplegó el contrato.

- Días de Votación: Duración del período de votación, fijado en 3 días.

- Propuesta: Estructura que representa una propuesta, con un nombre y un contador de votos.

- Lista de Votantes: Mapeo que almacena las direcciones de Ethereum de los votantes autorizados.

- Ha Votado: Mapeo que indica si una dirección ya ha emitido su voto.

## Funcionalidades

- agregarAListaBlanca: Permite al administrador agregar direcciones a la lista de votantes autorizados.

- eliminarDeListaBlanca: Permite al administrador eliminar direcciones de la lista de votantes autorizados.

- agregarPropuesta: Permite al administrador agregar una nueva propuesta al sistema.

- obtenerVotosPropuesta: Permite a cualquier usuario obtener el número de votos de una propuesta específica.

- votar: Permite a los votantes autorizados emitir su voto por una propuesta durante el período de votación.

## Modificadores

- soloAdmin: Restringe ciertas funciones solo al administrador del contrato.

- soloEnListaVotantes: Restringe ciertas funciones solo a direcciones en la lista blanca de votantes autorizados.

- durantePeriodoVotacion: Restringe ciertas funciones para que solo puedan ejecutarse durante el período de votación.

## Notas importantes
Las propuestas se convierten a minúsculas, al igual que los parametros de los metodos que interactuan con estas para permitir una búsqueda insensible a mayúsculas y minúsculas.

Los votantes autorizados solo pueden votar una vez por cada propuesta.

## Uso del contrato

El administrador debe desplegar el contrato.

El administrador agrega las direcciones de los votantes autorizados mediante la función agregarAListaBlanca.

El administrador crea propuestas utilizando la función agregarPropuesta.

Los votantes autorizados pueden votar por las propuestas utilizando la función votar durante el período de votación.

Después de que finalice el período de votación, el administrador puede consultar los resultados utilizando la función obtenerVotosPropuesta.
