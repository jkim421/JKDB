DROP TABLE IF EXISTS fighters;
DROP TABLE IF EXISTS divisions;
DROP TABLE IF EXISTS promotions;

CREATE TABLE fighters (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  ranking INTEGER,
  division_id INTEGER,

  FOREIGN KEY(division_id) REFERENCES divisions(id)
);

CREATE TABLE divisions (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  weight_limit INTEGER NOT NULL,
  promotion_id INTEGER,

  FOREIGN KEY(promotion_id) REFERENCES promotions(id)
);

CREATE TABLE promotions (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL
);

INSERT INTO
  promotions (id, name, country)
VALUES
  (1, "Ultimate Fighting Championship", "USA");

INSERT INTO
  divisions (id, name, weight_limit, promotion_id)
VALUES
  (1, "Flyweight", 125, 1),
  (2, "Bantamweight", 135, 1),
  (3, "Featherweight", 145, 1),
  (4, "Lightweight", 155, 1),
  (5, "Welterweight", 170, 1),
  (6, "Middleweight", 185, 1),
  (7, "Light Heavyweight", 205, 1),
  (8, "Heavyweight", 265, 1),
  (9, "Women's Strawweight", 115, 1),
  (10, "Women's Flyweight", 125, 1),
  (11, "Women's Bantamweight", 135, 1);

INSERT INTO
  fighters (id, name, ranking, division_id)
VALUES
  (1,"Henry Cejudo",0,1),
  (2,"Jussier Formiga",1,1),
  (3,"Joseph Benavidez",2,1),
  (4,"Ray Borg",3,1),
  (5,"Deiveson Figueiredo",4,1),
  (6,"John Moraga",5,1),
  (7,"Wilson Reis",6,1),
  (8,"Alexandre Pantoja",7,1),
  (9,"Dustin Ortiz",8,1),
  (10,"Alex Perez",9,1),
  (11,"Tim Elliott",10,1),
  (12,"Magomed Bibulatov",11,1),
  (13,"Said Nurmagomedov",12,1),
  (14,"Ryan Benoit",13,1),
  (15,"Eric Shelton",14,1),
  (16,"Matt Schnell",15,1),
  (17,"TJ Dillashaw",0,2),
  (18,"Cody Garbrandt",1,2),
  (19,"Dominick Cruz",2,2),
  (20,"Raphael Assuncao",3,2),
  (21,"Marlon Moraes",4,2),
  (22,"Jimmie Rivera",5,2),
  (23,"John Lineker",6,2),
  (24,"Aljamain Sterling",7,2),
  (25,"John Dodson",8,2),
  (26,"Pedro Munhoz",9,2),
  (27,"Rob Font",10,2),
  (28,"Cody Stamann",11,2),
  (29,"Alejandro Perez",12,2),
  (30,"Thomas Almeida",13,2),
  (31,"Petr Yan",14,2),
  (32,"Rani Yahya",15,2),
  (33,"Max Holloway",0,3),
  (34,"Brian Ortega",1,3),
  (35,"Jose Aldo",2,3),
  (36,"Frankie Edgar",3,3),
  (37,"Alexander Volkanovski",4,3),
  (38,"Renato Moicano",5,3),
  (39,"Jeremy Stephens",6,3),
  (40,"Cub Swanson",7,3),
  (41,"Mirsad Bektic",8,3),
  (42,"Chad Mendes",8,3),
  (43,"Josh Emmett",10,3),
  (44,"Ricardo Lamas",11,3),
  (45,"Yair Rodriguez",12,3),
  (46,"Chan Sung Jung",13,3),
  (47,"Zabit Magomedsharipov",14,3),
  (48,"Darren Elkins",15,3),
  (49,"Khabib Nurmagomedov",0,4),
  (50,"Tony Ferguson",1,4),
  (51,"Conor McGregor",2,4),
  (52,"Dustin Poirier",3,4),
  (53,"Al Iaquinta",4,4),
  (54,"Kevin Lee",5,4),
  (55,"Edson Barboza",6,4),
  (56,"Justin Gaethje",7,4),
  (57,"Anthony Pettis",8,4),
  (58,"James Vick",9,4),
  (59,"Nate Diaz",10,4),
  (60,"Alexander Hernandez",11,4),
  (61,"Francisco Trinaldo",12,4),
  (62,"Dan Hooker",13,4),
  (63,"Paul Felder",14,4),
  (64," Gregor Gillespie",15,4),
  (65,"Tyron Woodley",0,5),
  (66,"Colby Covington",1,5),
  (67,"Kamaru Usman",2,5),
  (68,"Darren Till",3,5),
  (69,"Stephen Thompson",4,5),
  (70,"Rafael Dos Anjos",5,5),
  (71,"Robbie Lawler",6,5),
  (72,"Santiago Ponzinibbio",7,5),
  (73,"Demian Maia",8,5),
  (74,"Jorge Masvidal",9,5),
  (75,"Leon Edwards",10,5),
  (76,"Neil Magny",11,5),
  (77,"Gunnar Nelson",12,5),
  (78,"Donald Cerrone",13,5),
  (79,"Elizeu Dos Santos",14,5),
  (80,"Alex Oliveira",15,5),
  (81,"Robert Whittaker",0,6),
  (82,"Yoel Romero",1,6),
  (83,"Luke Rockhold",2,6),
  (84,"Ronaldo Souza",3,6),
  (85,"Kelvin Gastelum",4,6),
  (86,"Chris Weidman",5,6),
  (87,"Israel Adesanya",6,6),
  (88,"Paulo Costa",7,6),
  (89,"Derek Brunson",8,6),
  (90,"Jared Cannonier",9,6),
  (91,"Brad Tavares",10,6),
  (92,"David Branch",11,6),
  (93,"Antonio Carlos Junior",12,6),
  (94,"Uriah Hall",13,6),
  (95,"Elias Theodorou",14,6),
  (96,"Thiago Santos",15,6),
  (97,"Jon Jones",0,7),
  (98,"Daniel Cormier",1,7),
  (99,"Alexander Gustafsson",2,7),
  (100,"Anthony Smith",3,7),
  (101,"Jan Blachowicz",4,7),
  (102,"Volkan Oezdemir",5,7),
  (103,"Corey Anderson",6,7),
  (104,"Thiago Santos",7,7),
  (105,"Dominick Reyes",8,7),
  (106,"Ilir Latifi",9,7),
  (107,"Jimi Manuwa",10,7),
  (108,"Ovince Saint Preux",11,7),
  (109,"Glover Teixeira",12,7),
  (110,"Mauricio Rua",13,7),
  (111,"Misha Cirkunov",14,7),
  (112,"Nikita Krylov",15,7),
  (113,"Daniel Cormier",0,8),
  (114,"Stipe Miocic",1,8),
  (115,"Derrick Lewis",2,8),
  (116,"Francis Ngannou",3,8),
  (117,"Curtis Blaydes",4,8),
  (118,"Alexander Volkov",5,8),
  (119,"Alistair Overeem",6,8),
  (120,"Junior Dos Santos",7,8),
  (121,"Aleksei Oleinik",8,8),
  (122,"Marcin Tybura",9,8),
  (123,"Justin Willis",10,8),
  (124,"Tai Tuivasa",11,8),
  (125,"Shamil Abdurakhimov",12,8),
  (126,"Walt Harris",13,8),
  (127,"Andrei Arlovski",14,8),
  (128,"Stefan Struve",15,8),
  (129,"Rose Namajunas",0,9),
  (130,"Jessica Andrade",1,9),
  (131,"Joanna Jedrzejczyk",2,9),
  (132,"Nina Ansaroff",3,9),
  (133,"Tatiana Suarez",4,9),
  (134,"Claudia Gadelha",5,9),
  (135,"Karolina Kowalkiewicz",6,9),
  (136,"Tecia Torres",7,9),
  (137,"Michelle Waterson",8,9),
  (138,"Carla Esparza",9,9),
  (139,"Felice Herrig",10,9),
  (140,"Cortney Casey",11,9),
  (141,"Cynthia Calvillo",12,9),
  (142,"Alexa Grasso",13,9),
  (143,"Randa Markos",14,9),
  (144,"Mackenzie Dern",15,9),
  (145,"Valentina Shevchenko",0,10),
  (146,"Jessica Eye",1,10),
  (147,"Sijara Eubanks",2,10),
  (148,"Katlyn Chookagian",3,10),
  (149,"Joanna Jedrzejczyk",4,10),
  (150,"Alexis Davis",5,10),
  (151,"Liz Carmouche",6,10),
  (152,"Roxanne Modafferi",7,10),
  (153,"Lauren Murphy",8,10),
  (154,"Jessica-Rose Clark",9,10),
  (155,"Joanne Calderwood",10,10),
  (156,"Jennifer Maia",11,10),
  (157,"Ashlee Evans-Smith",12,10),
  (158,"Mara Romero Borella",13,10),
  (159,"Andrea Lee",14,10),
  (160,"Montana De La Rosa",15,10),
  (161,"Amanda Nunes",0,11),
  (162,"Germaine De Randamie",1,11),
  (163,"Holly Holm",2,11),
  (164,"Ketlen Vieira",3,11),
  (165,"Raquel Pennington",4,11),
  (166,"Cat Zingano",5,11),
  (167,"Marion Reneau",6,11),
  (168,"Aspen Ladd",7,11),
  (169,"Sara McMann",8,11),
  (170,"Yana Kunitskaya",9,11),
  (171,"Irene Aldana",10,11),
  (172,"Tonya Evinger",11,11),
  (173,"Bethe Correia",12,11),
  (174,"Lina Lansberg",13,11),
  (175,"Lucie Pudilova",14,11),
  (176,"Talita Bernardo",15,11);
