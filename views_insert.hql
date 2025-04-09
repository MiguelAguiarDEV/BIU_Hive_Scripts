CREATE TABLE Pelicula_Genero (
  id_pelicula INT,
  id_genero INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

INSERT INTO TABLE Pelicula_Genero VALUES
(1, 1),  -- Película 1, Género 1
(1, 2),  -- Película 1, Género 2 (esta película tiene múltiples géneros)
(2, 3),  -- Película 2, Género 3
(3, 1),  -- Película 3, Género 1
(3, 4),  -- Película 3, Género 4 (esta película tiene múltiples géneros)
(4, 2),  -- Película 4, Género 2
(5, 1),  -- Película 5, Género 1
(5, 3),  -- Película 5, Género 3 (esta película tiene múltiples géneros)
(5, 5);  -- Película 5, Género 5 (esta película tiene múltiples géneros);

INSERT INTO Contrato VALUES (
  6, 
  3, 
  3, 
  'Avenida Principal 789', 
  'Valencia', 
  '46001', 
  'España', 
  '2025-01-10', 
  '2025-10-20'
);
INSERT INTO Contrato VALUES (
  7, 
  5, 
  5, 
  '456 Park Avenue', 
  'Manchester', 
  'M1 1AB', 
  'Reino Unido', 
  '2025-02-15', 
  '2025-12-15'
);

INSERT INTO Pelicula VALUES (
  101,
  'Interstellar',
  'Christopher Nolan',
  169,
  TRUE,
  '2.39:1',
  2014,
  'PG-13',
  'Estados Unidos',
  'Inglés',
  165000000.00,
  677500000.00,
  'https://www.imdb.com/title/tt0816692/',
  'espacio viaje tiempo relatividad'
);
INSERT INTO Pelicula VALUES (
  102,
  'Inception',
  'Christopher Nolan',
  148,
  TRUE,
  '2.39:1',
  2010,
  'PG-13',
  'Estados Unidos',
  'Inglés',
  160000000.00,
  836800000.00,
  'https://www.imdb.com/title/tt1375666/',
  'sueños subconsciente robo mente'
);
INSERT INTO Pelicula VALUES (
  103,
  'The Dark Knight',
  'Christopher Nolan',
  152,
  TRUE,
  '2.39:1',
  2008,
  'PG-13',
  'Estados Unidos',
  'Inglés',
  185000000.00,
  1005000000.00,
  'https://www.imdb.com/title/tt0468569/',
  'batman joker gotham héroe'
);
-- Insertar varias películas del director "Martin Scorsese"
INSERT INTO Pelicula VALUES (
  104,
  'The Departed',
  'Martin Scorsese',
  151,
  TRUE,
  '2.39:1',
  2006,
  'R',
  'Estados Unidos',
  'Inglés',
  90000000.00,
  291500000.00,
  'https://www.imdb.com/title/tt0407887/',
  'mafia policia infiltrado boston'
);
INSERT INTO Pelicula VALUES (
  105,
  'The Wolf of Wall Street',
  'Martin Scorsese',
  180,
  TRUE,
  '2.39:1',
  2013,
  'R',
  'Estados Unidos',
  'Inglés',
  100000000.00,
  392000000.00,
  'https://www.imdb.com/title/tt0993846/',
  'wall street finanzas drogas exceso'
);

-- Contrato de 2 años de duración (730 días)
INSERT INTO Contrato VALUES (
  8,
  1,
  2,
  'Gran Vía 123',
  'Madrid',
  '28013',
  'España',
  '2025-01-01',
  '2027-01-01'
);
-- Contrato de 5 años de duración (1826 días aproximadamente)
INSERT INTO Contrato VALUES (
  9,
  4,
  3,
  '789 Fifth Avenue',
  'Nueva York',
  '10022',
  'Estados Unidos',
  '2025-02-15',
  '2030-02-15'
);

INSERT INTO Pelicula VALUES (
  108,
  'El Codigo Secreto',
  'David Fincher',
  142,
  TRUE,
  '2.39:1',
  2016,
  'PG-13',
  'Estados Unidos',
  'Ingles',
  120000000.00,
  350000000.00,
  'https://www.imdb.com/title/fictional1/',
  'misterio codigo secreto conspiracion aventura investigacion thriller accion suspense'
);
INSERT INTO Pelicula VALUES (
  109,
  'Galaxia Perdida',
  'James Cameron',
  165,
  TRUE,
  '1.85:1',
  2020,
  'PG-13',
  'Estados Unidos',
  'Ingles',
  250000000.00,
  890000000.00,
  'https://www.imdb.com/title/fictional2/',
  'espacio ciencia ficcion aventura galaxia alienigenas accion viaje misterio'
);
INSERT INTO Pelicula VALUES (
  110,
  'Asesino Profesional',
  'Denis Villeneuve',
  128,
  TRUE,
  '2.39:1',
  2018,
  'R',
  'Canada',
  'Ingles',
  85000000.00,
  210000000.00,
  'https://www.imdb.com/title/fictional3/',
  'accion thriller suspense misterio asesino conspiracion secreto persecucion venganza'
);
INSERT INTO Pelicula VALUES (
  111,
  'El Planeta Prohibido',
  'Alfonso Cuaron',
  138,
  TRUE,
  '2.39:1',
  2019,
  'PG-13',
  'Mexico',
  'Espanol',
  100000000.00,
  320000000.00,
  'https://www.imdb.com/title/fictional4/',
  'ciencia ficcion aventura espacio extraterrestres misterio supervivencia planeta accion'
);