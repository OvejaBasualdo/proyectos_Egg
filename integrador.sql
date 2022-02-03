use nba;
/*Muestre cuántas veces los jugadores lograron tener más o la misma cantidad de
asistencias por partido, que el máximo de asistencias por partido. */
/*POSICION CANDADO A*/select count(asistencias_por_partido) AS 'POSICION CANDADO A' from estadisticas
where asistencias_por_partido = (select max(Asistencias_por_partido) from estadisticas);
/*CLAVE*/ /*Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición
sea centro o esté comprendida en otras posiciones.*/
select sum(j.peso) as 'CLAVE CANDADO A'from jugadores j inner join equipos e
on j.Nombre_equipo = e.Nombre
where e.Conferencia='East' and j.Posicion like '%c%';
/* POSICION CANDADO A = 2
CLAVE = 14043*/

/*CANDADO B*/
/*POSICION = Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero
de jugadores que tiene el equipo Heat */
select count(asistencias_por_partido) AS 'POSICION CANDADO B' from estadisticas
where asistencias_por_partido > (select count(*) from jugadores where Nombre_equipo = 'Heat');
/*CLAVE = La clave será igual al conteo de partidos jugados durante las temporadas del año 1999*/
select count(*) as 'CLAVE CANDADO B' from partidos
where temporada like '%99%';
/* POSICION CANDADO B = 3
CLAVE = 3480*/

/*CANDADO C*/
/*La posición del código será igual a la cantidad de jugadores que proceden de Michigan y
forman parte de equipos de la conferencia oeste.
Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual
a 195, y a eso le vamos a sumar 0.9945.*/

select round((select count(*) from jugadores j inner join equipos e
on j.Nombre_equipo = e.Nombre
where j.Procedencia = 'Michigan' and e.Conferencia = 'West')/(select count(*) from jugadores where peso >= 195)+0.9945) 
as 'POSICIÓN CANDADO C';
/*CLAVE = Para obtener el siguiente código deberás redondear hacia abajo el resultado que se
devuelve de sumar: el promedio de puntos por partido, el conteo de asistencias por partido,
y la suma de tapones por partido. Además, este resultado debe ser, donde la división sea
central.*/
SELECT ROUND(AVG(PUNTOS_POR_PARTIDO)+COUNT(ASISTENCIAS_POR_PARTIDO)+SUM(TAPONES_POR_PARTIDO)) 
as 'CLAVE CANDADO C'
FROM estadisticas e inner join jugadores j ON e.jugador = j.codigo
inner join equipos eq on eq.nombre = j.Nombre_equipo
where eq.Division = 'Central';
/* POSICION CANDADO C = 1
CLAVE = 631*/

/*CANDADO D
POSICION = Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01.
Este resultado debe ser redondeado. Nota: el resultado debe estar redondeado*/
select round(e.tapones_por_partido) as 'POSICIÓN CANDADO D' from estadisticas e inner join jugadores j
on e.jugador = j.codigo
where j.Nombre = 'Corey Maggette' AND e.temporada = '00/01';

/* CLAVE = Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por
partido de todos los jugadores de procedencia argentina*/
select round(sum(e.Puntos_por_partido)) as 'CLAVE CANDADO D' from estadisticas e inner join jugadores j
on e.jugador = j.codigo
where j.Procedencia = 'Argentina';

SELECT j.nombre, sum(e.puntos_por_partido) from jugadores j inner join estadisticas e 
on j.codigo = e.jugador
where Procedencia='Argentina'
group by j.Nombre;
/* POSICION CANDADO D = 4
CLAVE = 191*/