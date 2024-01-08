-- Basics of Databases Course Project 
-- Created by: Aino Räkköläinen
-- Commands for creating tables, inserting the data and the requested queries


-- Creating the tables 

CREATE TABLE Company (
	company_ID INTEGER NOT NULL,
	company_name TEXT NOT NULL,
	PRIMARY KEY(company_ID)
);

CREATE TABLE Game (
	game_ID	INTEGER NOT NULL, 
	game_name TEXT NOT NULL, 
	description TEXT NOT NULL, 
	launching_date TEXT, 
	age_limit INTEGER NOT NULL, 
	FK_project_ID INTEGER NOT NULL,
	FK_project_team_ID INTEGER NOT NULL,
	PRIMARY KEY (game_ID), 
	FOREIGN KEY (FK_project_ID) REFERENCES Project(project_ID), 
	FOREIGN KEY (FK_project_team_ID) REFERENCES Project_team(team_ID)
);

CREATE TABLE Genre (
	fk_game_genre_ID INTEGER NOT NULL, 
	genre_content TEXT NOT NULL, 
	FOREIGN KEY(fk_game_genre_ID) REFERENCES Game(game_ID)
);

CREATE TABLE Player (
	username TEXT PRIMARY KEY NOT NULL UNIQUE, 
	age INTEGER CHECK (age >= 3)
);

CREATE TABLE Player_of_the_game ( 
	FK_related_to_game_ID INTEGER NOT NULL, 
	FK_username TEXT,
	played_hours INTEGER DEFAULT 0,
	UNIQUE (FK_related_to_game_ID, FK_username),
	FOREIGN KEY(FK_related_to_game_ID) REFERENCES Game(game_ID),
	FOREIGN KEY(FK_username) REFERENCES Player(username) 
);

CREATE TABLE Project (
	project_ID INTEGER NOT NULL, 
	project_name TEXT NOT NULL, 
	starting_time TEXT NOT NULL, 
	ending_time TEXT, 
	duration INTEGER NOT NULL, 
	budget INTEGER NOT NULL, 
	FK_company_ID INTEGER NOT NULL, 
	FK_project_team_ID INTEGER NOT NULL, 
	FOREIGN KEY(FK_company_ID) REFERENCES Company(company_ID),
	FOREIGN KEY(FK_project_team_ID) REFERENCES Project_team(team_ID), 
	PRIMARY KEY (project_ID AUTOINCREMENT)
);

CREATE TABLE Project_team (
	team_ID INTEGER NOT NULL, 
	team_name TEXT NOT NULL UNIQUE,
	PRIMARY KEY(team_ID)
);

CREATE TABLE Team_member (
	member_ID INTEGER NOT NULL PRIMARY KEY, 
	name TEXT NOT NULL UNIQUE, 
	phone_number TEXT UNIQUE, 
	work_email TEXT UNIQUE
);

CREATE TABLE Team_member_in_project (
  	role TEXT NOT NULL,
  	FK_group_ID INTEGER, 
  	FK_group_member_ID INTEGER, 
  	FOREIGN KEY (FK_group_ID) REFERENCES Project_team(team_ID), 
  	FOREIGN KEY (FK_group_member_ID) REFERENCES Team_member(member_ID)
);

CREATE TABLE Comments (
	FK_game_ID	INTEGER,
	content	TEXT
);

-- Inserting the companies

 INSERT INTO Company VALUES 
	(1, 'Game Development Oy'),
	(2, 'Gamers Club Oy'),
	(3, 'Developers of Game'),
	(4, 'Unknown game company'),
	(5, 'Not Rovio Or Any Famous Company' );
	
-- Defining project teams

INSERT INTO Project_team VALUES 
	-- Format: team_ID, name
	(1, 'Ping pong players'),
	(2, 'Tennis creators'),
	(3, 'The escape team'), 
	(4, 'Simulators team'), 
	(5, 'Pac-people'), 
	(6, 'Not Rovio Developers'), 
	(7, 'Club of gamers and developers'), 
	(8, 'Team unknowns'), 
	(9, 'Just Developers');


-- Inserting the team members

INSERT INTO Team_member VALUES 
	(0001, 'Matt Meikalainen', '0309225576', 'Matt.Meikalainen@game-development.fi'),
	(0002, 'Maija Meikalainen', '0409235578', 'Maija.Meikalainen@game-development.fi'),
	(0003, 'Matt Mattson', '0909995599', 'Matt.Mattson@game-development.fi'),
	(0004, 'Mary Mattson', '0902395900', 'Mary.Mattson@game-development.fi'),
	(0005, 'Jake Joker', '0902913344', 'Jake.Joker@gamers-club.fi'),
	(0006, 'Nora Roberts', '0802953344', 'Nora.Roberts@gamers-club.fi'),
	(0007, 'Thomas Thompson','0502923141', 'Thomas.Thompson@gamers-club.fi'),
	(0008, 'Eliza Pancakes', '0202020231', 'Eliza.Pancakes@developers.fi'),
	(0009, 'Bob Pancakes', '0220011433', 'Bob.Panckakes@developers.fi'), 
	(0010, 'Simon Simpson', '0237774512', 'Simon.Simpson@developers.fi'),
	(0011, 'Mary Marles', '0237884512', 'Mary.Marles@unknown-company.com'),
	(0012, 'Manny Mailer', '0234784512', 'Manny.Mailer@unknown-company.com'),
	(0013, 'Morrie Marles', '0112894613', 'Morrie.Marles@unknown-company.com'),
	(0014, 'Millie Mailer', '0237880015', 'Millie.Mailer@unknown-company.com'),
	(0015, 'Carrie Developerson', '0244881111', 'Carrie.Developerson@not-rovio.com'),
	(0016, 'Alex Developerson', '0244111111', 'Alex.Developerson@not-rovio.com'),
	(0017, 'Mary Developerson', '0243111113', 'Mary.Developerson@not-rovio.com'); 

	
-- Assigning the team_members to teams and the roles
-- Role, team_id, member_id
	-- Team members of company 1: ids: 0001-0004 Project_teams: 1, 2, 4 
INSERT INTO Team_member_in_project VALUES  
	('Developer', 1, 0001), 
	('UI Designer', 1, 0002), 
	('Developer', 2, 0001), 
	('Tester', 2, 0003), 
	('UI Designer', 2, 0002),
	('Developer', 4, 0004), 
	('Tester', 4, 0003), 
	('UI Designer', 4, 0001), 
	('Developer', 7, 0007), 
	('UI Designer', 7, 0006),
	('Developer', 9, 0005), 
	('UI Designer', 9, 0006), 
	('Tester', 9, 0007),
	('Developer', 3, 0008), 
	('UI Designer', 3, 0009), 
	('Tester', 3, 0010), 
	('Developer', 8, 0011), 
	('Tester', 8, 0012),
	('UI Designer', 8, 0013), 
	('Audio maker', 8, 0014),
	('Developer', 5, 0015), 
	('Tester', 5, 0016),
	('Designer', 5, 0017), 
	('Developer', 6, 0015), 
	('UI Designer', 6, 0016);

-- Inserting into projects

INSERT INTO Project VALUES
	-- Format: project_ID, name, starting_time, ending_time, duration, budget, FK_company_ID, FK_project_team_ID
	(1, 'Ping pong project', '15/02/2023', '-', 7, 10000, 1, 1),
	(2, 'Tennis game project', '10/01/2023', '22/02/2023', 43, 95000, 1, 2),
	(3, 'Escape game project', '21/02/2023', '-', 1, 120000, 3, 3),
	(4, 'Simulator project', '20/12/2022', '20/02/2023', 62, 95000, 1, 4),
	(5, 'New pacman', '20/02/2023', '-', 2, 150000, 5, 5),
	(6, 'New Angry Birds Game', '01/02/2023', '01/03/2023', 28, 125000, 5, 6),
	(7, 'Unknown Secret Game Project', '01/03/2023', '-', 1, 100000, 4, 8), 
	(8, 'Club simulator game', '01/02/2023/', '-', 29, 53000, 2, 7),  
	(9, 'Just simple game', '01/12/2022', '01/03/2023', 91, 10000, 2, 9),
	(10, 'Tennis game project 2', '13/01/2023', '23/02/2023', 41, 95000, 1, 2); 


-- Defining the games
-- Format: game_id, name, description, launching date, age limit, FK_project_ID, FK_project_team_ID
INSERT INTO Game VALUES
	(00011, 'How to play ping pong -simulator', 'This game teaches the player how to play ping pong in the right way', '-', 7,  1, 1),
	(00022, 'Tennis game for two', 'This is simple two-player game for simulating tennis match', '23/02/2023', 7, 1, 2),
	(00033, 'The Escape Room', 'Multiplayer game where players need to solve puzzles for getting out of the room in 60 minutes. Simulates the real life escape rooms.', '-', 12, 3, 3),
	(00044, 'The Simms 5', 'Low budget life simulator, takes inspiration from the famous The Sims - series but for legal reasons, you don''t know that.', '20/02/2023', 12, 4, 4),
	(00055, 'New Pac-Man: Adventure in the Jungle', 'This game mimics the traditional pac-man games but 3D pac-man seeks adventure in the Jungle', '-', 7, 5, 5),
	(00066, 'The Tennis Game for 4 Players', 'This game is second part for Tennis game for two. Simple four-player game for simulating tennis match', '23/02/2023', 7, 10, 2),
	(00077, 'New Angry-Birds Winter Edition', 'This game mimics the Angry Birds but it is happening in Winter Wonderland now.', '01/03/2023', 7, 6, 6), 
	(00088, 'Secret Puzzle Game', 'The description is secret, just play and test it yourself.', '-', 12, 7, 8), 
	(00099, 'Basics to clubbing', 'This simulator teaches you the basics of clubs.', '-', 16, 8, 7), 
	(00111, 'Simple simulator game', 'Too simple to explain :D, try yourself.', '01/03/2023', 7, 9, 9);


-- Creating players

INSERT INTO Player VALUES 
	('DonaldDUCK', 15),
	('Aikkuww', 20),
	('Iines', 13),
	('Player_1', 14),
	('Tester123', 15),
	('GamerPerson11', 18),
	('Player_2', 7),
	('Virtual_player', 10),
	('Pac-man3', 12),
	('Spider_MAN', 16),
	('Tennis_winner123', 30);

-- Inserting the genres
INSERT INTO Genre VALUES
	(00011, 'sport simulation'), 
	(00022, 'sport simulation'),
	(00033, 'puzzle'),
	(00044, 'Life simulation'),
	(00055, 'fighting'),
	(00066, 'sport simulation'),
	(00077, 'action'),
	(00088, 'unknown'),
	(00099, 'simulation'),
	(000111, 'platform');

-- Inserting the players of the game. (Only the launched games which are games: 2, 4, 6, 7, 10
--Format: FK_game_player_ID, FK_username, played_hours
INSERT INTO Player_of_the_game VALUES
	(00022, 'Aikkuww', 2), 
	(00044, 'Player_1', 10), 
	(00044, 'Player_2', 2),
	(00066, 'DonaldDUCK', 15), 
	(00066, 'Tennis_winner123',15), 
	(00066, 'Player_2',15), 
	(00066, 'Iines', 15), 
	(00077, 'Tester123', 3),
	(00111, 'Tester123', 1); 


-- Inserting comments for the games: 

INSERT INTO Comments VALUES 
	(00066, 'Boring game'),
	(00066, 'Nice game and easy to win! Fun to play with friends'),
	(00022, 'Easy to play and fun to play with friends'), 
	(00044, 'Boring, didn''t like'), 
	(00111, 'No opinion yet but seems good.');

-- The Queries
-- Query 1) Prints all projects the member with id 3 from company 1 is working on and what role the member has
SELECT company_name AS 'Company', name AS 'Member name', role AS Role, team_name AS 'Team name' FROM Team_member 
INNER JOIN Team_member_in_project ON Team_member.member_ID = Team_member_in_project.FK_group_member_ID
INNER JOIN Project_team ON Project_team.team_ID = Team_member_in_project.FK_group_ID
INNER JOIN Company ON Company.company_ID == 1 
WHERE member_ID == 3
ORDER BY member_ID;


-- Query 2) Printing all currently developed games in genre simulation (normal simulation or sport simulation)

SELECT game_name AS 'Game name', genre_content AS 'Genre' FROM Genre
INNER JOIN Game ON Genre.fk_game_genre_ID == Game.game_ID AND Genre.genre_content LIKE '%simulation' AND Game.launching_date == '-';

-- Query 3) List all games that have been launched and have received feedback. Includes also the duration and budget of that game so the user can see
-- was it worth it to use that much time and money. Of course, in real database there would be much more feedback than in this. 
CREATE INDEX FK_company_ID ON Project(FK_company_ID); 
CREATE INDEX FK_project_ID ON Game(FK_project_ID);
SELECT company_name AS 'Launched by', game_name as 'Game name', content AS 'Feedback', duration || ' days' AS 'Number of days used', budget || ' euros' AS 'Amount of money used' FROM Comments
INNER JOIN Company ON Company.company_ID == Project.FK_company_ID
INNER JOIN Game ON Game.game_ID == Comments.FK_game_ID
INNER JOIN Project ON Project.project_ID == Game.FK_project_ID; 

-- Query 4) Listing all project names, responsible developer which team, start and end dates, duration, ordered by duration
SELECT project_name AS 'Project name', name ||' from '||team_name AS 'Responsible developer from team', starting_time AS 'Project started', ending_time AS 'Project ended', duration || ' days (to 01/03/2023)' AS 'Days used on 01/03/2023' FROM Project
INNER JOIN Project_team ON Project.FK_project_team_ID == Project_team.team_ID
INNER JOIN Team_member_in_project ON Project_team.team_ID == Team_member_in_project.FK_group_ID AND Team_member_in_project.role == 'Developer'
INNER JOIN Team_member ON Team_member_in_project.FK_group_member_ID == Team_member.member_ID
ORDER BY duration;

-- Query 5) List all games and their descriptions
CREATE VIEW Games AS SELECT game_name AS 'Game', description FROM Game ORDER BY game_name ASC; 

-- Query 6) List all players (usernames, ages) of the game with ID 66 and the age limit of the game
SELECT game_ID as 'ID', game_name AS 'Game' , username AS 'Player', age AS 'Age', age_limit AS 'Age limit', played_hours || ' hours' AS 'Played hours' FROM Player_of_the_game
INNER JOIN Player ON Player_of_the_game.FK_username == Player.username
INNER JOIN Game ON Player.age >= Game.age_limit AND Player_of_the_game.FK_related_to_game_ID == Game.game_ID AND Game.game_ID == 66
ORDER BY username;