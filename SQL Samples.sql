
# Use the record_company database, and create a table for bands, albums, and songs

use record_company;

create table bands(
id int not null auto_increment primary key,
name varchar(255) not null
);

create table albums(
id int not null auto_increment,
name varchar(255) not null,
length float,
band_id int not null,
primary key (id),
foreign key (band_id) references bands(id)
);

create table songs1(
id int not null auto_increment primary key,
name varchar(255) not null,
length float,
album_id int not null,
foreign key (album_id) references albums(id)
);


# Finding the oldest album by release date
select * from albums 
where release_year is not null
order by release_year 
limit 1;

#using join to find all bands from bands table, with albums in the albums table
#also using an alias to change the column display name

select distinct bands.name as 'Band Name' from bands
inner join albums on bands.id = albums.band_id
;


#Find bands without an entry in the albums table

select bands.name as 'Band Name' from bands
left join albums on bands.id = albums.band_id
group by bands.id
having count(albums.id) = 0
;


#Find the longest album, by joining the album and songs table

select albums.name as 'Name', 
 albums.release_year as 'Release Year', 
 sum(songs.length) as 'Duration'
from albums
join songs on songs.album_id = albums.id
group by albums.name
order by sum(songs.length) desc
limit 1
;


#Find an album with no release year, set the release year, then check the table

select * from albums
where release_year is null;

update albums
set release_year = 1986
where id = 4;

select * from albums;


#Inserting a record into the bands table, and an associated album in the albums table
insert into bands(name)
values ('Ryders Band');

select * from bands;

insert into albums(name, release_year, band_id)
values ('Ryders album', 2021, 8);

select * from albums
where band_id = 8;

# Deleting the entries just made

delete from albums
where id = 19;
delete from bands
where id = 8;

#Find the average song length
select avg(length) as 'Average Song Duration' from songs;

#Selecting the longest song from each album
select a.name as 'Album', 
  a.release_year as 'Release Year', 
  max(s.length) as 'Duration' 
from albums as a
join songs as s on a.id = s.album_id
group by a.name
;

#Get the number of songs for each band, by joining 3 tables.
select b.name as 'Band', count(s.name) as 'Number of Songs' 
 from bands as b
	join albums as a on b.id = a.band_id
    join songs as s on a.id = s.album_id
group by b.name
;





