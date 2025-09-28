-- Secuencia
CREATE SEQUENCE PETS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Tabla
CREATE TABLE PETS (
  ID          NUMBER(19) PRIMARY KEY,
  NAME        VARCHAR2(200) NOT NULL,
  SPECIES     VARCHAR2(100),
  BREED       VARCHAR2(100),
  AGE         NUMBER(5),
  PRICE       NUMBER(18,2),
  DESCRIPTION VARCHAR2(2000),
  BIRTH_DATE  DATE,
  IMAGE_URL   VARCHAR2(1000)
);

COMMIT;
-- (Opcional) permisos:
-- GRANT SELECT, INSERT, UPDATE, DELETE ON PETS TO TU_USUARIO;

ALTER TABLE pets MODIFY (price FLOAT(53));

COMMIT;

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (1, 'Max', 'Perro', 'Labrador', 3, 450.00, 'Perro amistoso y juguetón, ideal para familias.', TO_DATE('2021-08-15','YYYY-MM-DD'), 'https://example.com/images/max.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (2, 'Misu', 'Gato', 'Persa', 2, 300.00, 'Gato cariñoso y tranquilo, excelente compañero.', TO_DATE('2022-05-10','YYYY-MM-DD'), 'https://example.com/images/misu.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (3, 'Rocky', 'Perro', 'Pastor Alemán', 5, 600.00, 'Perro guardián, leal y protector.', TO_DATE('2019-03-20','YYYY-MM-DD'), 'https://example.com/images/rocky.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (4, 'Nemo', 'Pez', 'Pez Payaso', 1, 50.00, 'Colorido y alegre, perfecto para acuarios.', TO_DATE('2023-06-01','YYYY-MM-DD'), 'https://example.com/images/nemo.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (5, 'Luna', 'Gato', 'Siames', 4, 350.00, 'Gata activa y cariñosa, muy inteligente.', TO_DATE('2020-11-12','YYYY-MM-DD'), 'https://example.com/images/luna.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (6, 'Kiwi', 'Ave', 'Periquito', 2, 150.00, 'Ave parlanchina y alegre, fácil de cuidar.', TO_DATE('2022-07-05','YYYY-MM-DD'), 'https://example.com/images/kiwi.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (7, 'Toby', 'Conejo', 'Enano Holandés', 1, 200.00, 'Conejo pequeño y dócil, ideal para interiores.', TO_DATE('2023-04-18','YYYY-MM-DD'), 'https://example.com/images/toby.jpg');

INSERT INTO PETS (ID, NAME, SPECIES, BREED, AGE, PRICE, DESCRIPTION, BIRTH_DATE, IMAGE_URL)
VALUES (8, 'Simba', 'Gato', 'Maine Coon', 3, 400.00, 'Gato grande y sociable, muy juguetón.', TO_DATE('2021-09-25','YYYY-MM-DD'), 'https://example.com/images/simba.jpg');

COMMIT;
