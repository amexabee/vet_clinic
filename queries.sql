/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu'); 

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true; 

SELECT * FROM animals WHERE name NOT IN ('Gabumon'); 

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals 
WHERE EXTRACT(year FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

SELECT name AS animal_name, owners.full_name AS owner FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name IN ('Melody Pond');

SELECT animals.name AS animal_name, species.name AS species FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name IN ('Pokemon');

SELECT * FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT * FROM animals
INNER JOIN species ON animals.species_id = species.id;

SELECT * FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name IN ('Digimon') AND owners.full_name IN ('Jennifer Orwell');

SELECT * FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name IN ('Dean Winchester') AND escape_attempts = 0;

SELECT COUNT(*) AS number_of_animals, owners.full_name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name;

/*

SELECT animals.name AS animal_name, species.name AS species FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name IN ('Pokemon');


What animals belong to Melody Pond? Y
List of all animals that are pokemon (their type is Pokemon). Y
List all owners and their animals, remember to include those that don't own any animal. Y
How many animals are there per species? Y
List all Digimon owned by Jennifer Orwell. Y
List all animals owned by Dean Winchester that haven't tried to escape.
Who owns the most animals? Y