
CREATE TABLE country (
  country_id INT primary key,
  country_iso_code VARCHAR(10) ,
  country_name VARCHAR(200)
);

CREATE TABLE gender (
  gender_id INT primary key,
  gender VARCHAR(20) 
);

CREATE TABLE genre (
  genre_id INT primary key,
  genre_name VARCHAR(100)
);

CREATE TABLE language (
  language_id INT primary key,
  language_code VARCHAR(10),
  language_name VARCHAR(500)
);

CREATE TABLE language_role (
  role_id INT  primary key,
  language_role VARCHAR(20)
);

CREATE TABLE department (
  department_id INT primary key ,
  department_name VARCHAR(200)
);

CREATE TABLE keyword (
  keyword_id INT primary key,
  keyword_name varchar(100)
);

CREATE TABLE person (
  person_id INT primary key,
  person_name varchar(500)
);

CREATE TABLE production_company (
  company_id INT primary key,
  company_name varchar(200) 
);

CREATE TABLE movie (
  movie_id INT primary key ,
  title VARCHAR(1000),
  budget INT,
  homepage VARCHAR(1000) ,
  overview VARCHAR(1000) ,
  popularity DECIMAL(12,6),
  release_date DATE ,
  revenue BIGINT(20) ,
  runtime INT ,
  movie_status VARCHAR(50) ,
  tagline VARCHAR(1000) ,
  vote_average DECIMAL(4,2) ,
  vote_count INT
);

CREATE TABLE movie_cast (
  movie_id INT ,
  person_id INT,
  character_name varchar(400),
  gender_id INT ,
  cast_order int(5)
);

CREATE TABLE movie_company (
  movie_id INT ,
  company_id INT
  );
  
  CREATE TABLE movie_crew (
  movie_id INT ,
  person_id INT,
  department_id INT,
  job VARCHAR(200)
);

CREATE TABLE movie_genres (
  movie_id INT,
  genre_id INT
);

CREATE TABLE movie_keywords (
  movie_id INT ,
  keyword_id INT
);

CREATE TABLE movie_languages (
  movie_id INT,
  language_id INT ,
  language_role_id INT
);

CREATE TABLE production_country (
  movie_id INT,
  country_id INT
  );
  
alter table country modify country_id int not null;
alter table country modify country_id int auto_increment;

alter table gender modify gender_id int not null;

alter table genre modify genre_id int not null;

alter table language  modify language_id  int not null;
alter table language  modify language_id  int auto_increment;

alter table department  modify role_id  int not null;
alter table department   modify role_id  int auto_increment;

alter table keyword  modify keyword_id  int not null;

alter table production_company  modify company_id  int not null;

alter table person  modify person_id  int not null;

alter table movie  modify movie_id  int not null;
alter table movie   modify movie_id  int auto_increment;

ALTER TABLE production_country ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE production_country ADD FOREIGN KEY (country_id) REFERENCES country(country_id);

ALTER TABLE movie_languages ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE movie_languages ADD FOREIGN KEY (language_id) REFERENCES language(language_id);
ALTER TABLE movie_languages ADD FOREIGN KEY (language_role_id) REFERENCES language_role(role_id);

ALTER TABLE movie_genres ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE movie_genres ADD FOREIGN KEY (genre_id) REFERENCES genre(genre_id);

ALTER TABLE movie_keywords ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE movie_keywords ADD FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id);

ALTER TABLE movie_company ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE movie_company ADD FOREIGN KEY (company_id) REFERENCES production_company(company_id);

ALTER TABLE movie_cast ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE movie_cast ADD FOREIGN KEY (gender_id) REFERENCES gender(gender_id);
ALTER TABLE movie_cast ADD FOREIGN KEY (person_id) REFERENCES person(person_id);

ALTER TABLE movie_crew ADD FOREIGN KEY (movie_id) REFERENCES movie(movie_id);
ALTER TABLE movie_crew ADD FOREIGN KEY (person_id) REFERENCES person(person_id);
ALTER TABLE movie_crew ADD FOREIGN KEY (department_id) REFERENCES department(department_id);

