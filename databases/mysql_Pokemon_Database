
create database Pokemon;
use Pokemon;

create table Trainers (
ID INT AUTO_INCREMENT PRIMARY KEY, 
FirstNamme varchar(20), 
Lastname varchar(20),
JapaneseName varchar(20),
HomeTown varchar(25),
Gender varchar (10),
Age smallint
) ENGINE=MyISAM;

insert into Trainers (FirstNamme,Lastname,JapaneseName,HomeTown,Gender,Age) VALUES
('Ash', 'Ketchum','Satoshi','Pallet','male','10'),
('Misty','WaterFlower','Kasumi','Cerulean_City','Female','11'),
('Brock',null,'Takeshi','Pewter_City','Male','13'),
('Tracey','Skechit','Kenji','Orange_Islands','Male','13'),
('May',null,'Haruka','Petalburg_City','Female','10'),
('Max',null,'Masato','Petalburg_City','Male','6'),
('Jessie',null,'Musashi','Sunny_Town','Female','16'),
('James',null,'Kojiro','Sunny_Town','Male','17'),
('Dawn',null,'Hikari','Twinleaf_Town','Female','10'),
('Iris',null,'Iris','Village_of_Dragons','Female','11');
------------------------------------------------
create table TypeName (
ID INT AUTO_INCREMENT PRIMARY KEY,
Name varchar(20)
)
ENGINE=MyISAM;

insert into TypeName (Name) values 
('Poison'),
('Fire'),
('Water'),
('Normal'),
('Bug'),
('Electric'),
('Ice'),
('Fairy'),
('Ground'),
('Steel'),
('Dark'),
('Fighting'),
('spychic'),
('Dragon'),
('Rock'),
('Ghost');
------------------------------
create table Pokemons (
ID INT AUTO_INCREMENT PRIMARY KEY,
PokemonName varchar(40),
TypeID int,
Total int,
HP int,
Attack int,
Defense int,
SP_Atk int,
SP_Def int,
Speed int, 
FOREIGN KEY (TypeID) references TypeName(ID))
ENGINE=MyISAM;

insert into Pokemons (PokemonName,TypeID,Total,Attack,Defense,SP_Atk,SP_Def,Speed) values
('Pikachu',6, 320,35,55,40,50,50,90),
('Treecko',4,310,40,45,35,65,55,70),
('Torkoal',2, 470,70,85,140,85,70,20),
('Grovyle',4,405,50,65,45,85,65,95),
('Phanpy',9,330,90,60,60,40,40,40),
('Swellow',12,455,60,85,60,75,50,125),
('Aipom',4,360,55,70,55,40,55,85),
('Rhydon',9,485,105,130,120,45,45,40),
('Golem',15,495,80,120,130,55,65,45),
('Onix',15,385,35,45,160,30,45,70),
('Sandslash',9,450,75,100,110,45,55,65),
('Zubat',1,245,40,45,35,30,40,55),
('Geodude',15,300,40,80,100,30,30,20),
('Golbat',1,455,75,80,70,65,75,90),
('Mankey',12,305,40,80,35,35,45,70),
('Sandshrew',9,300,50,75,85,20,30,40),
('Croagunk',1,300,48,61,40,61,40,50),
('Seadra',3,440,55,65,95,95,45,85),
('Tentacruel',3,515,80,70,65,80,120,100),
('Cloyster',7,525,50,95,180,85,45,70),
('Goldeen',3,320,45,67,60,35,50,63),
('Poliwrath',3,510,90,95,95,70,90,70),
('Psyduck',3,320,50,52,48,65,50,55),
('Poliwag',3,300,40,50,40,40,40,90),
('Hitmonchan',12,455,50,105,79,35,110,76),
('Moltres',2,580,90,100,90,125,85,90),
('Scyther',5,500,70,110,80,55,80,105),
('Snorlax',4,540,160,110,65,65,110,30),
('Mewtwo',13,680,106,110,90,154,90,130),
('Tyranitar',11,600,100,134,110,95,100,61),
('Meowth',4,290,40,45,35,40,40,90),
('Wobbuffet',13,405,190,33,58,33,58,33),
('Torchic',2,310,45,60,40,70,50,45),
('Munchlax',4,390,135,85,40,40,85,5),
('Combusken',2,405,60,85,60,85,60,55),
('Piplup',3,314,53,51,53,61,56,40),
('Buneary',4,350,55,66,44,44,56,85),
('Braixen',2,409,59,59,58,90,70,73),
('Jigglypuff',8,270,115,45,20,45,25,20),
('Kadabra',13,400,40,35,30,120,70,105),
('Delibird',7,330,45,55,45,65,45,75),
('Magearna',10,600,80,95,115,130,115,65);
----------------------------------------
 create table PokemonOwner (
 PokemonID int,
 TrainerID int,
 FOREIGN KEY (PokemonID) references Pokemons(ID),
 FOREIGN KEY (TrainerID) references Trainers(ID))
ENGINE=MyISAM;
 
insert into PokemonOwner ( PokemonID,TrainerID) values 
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,3),
(9,3),
(10,3),
(11,3),
(12,3),
(13,3),
(14,3),
(15,3),
(16,3),
(17,3),
(18,2),
(19,2),
(20,2),
(21,2),
(22,2),
(23,2),
(24,2),
(25,8),
(26,8),
(27,8),
(28,8),
(29,7),
(30,7),
(31,7),
(32,7),
(33,5),
(34,5),
(35,5),
(36,9),
(37,9);



###### Pokemon Database Exercises ######

use pokemon;


###### Trainers without pokemons
select firstname, pokemonid from trainers as T
left join pokemonowner as P
on t.id=p.trainerid
where pokemonid is null;

##### Pokemons without trainers
select pokemonname, trainerid from pokemons as pk
left join pokemonowner as P
on pk.id=p.pokemonid
where trainerid is null;

###### The most popular type by name in the Pokemons table
select name, count(typeid) as totalcount 
from pokemons as p
join typename as t
on p.typeid = t.id
group by name
order by count(typeid) desc;

##### Who has the most powerful army of pokemon in total (by total power)
select firstname, sum(total) as totalpower from trainers as t
join pokemonowner as po
on t.id=po.trainerid
join pokemons as p
on po.pokemonid=p.id
group by firstname
order by sum(total) desc
