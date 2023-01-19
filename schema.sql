/* Database schema to keep the structure of entire database. */



/* schema for the first code review */

CREATE TABLE animals (
  id              INT GENERATED ALWAYS AS IDENTITY,
  name            VARCHAR(250),
  date_of_birth   DATE,
  escape_attempts INT,
  neutered        BOOLEAN,
  weight_kg       DECIMAL,
  PRIMARY KEY(id)
);



/* schema for the second code review */

ALTER TABLE animals
ADD COLUMN species varchar(250);




/* schema for the third code review */

CREATE TABLE owners (
  id              INT GENERATED ALWAYS AS IDENTITY,
  full_name       VARCHAR(250),
  age             INT,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id              INT GENERATED ALWAYS AS IDENTITY,
  name            VARCHAR(250),
  PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_species 
FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_owners 
FOREIGN KEY (owner_id) 
REFERENCES owners (id);



/* schema for the fourth code review */

CREATE TABLE vets (
  id                 INT GENERATED ALWAYS AS IDENTITY,
  name               VARCHAR(250),
  age                INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  species_id  INT,
  vet_id      INT,
  primary key (species_id, vet_id)
);

CREATE TABLE visits (
  animal_id      INT,
  vet_id         INT,
  date_of_visit  DATE,
  primary key (animal_id, vet_id)
);


