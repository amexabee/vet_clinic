/*Queries that provide answers to the questions from all projects.*/



/* Queries for the first code review  */

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu'); 

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true; 

SELECT * FROM animals WHERE name NOT IN ('Gabumon'); 

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;




/* Queries for the second code review  */

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





/* Queries for the third code review  */

SELECT name AS animal_name, owners.full_name AS owner FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name IN ('Melody Pond');

SELECT animals.name AS animal_name, species.name AS species FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name IN ('Pokemon');

SELECT name AS animal_name, owners.full_name AS owner FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT animals.name AS animal_name, species.name AS species FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY animals.name, species.name;

SELECT animals.name AS animal_name, species.name AS species, owners.full_name AS owner FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name IN ('Digimon') AND owners.full_name IN ('Jennifer Orwell')
GROUP BY animals.name, species.name, owners.full_name;

SELECT animals.name AS animal_name, owners.full_name AS owner FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name IN ('Dean Winchester') AND escape_attempts = 0;
GROUP BY animals.name, owners.full_name;

SELECT COUNT(*) AS number_of_animals, owners.full_name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name;





/* Queries for the fourth code review  */

SELECT vets.name AS visitor, animals.name AS animal_name, date_of_visit FROM visits
INNER JOIN vets ON vets.id = vet_id
INNER JOIN animals ON animals.id = animal_id
WHERE vets.name IN ('William Tatcher');
GROUP BY date_of_visit, vets.name, animals.name;

SELECT vets.name AS visitor, animals.name AS animal_name FROM visits
INNER JOIN vets ON vets.id = vet_id
INNER JOIN animals ON animals.id = animal_id
WHERE vets.name IN ('Stephanie Mendez');

SELECT vets.name AS vet, species.name AS speciality FROM specializations
INNER JOIN species ON species.id = species_id
RIGHT JOIN vets ON vets.id = vet_id;

SELECT animals.name AS animal_name, vets.name AS visited, date_of_visit FROM visits
INNER JOIN vets ON vets.id = vet_id
INNER JOIN animals ON animals.id = animal_id
WHERE vets.name IN ('Stephanie Mendez') AND date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30';

SELECT COUNT(*) AS number_of_visits, animals.name AS animal_name FROM visits
INNER JOIN animals ON animals.id = animal_id
GROUP BY animals.name;

SELECT vets.name AS visitor, animals.name AS animal_name, date_of_visit FROM visits
INNER JOIN vets ON vets.id = vet_id
INNER JOIN animals ON animals.id = animal_id
WHERE vets.name IN ('Maisy Smith')
GROUP BY date_of_visit, vets.name, animals.name;

SELECT DISTINCT a.name AS animal_name, a.date_of_birth AS animal_dob, escape_attempts, neutered, weight_kg, 
s.name AS species_name, v.name AS visitor, v.age, v.date_of_graduation, date_of_visit FROM visits
INNER JOIN vets v ON v.id = visits.vet_id
INNER JOIN animals a ON a.id = animal_id
INNER JOIN species s ON s.id = species_id
INNER JOIN specializations ON specializations.species_id = s.id
WHERE date_of_visit >= '2021-05-04';

SELECT COUNT(*) FROM visits
WHERE vet_id NOT IN (SELECT vet_id FROM specializations
WHERE species_id = (SELECT species_id FROM animals
WHERE id = visits.animal_id));

SELECT vets.name AS visitor, date_of_visit, animals.name AS animal_name, species.name AS species_name FROM visits
INNER JOIN vets ON vets.id = visits.vet_id
INNER JOIN animals ON animals.id = animal_id
INNER JOIN species ON species.id = species_id
WHERE vets.name IN ('Maisy Smith');
