SET hive.auto.convert.join=false;

USE practica_hive;

-- Historial de visualización de películas del usuario.
CREATE VIEW historial_visualizacion_usuario AS 
SELECT u.id_usuario, u.nickname, p.titulo, v.fecha_visualizacion 
FROM Usuario u 
JOIN Perfil pr ON u.id_usuario = pr.id_usuario 
JOIN Contrato c ON pr.id_perfil = c.id_perfil 
JOIN Visualizacion v ON c.id_contrato = v.id_contrato 
JOIN Pelicula p ON v.id_pelicula = p.id_pelicula 
ORDER BY u.id_usuario, v.fecha_visualizacion DESC;

-- Top 5 películas con más ingresos brutos por cada idioma.
CREATE VIEW top5_peliculas_por_idioma AS 
SELECT idioma_vo, titulo, ingresos_brutos 
FROM (
    SELECT p.idioma_vo, p.titulo, p.ingresos_brutos, 
    ROW_NUMBER() OVER (PARTITION BY p.idioma_vo ORDER BY p.ingresos_brutos DESC) as rn 
    FROM Pelicula p
) ranked 
WHERE rn <= 5;

-- Películas que pertenecen a más de un género.
CREATE VIEW peliculas_multigenero AS 
SELECT p.id_pelicula, p.titulo, COUNT(DISTINCT pg.id_genero) as num_generos, 
COLLECT_LIST(g.nombre_genero) as generos 
FROM Pelicula p 
JOIN Pelicula_Genero pg ON p.id_pelicula = pg.id_pelicula 
JOIN Genero g ON pg.id_genero = g.id_genero 
GROUP BY p.id_pelicula, p.titulo 
HAVING COUNT(DISTINCT pg.id_genero) > 1;

-- Lista de usuarios con contrato activo.
CREATE VIEW usuarios_contrato_activo AS 
SELECT u.id_usuario, u.nickname, u.email, p.nombre, p.apellidos, 
c.fecha_contratacion, c.fecha_fin, pr.tipo as tipo_producto 
FROM Usuario u 
JOIN Perfil p ON u.id_usuario = p.id_usuario 
JOIN Contrato c ON p.id_perfil = c.id_perfil 
JOIN Producto pr ON c.id_producto = pr.id_producto 
WHERE (CURRENT_DATE() >= c.fecha_contratacion AND (c.fecha_fin IS NULL OR CURRENT_DATE() <= c.fecha_fin));
    
-- Top 3 género más visto de películas de cada usuario.
CREATE VIEW top3_generos_por_usuario AS 
SELECT u.id_usuario, u.nickname, g.nombre_genero, conteo_genero 
FROM (
    SELECT u.id_usuario, g.id_genero, COUNT(*) as conteo_genero, 
    ROW_NUMBER() OVER (PARTITION BY u.id_usuario ORDER BY COUNT(*) DESC) as rn 
    FROM Usuario u 
    JOIN Perfil p ON u.id_usuario = p.id_usuario 
    JOIN Contrato c ON p.id_perfil = c.id_perfil 
    JOIN Visualizacion v ON c.id_contrato = v.id_contrato 
    JOIN Pelicula_Genero pg ON v.id_pelicula = pg.id_pelicula 
    JOIN Genero g ON pg.id_genero = g.id_genero 
    GROUP BY u.id_usuario, g.id_genero
) ranked 
JOIN Usuario u ON ranked.id_usuario = u.id_usuario 
JOIN Genero g ON ranked.id_genero = g.id_genero 
WHERE rn <= 3;

-- Top 5 directores que más películas han dirigido.
CREATE VIEW top5_directores_por_peliculas AS 
SELECT director, COUNT(*) as num_peliculas, COLLECT_LIST(titulo) as peliculas 
FROM Pelicula 
GROUP BY director 
ORDER BY num_peliculas DESC 
LIMIT 5;

-- Top 5 contratos de más larga duración.
CREATE VIEW top5_contratos_mas_largos AS 
SELECT c.id_contrato, u.nickname, p.nombre, p.apellidos, pr.tipo as tipo_producto, 
c.fecha_contratacion, c.fecha_fin, DATEDIFF(c.fecha_fin, c.fecha_contratacion) as dias_duracion 
FROM Contrato c 
JOIN Perfil p ON c.id_perfil = p.id_perfil 
JOIN Usuario u ON p.id_usuario = u.id_usuario 
JOIN Producto pr ON c.id_producto = pr.id_producto 
ORDER BY dias_duracion DESC 
LIMIT 5;
    
-- Top 10 palabras claves más usadas en las películas.
CREATE VIEW top10_palabras_clave AS 
SELECT palabra, COUNT(*) as frecuencia 
FROM (
    SELECT EXPLODE(SPLIT(LOWER(REGEXP_REPLACE(palabras_clave_descripcion, '[^a-zA-Z0-9\\s]', ' ')), ' ')) as palabra 
    FROM Pelicula
) words 
WHERE LENGTH(palabra) > 3 
GROUP BY palabra 
ORDER BY frecuencia DESC 
LIMIT 10;

-- Ingresos brutos generado por cada director.
CREATE VIEW ingresos_por_director AS 
SELECT director, SUM(ingresos_brutos) as total_ingresos_brutos, 
COUNT(*) as num_peliculas, AVG(ingresos_brutos) as promedio_ingresos_por_pelicula 
FROM Pelicula 
GROUP BY director 
ORDER BY total_ingresos_brutos DESC;