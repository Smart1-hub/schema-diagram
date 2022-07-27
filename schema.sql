/* Database schema for keeping the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals 
ADD column species varchar(100);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100),
    age integer
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

ALTER TABLE animals DROP column species;
ALTER TABLE animals ADD column species_id int REFERENCES species(id);
ALTER TABLE animals ADD column owner_id int REFERENCES owners(id);

-- add join table 
CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(250),
  age INT,
  date_of_graduation DATE
);

CREATE TABLE specializations(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  species_id INT,
  vets_id INT,
  CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
  CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  animals_id INT,
  vets_id INT,
  date_of_visit DATE,
  CONSTRAINT fk_visit_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
  CONSTRAINT fk_visits_vet FOREIGN KEY(vets_id) REFERENCES vets(id)
);
