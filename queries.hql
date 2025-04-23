SET hive.auto.convert.join = false;
use practica_hive;
-- Insert data into the tables
INSERT INTO pelicula (
        id_pelicula,
        titulo,
        director,
        duracion,
        color,
        relacion_aspecto,
        anio_estreno,
        calificacion_edad,
        pais_produccion,
        idioma_vo,
        presupuesto,
        ingresos_brutos,
        link_imdb,
        palabras_clave_descripcion
    )
VALUES (
        6,
        'Comedia Dramática Ejemplo',
        'Director Prueba',
        120,
        true,
        '16:9',
        2024,
        'PG-13',
        'España',
        'Español',
        5000000.00,
        12000000.00,
        'https://www.imdb.com/title/tt12345678/',
        'vida, relaciones, humor'
    );
INSERT INTO pelicula_genero (id_pelicula, id_genero)
VALUES (6, 2);
INSERT INTO pelicula_genero (id_pelicula, id_genero)
VALUES (6, 3);
INSERT INTO actor (id_actor, nombre)
VALUES (100, 'Actor Prueba');
INSERT INTO pelicula_actor (id_pelicula, id_actor)
VALUES (6, 100);
INSERT INTO usuario (id_usuario, nickname, contrasena, email)
VALUES (
        6,
        'pepesincontrato',
        'ClaveSegura123',
        'pepesin@example.com'
    );
INSERT INTO perfil (
        id_perfil,
        id_usuario,
        nombre,
        apellidos,
        edad,
        telefono,
        dni,
        fecha_nacimiento
    )
VALUES (
        6,
        6,
        'Pepe',
        'Sin Contrato',
        30,
        '600000000',
        '99887766Z',
        '1990-01-01'
    );
INSERT INTO contrato (
    id_contrato,
    id_perfil,
    id_producto,
    direccion_postal,
    ciudad,
    codigo_postal,
    pais,
    fecha_contratacion,
    fecha_fin
)
VALUES (
        99,
        1,
        1,
        'Calle Ejemplo 123',
        'Madrid',
        '28000',
        'España',
        '2024-04-01',
        '2025-04-20'
    );
INSERT INTO pelicula (
        id_pelicula,
        titulo,
        director,
        duracion,
        color,
        relacion_aspecto,
        anio_estreno,
        calificacion_edad,
        pais_produccion,
        idioma_vo,
        presupuesto,
        ingresos_brutos,
        link_imdb,
        palabras_clave_descripcion
    )
VALUES (
        201,
        'Película Español',
        'Director A',
        100,
        true,
        '16:9',
        2024,
        'PG',
        'España',
        'Español',
        1000000,
        5000000,
        '',
        ''
    ),
    (
        202,
        'Película Inglés',
        'Director B',
        100,
        true,
        '16:9',
        2024,
        'PG',
        'EEUU',
        'Inglés',
        1000000,
        5000000,
        '',
        ''
    ),
    (
        203,
        'Película Francés',
        'Director C',
        100,
        true,
        '16:9',
        2024,
        'PG',
        'Francia',
        'Francés',
        1000000,
        5000000,
        '',
        ''
    );
INSERT INTO contrato (
        id_contrato,
        id_perfil,
        id_producto,
        direccion_postal,
        ciudad,
        codigo_postal,
        pais,
        fecha_contratacion,
        fecha_fin
    )
VALUES (
        200,
        1,
        1,
        'Calle de prueba',
        'Madrid',
        '28001',
        'España',
        '2024-01-01',
        '2026-01-01'
    );
INSERT INTO visualizacion (
        id_visualizacion,
        id_contrato,
        id_pelicula,
        fecha_visualizacion
    )
VALUES (900, 200, 201, current_timestamp),
    (901, 200, 202, current_timestamp),
    (902, 200, 203, current_timestamp);
-- Consulta : Obtener actores que participan en películas con Comedia y Drama
SELECT DISTINCT pa.id_actor
FROM Pelicula_Genero pg1
    JOIN Pelicula_Genero pg2 ON pg1.id_pelicula = pg2.id_pelicula
    JOIN Pelicula_Actor pa ON pa.id_pelicula = pg1.id_pelicula
WHERE pg1.id_genero = 2 
    AND pg2.id_genero = 3;
-- Consulta: Usuarios con más de 6 meses registrados y sin contrato
SELECT u.id_usuario,
    u.nickname,
    p.fecha_nacimiento
FROM usuario u
    JOIN perfil p ON u.id_usuario = p.id_usuario
    LEFT JOIN contrato c ON p.id_perfil = c.id_perfil
WHERE c.id_contrato IS NULL
    AND p.fecha_nacimiento <= current_date - interval 6 months;
-- Consulta 3: Director con más visualizaciones promedio por película
SELECT p.director,
    AVG(vs.total_visualizaciones) AS promedio_visualizaciones
FROM pelicula p
    JOIN (
        SELECT id_pelicula,
            COUNT(*) AS total_visualizaciones
        FROM visualizacion
        GROUP BY id_pelicula
    ) vs ON p.id_pelicula = vs.id_pelicula
GROUP BY p.director
ORDER BY promedio_visualizaciones DESC
LIMIT 1;
-- ========== CONSULTA 4: Top 5 películas con más ingresos y sus géneros ==========
SELECT p.id_pelicula,
    p.titulo,
    p.ingresos_brutos,
    g.nombre_genero
FROM pelicula p
    JOIN pelicula_genero pg ON p.id_pelicula = pg.id_pelicula
    JOIN genero g ON pg.id_genero = g.id_genero
WHERE p.ingresos_brutos IS NOT NULL
ORDER BY p.ingresos_brutos DESC
LIMIT 5;
-- ========== CONSULTA 5: Directores con películas en 3 o más géneros ==========
SELECT p.director,
    COUNT(DISTINCT pg.id_genero) AS cantidad_generos
FROM pelicula p
    JOIN pelicula_genero pg ON p.id_pelicula = pg.id_pelicula
GROUP BY p.director
HAVING COUNT(DISTINCT pg.id_genero) >= 3;
-- ========== CONSULTA 6: Actor más popular por película ==========
WITH conteo_apariciones AS (
    SELECT id_actor,
        COUNT(DISTINCT id_pelicula) AS apariciones
    FROM pelicula_actor
    GROUP BY id_actor
),
actor_mas_popular AS (
    SELECT pa.id_pelicula,
        pa.id_actor,
        ca.apariciones
    FROM pelicula_actor pa
        JOIN conteo_apariciones ca ON pa.id_actor = ca.id_actor
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY id_pelicula
            ORDER BY apariciones DESC
        ) AS rank
    FROM actor_mas_popular
)
SELECT id_pelicula,
    id_actor
FROM ranked
WHERE rank = 1;
-- Consulta: Top 5 usuarios que han visto más películas
SELECT u.id_usuario,
    COUNT(DISTINCT v.id_pelicula) AS cantidad_peliculas
FROM visualizacion v
    JOIN contrato c ON v.id_contrato = c.id_contrato
    JOIN perfil p ON c.id_perfil = p.id_perfil
    JOIN usuario u ON p.id_usuario = u.id_usuario
GROUP BY u.id_usuario
ORDER BY cantidad_peliculas DESC
LIMIT 5;
-- Consulta: Promedio de ingresos (como proxy de calificación IMDb) por género
SELECT g.nombre_genero,
    AVG(p.ingresos_brutos) AS promedio_ingresos
FROM pelicula p
    JOIN pelicula_genero pg ON p.id_pelicula = pg.id_pelicula
    JOIN genero g ON pg.id_genero = g.id_genero
WHERE p.ingresos_brutos IS NOT NULL
GROUP BY g.nombre_genero
ORDER BY promedio_ingresos DESC;
-- Consulta: Palabras clave más comunes en las películas
SELECT palabra,
    COUNT(*) AS apariciones
FROM (
        SELECT explode(split(p.palabras_clave_descripcion, ',')) AS palabra
        FROM pelicula p
        WHERE p.palabras_clave_descripcion IS NOT NULL
    ) palabras
GROUP BY palabra
ORDER BY apariciones DESC
LIMIT 10;
-- Consulta para obtener usuarios cuyos contratos terminan pronto
SELECT u.id_usuario,
    u.nickname,
    c.fecha_fin
FROM contrato c
    JOIN perfil p ON c.id_perfil = p.id_perfil
    JOIN usuario u ON p.id_usuario = u.id_usuario
WHERE c.fecha_fin IS NOT NULL
    AND c.fecha_fin BETWEEN current_date AND date_add(current_date, 30);
-- Consulta: Películas con múltiples géneros
SELECT p.id_pelicula,
    p.titulo,
    COLLECT_LIST(g.nombre_genero) AS generos
FROM pelicula p
    JOIN pelicula_genero pg ON p.id_pelicula = pg.id_pelicula
    JOIN genero g ON pg.id_genero = g.id_genero
GROUP BY p.id_pelicula,
    p.titulo
HAVING COUNT(DISTINCT g.id_genero) > 1;
-- Consulta final: Usuarios que han visualizado películas en al menos 3 idiomas
SELECT u.id_usuario,
    COUNT(DISTINCT p.idioma_vo) AS cantidad_idiomas
FROM visualizacion v
    JOIN contrato c ON v.id_contrato = c.id_contrato
    JOIN perfil p1 ON c.id_perfil = p1.id_perfil
    JOIN usuario u ON p1.id_usuario = u.id_usuario
    JOIN pelicula p ON v.id_pelicula = p.id_pelicula
WHERE p.idioma_vo IS NOT NULL
GROUP BY u.id_usuario
HAVING COUNT(DISTINCT p.idioma_vo) >= 3;