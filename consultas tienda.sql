	use tienda;
select NOMBRE 
from tienda.producto; /*1. Lista el nombre de todos los productos que hay en la tabla producto.*/
select NOMBRE, precio 
from tienda.producto; /*2. Lista los nombres y los precios de todos los productos de la tabla producto.*/
select * from producto;/*3. Lista todas las columnas de la tabla producto.*/ 
Select * from fabricante;
Select nombre, precio from producto;
Select nombre, round(precio) from producto;/*4. Lista los nombres y los precios de todos los productos de la tabla producto
redondeando el valor del precio.*/
select fabricante.codigo, producto.nombre from fabricante join producto on fabricante.codigo = producto.codigo_fabricante;/*5. Lista el código de los fabricantes que tienen productos en la tabla producto.*/
select distinct codigo from producto;
select distinct fabricante.codigo from fabricante join producto on fabricante.codigo = producto.codigo_fabricante;/*10. Lista el código de los fabricantes que tienen productos en la tabla producto, sin
mostrar los repetidos.*/
select nombre from fabricante order by nombre asc;/*11. Lista los nombres de los fabricantes ordenados de forma ascendente.*/
select producto.precio, producto.nombre from producto order by nombre desc , precio asc;/*12. Lista los nombres de los productos 
ordenados en primer lugar por el nombre de
forma ascendente y en segundo lugar por el precio de forma descendente.*/
select * from fabricante where codigo between 1 and 5;/*Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
select * from fabricante limit 5;
select nombre,precio from producto order by precio asc limit 1; /*14. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
select nombre,precio from producto order by precio desc limit 1;/*15. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
select nombre, precio from producto where precio<=120;/*16. Lista el nombre de los productos que tienen un precio menor o igual a $120.*/
select * from producto where precio between 60 and 200; /*17. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el
operador BETWEEN.*/
select * from producto where codigo_fabricante in (1,3,5);/*18. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el
operador IN.*/
select nombre from producto where nombre like '%portátil%';/*23. Devuelve una lista con el nombre de todos los productos que contienen la cadena
Portátil en el nombre.*/
/*------Consultas Multitabla-----*/
select f.codigo,f.nombre,p.codigo_fabricante, p.nombre 
from fabricante f join producto p
on f.codigo = p.codigo_fabricante;/*1. Devuelve una lista con el código del producto, nombre del producto, código del
fabricante y nombre del fabricante, de todos los productos de la base de datos.*/
select p.nombre,p.precio, f.nombre
from fabricante f join producto p
on f.codigo = p.codigo_fabricante
order by f.nombre asc;/*2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de
todos los productos de la base de datos. Ordene el resultado por el nombre del
fabricante, por orden alfabético.*/
select p.nombre,p.precio, f.nombre
from fabricante f inner join producto p
on f.codigo = p.codigo_fabricante
order by p.precio asc
limit 1;/*3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del
producto más barato*/
select p.*,f.nombre
from fabricante f join producto p
on f.codigo = p.codigo_fabricante
where f.nombre like '%Lenovo%';/*4. Devuelve una lista de todos los productos del fabricante Lenovo*/
select p.*,f.nombre
from fabricante f join producto p
on f.codigo = p.codigo_fabricante
where f.nombre like '%Crucial%'
and p.precio >200;/*5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un
precio mayor que $200.*/
select p.*,f.nombre
from fabricante f join producto p
on f.codigo = p.codigo_fabricante
where f.nombre in('Asus','Hewlett-Packard');/*6. Devuelve un listado con todos los productos de los fabricantes Asus,
HewlettPackard. Utilizando el operador IN.*/
select p.*,f.nombre
from fabricante f join producto p
on f.codigo = p.codigo_fabricante
where p.precio>=180 order by p.precio desc,f.nombre asc;/*7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de
todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado
en primer lugar por el precio (en orden descendente) y en segundo lugar por el
nombre (en orden ascendente)*/
/*---Consultas Multitabla---*/
/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN*/
select p.*,f.nombre
from fabricante f left join producto p
on f.codigo = p.codigo_fabricante;/*1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto
con los productos que tiene cada uno de ellos. El listado deberá mostrar también
aquellos fabricantes que no tienen productos asociados*/
select f.nombre
from fabricante f left join producto p
on f.codigo = p.codigo_fabricante
group by f.nombre
having count(p.codigo)=0;/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen
ningún producto asociado.*/
select fabricante.nombre,producto.nombre from producto right join fabricante 
on fabricante.codigo = producto.codigo_fabricante where producto.nombre is null ; /*otra solucion mas optima del unto 2*/

/*---Subconsultas (En la cláusula WHERE)---*/
/*Con operadores básicos de comparación*/
select p.*
from producto p
where p.codigo_fabricante = (select f.codigo from fabricante f where f.nombre like 'Lenovo'); /*1. Devuelve todos los productos del fabricante Lenovo. 
(Sin utilizar INNER JOIN)*/

select *
from producto p
where p.precio = (select max(p.precio) from producto p where p.codigo_fabricante = (select f.codigo from fabricante f where f.nombre like 'Lenovo')) 
and p.codigo_fabricante != (select f.codigo from fabricante f where f.nombre like 'Lenovo'); /*2. Devuelve todos 
los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
select p.nombre from producto p
where p.precio =(select max(p.precio) from producto p, fabricante f where p.codigo_fabricante=(select f.codigo from fabricante f where f.nombre like 'Lenovo'));/*3. Lista 
el nombre del producto más caro del fabricante Lenovo*/
SELECT p.* FROM producto p
WHERE p.codigo_fabricante = (SELECT f.codigo FROM fabricante f WHERE f.nombre = 'Asus')
        AND p.precio > (SELECT AVG(p.precio) FROM producto p , fabricante f where f.nombre = 'Asus');/*4. Lista 
todos los productos del fabricante Asus 
que tienen un precio superior al precio medio de todos sus productos.*/
SELECT p.precio FROM producto p , fabricante f where f.nombre = 'Asus';
SELECT * from producto p inner join fabricante f on p.codigo_fabricante = f.codigo
where f.nombre = 'asus' AND p.precio > (SELECT AVG(p.precio) FROM producto p inner join fabricante f on p.codigo_fabricante = f.codigo where f.nombre = 'Asus'); /*
correcto*/
/*-----Subconsultas con IN y NOT IN-----*/

select distinct f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where f.codigo 
in (select distinct codigo_fabricante from fabricante f join producto p on f.codigo = p.codigo_fabricante );/*1. Devuelve los nombres de los fabricantes que tienen productos asociados.
(Utilizando IN o NOT IN).*/
select distinct f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where f.codigo 
not in (select distinct codigo_fabricante from fabricante f join producto p on f.codigo = p.codigo_fabricante );/*2. Devuelve los nombres de los fabricantes que no tienen productos asociados.
(Utilizando IN o NOT IN).*/
/*---Subconsultas (En la cláusula HAVING)---*/
select f.nombre, count(p.nombre) from fabricante f inner join producto p on f.codigo = p.codigo_fabricante
where f.nombre != 'Lenovo' group by p.codigo_fabricante
having count(p.nombre) = (select count(p.codigo_fabricante) from producto p  right join fabricante f on f.codigo = p.codigo_fabricante where f.nombre = 'Lenovo' );/*1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo
número de productos que el fabricante Lenovo.*/

select * from producto p right join fabricante f on p.codigo_fabricante = f.codigo where (select round(max(precio)) from producto where f.nombre = 'Lenovo') = (select round(precio) from producto where f.nombre != 'Lenovo');
select f.codigo from fabricante f where f.nombre like '%Asus';
select * from producto;
select f.codigo from fabricante f where f.nombre like 'Lenovo';
select max(p.precio) from producto p where p.codigo_fabricante=2;
select * from fabricante;

