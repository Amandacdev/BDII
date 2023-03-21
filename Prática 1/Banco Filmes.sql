--Tarefa 1

CREATE TABLE Filme (
   	CodFILME   	Serial  NOT NULL,
   	Titulo      	Varchar(25),
   	Ano         	integer,
   	Duracao   	integer,
   	CodCATEG   	integer,
   	CodEst     	integer);
	
CREATE TABLE Artista (
   	CodART  	Serial  NOT NULL,
   	NomeART		Varchar(25),
   	Cidade      	Varchar(20),
   	Pais        	Varchar(20),
   	DataNasc   	Date);
	
CREATE TABLE Estudio (
   	CodEst 		serial  NOT NULL,
   	NomeEst		Varchar(25));
	
CREATE TABLE Categoria (
   	CodCATEG   	serial  NOT NULL,
   	DescCATEG 	VARCHAR(25));
	
CREATE TABLE Personagem (
   	CodART 		integer  NOT NULL,
   	CodFILME   	integer  NOT NULL,
   	NomePers  	VARCHAR(25),
   	Cache       	numeric(15,2));
	
ALTER TABLE Filme ADD CONSTRAINT PKFilme PRIMARY KEY(CodFILME);
ALTER TABLE Artista ADD CONSTRAINT PKArtista PRIMARY KEY(CodART);
ALTER TABLE Estudio ADD CONSTRAINT PKEst PRIMARY KEY(CodEst);
ALTER TABLE Categoria ADD CONSTRAINT PKCategoria PRIMARY KEY(CodCATEG);

ALTER TABLE Personagem ADD CONSTRAINT PKPersonagem PRIMARY KEY(CodART,CodFILME);
ALTER TABLE Filme ADD CONSTRAINT FKFilme1Categ FOREIGN KEY(CodCATEG) REFERENCES Categoria;
ALTER TABLE Filme ADD CONSTRAINT FKFilme2Estud FOREIGN KEY(CodEst) REFERENCES Estudio;
ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem2Artis FOREIGN KEY(CodART) REFERENCES Artista;
ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem1Filme FOREIGN KEY(CodFILME) REFERENCES Filme;

insert into categoria values(default,'Aventura');
insert into categoria values(default,'Romance');
insert into categoria values(default,'Com�dia');
insert into categoria values(default,'A��o');
insert into categoria values(default,'Suspense');
insert into categoria values(default,'Drama');

insert into estudio values(default,'Paramount');
insert into estudio values(default,'Disney');
insert into estudio values(default,'Universal');

insert into filme values(default,'Encontro Explosivo',2010,134,4,1);
insert into filme values(default,'O Besouro Verde',2010,155,1,1);
insert into filme values(default,'Comer, Rezar, Amar',2010,177,2,1);
insert into filme values(default,'Coringa',2019,122,6,1);
insert into filme values(default,'Era uma vez em Hollywood',2020,119,4,2);
insert into filme values(default,'Nasce uma estrela',2018,100,6,1);

insert into artista values(default,'Cameron Diaz',null,'USA','15/07/75');
insert into artista values(default,'Julia Roberts',null,'USA','20/08/67');
insert into artista values(default,'Brad Pitt',null,null,'05/03/70');
insert into artista values(default,'Joaquin Phoenix',null,null,'06/04/72');
insert into artista values(default,'Bradley Cooper',null,'USA','06/06/77');
insert into artista values(default,'Tom Cruise',null,'USA','10/09/64');
insert into artista values(default,'Rodrigo Santoro','Rio de Janeiro','Brasil','12/10/78');

insert into personagem values(1,1,'Natalie',10000);
insert into personagem values(1,2,'Tom',10000);
insert into personagem values(5,3,'John',10000);
insert into personagem values(3,2,'Ana',6000);
insert into personagem values(6,5,'Tom',11000);
insert into personagem values(4,4,'John',12000);

select * from artista;
Select * from filme;
Select * from estudio;
Select * from categoria;
Select * from personagem;

--Questão 7: Insira mais três registros (de sua autoria) em cada tabela.

insert into estudio values(default,'Paramount');
insert into estudio values(default,'Warner');
insert into estudio values(default,'Fox');

insert into artista values (default,'Pedro Pascal','Santiago','Chile','02/03/75');
insert into artista values(default,'Chadwick Aaron','','EUA','29/11/76');
insert into artista values(default,'Steven John','','EUA','16/08/62');

insert into filme values(default,'Mulher Maravilha',2020,130,1,3);
insert into filme values(default,'Pantera Negra',2022,130,1,2);
insert into filme values(default,'Meu Malvado Favorito',2010,120,3,2);

insert into personagem values(8,7,'Maxwell',10000);
insert into personagem values(9,8,'Pantera Negra',10000);
insert into personagem values(10,9,'Gru',10000);

--Questão 8:  Verifique quais são os artistas cadastrados ordenados pelo nome.

select * from artista ORDER BY nomeart;

--Questão 9: Selecione os artistas que têm o nome iniciando com a letra ‘B’.

select * from artista where nomeart like 'B%';

--Questão 10: Verifique os filmes que foram lançados em 2019.

select * from filme where ano = 2019;

-- Questão 11: Atualize o cachê dos artistas em 15%.

update personagem set cache = cache*1.15;

-- Questão 12: Atualize o país de 3 artistas à sua escolha.

update artista set pais = 'EUA' where codart = 3;
update artista set pais = '' where codart = 2;
update artista set pais = 'EUA' where codart = 1;

--Questão 13: Insira 2 artistas brasileiros.

insert into artista values(default,'Fernanda Montenegro',null,'Brasil','16/10/1929');
insert into artista values(default,'Lilia Cabral',null,'Brasil','16/06/1957');

--Questãp 14: Delete 1 artista recentemente incluído que não seja brasileiro.

delete from artista where codart = 2;
