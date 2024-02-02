# alter table reigon modify id int auto_increment primary key 
######################################################################

# this is the first task

CREATE TABLE author (
    author_id INT primary key ,
	author_name varchar(255)
);

CREATE TABLE address_status (
    status_id INT primary key ,
	address_status varchar(255)
    
);
CREATE TABLE publisher (
    publisher_id INT primary key ,
	publisher_name VARCHAR(255)
);

CREATE TABLE book_language (
    language_id INT primary key ,
	language_code varchar(255),
    language_name varchar(255)
);
CREATE TABLE shipping_method (
    method_id INT primary key ,
	method_name varchar(255),
    cost int
);

CREATE TABLE order_status (
    status_id INT primary key ,
	status_value varchar(255)
);

CREATE TABLE country (
    country_id INT primary key ,
	country_name varchar(255)
    
);

CREATE TABLE customer (
    customer_id INT primary key ,
	first_name varchar(255),
    last_name varchar(255),
    email varchar(255)
);



######################################
CREATE TABLE address (
    address_id INT primary key ,
	street_number varchar(255),
    street_name varchar(255),
    city varchar(255),
    country_id int,
    
    foreign key (country_id)  references country(country_id)
);

create Table customer_address(
	customer_id INT ,
    address_id int,
    status_id int,
    
    foreign key (customer_id)  references customer(customer_id),
	foreign key (address_id)  references address(address_id),
    foreign key (status_id)  references address_status(status_id),
    
    primary key(customer_id,address_id)



);

CREATE TABLE book (
    book_id INT primary key ,
	title varchar(255),
    isbn13 varchar(255),
    language_id int ,
    num_pages int,
    publication_date Date,
    publisher_id int,
    
	foreign key (language_id)  references book_language(language_id), 
	foreign key (publisher_id)  references publisher(publisher_id)
);

CREATE TABLE book_author (
    book_id INT ,
	author_id int,
    
	foreign key (book_id)  references book(book_id), 
	foreign key (author_id)  references author(author_id),
    
    primary key (book_id , author_id )
);

CREATE TABLE cust_order (
    order_id INT primary key auto_increment ,
	order_date datetime,
    customer_id int,
    shipping_method_id int,
    dest_address_id int,
    
    foreign key (customer_id)  references customer(customer_id), 
	foreign key (shipping_method_id)  references shipping_method(method_id),
	foreign key (dest_address_id)  references address(address_id)

);

CREATE TABLE order_line (
    line_id INT primary key auto_increment ,
	order_id int,
    book_id int,
    price int,
    
    foreign key (book_id)  references book(book_id), 
	foreign key (order_id)  references cust_order(order_id)
);


CREATE TABLE order_history (
    history_id INT primary key auto_increment ,
	order_id int,
    status_id int ,
    status_date date,
    
	foreign key (status_id)  references order_status(status_id)
    
);





####################################################################################################################################
CREATE TABLE genre (
    ID INT primary key,
    genre_name VARCHAR(255)
);

create TABLE game (
    ID INT primary key,
    genre_id INT , 
    genre_name VARCHAR(255),
    
    Foreign key (genre_id) references genre(ID)
);

CREATE TABLE publisher (
    ID INT primary key,
    publisher_name VARCHAR(255)
);

CREATE TABLE game_publisher (
    ID INT primary key auto_increment,
	game_iD INT,
    publisher_id int ,
    
    constraint f1 foreign key (game_iD)  references game(id), 
	constraint f2 foreign key (publisher_id)  references publisher(id)
);

CREATE TABLE platform (
    ID INT primary key,
    platform_name VARCHAR(255)
);

CREATE TABLE reigon (
    ID INT primary key,
    reigon_name VARCHAR(255)
);

CREATE TABLE game_platform (
    ID INT primary key auto_increment,
	game_publisher_id INT,
    platform_id int ,
    release_year int ,
    
	foreign key (game_publisher_id)  references game_publisher(id), 
	foreign key (platform_id)  references platform(id)
);

CREATE TABLE reigon_sales (
    reigon_id INT auto_increment,
	game_platform_id INT,
    num_sales int ,
    
	foreign key (reigon_id)  references reigon(id), 
	foreign key (game_platform_id)  references game_platform(id),
    primary key (reigon_id,game_platform_id)
);




















