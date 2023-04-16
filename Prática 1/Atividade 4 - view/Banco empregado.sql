--Criando bando empregado para Atividade 4

create table departamento (
   CodDepto                      serial not null, 
   Nome                          varchar(20),
   Local                         varchar(20));

alter table departamento add constraint pkdepto primary key(coddepto);

create table empregado (
       Matricula               serial not null,
       PrimeiroNome            varchar(15),
       Sobrenome   	           varchar(15),
       Dataadmissao            date,
       Cargo                   varchar(30),
       Salario                 numeric(13,2),
       gerente		             integer,
       CodDepto                integer);

alter table empregado add constraint pkEmp primary key(matricula);

Alter table empregado add constraint fkgerente foreign key(gerente) references Empregado;
Alter table Empregado add constraint fkdepto foreign key(coddepto) references Departamento;

insert into departamento values (default,'Informática','Sede');
insert into departamento values (default,'Pessoal','Sede');

insert into Empregado values (default,'Jõao', 'Guedes',current_date,'Analista de Sistemas Junior',3400.00,null,1);
insert into Empregado values (default,'José', 'Batista',current_date,'Analista de Sistemas Pleno',4200.00,1,1);
insert into Empregado values (default,'Ana Maria', 'Silva',current_date,'Analista de Sistemas Junior',3400.00,1,1);
insert into Empregado values (default,'Ricardo', 'Neves',current_date,'Analista de Sistemas Pleno',4200.00,2,1);
insert into Empregado values (default,'Valter', 'Moura',current_date,'Analista de Suporte Junior',3400.00,2,1);
insert into Empregado values (default,'Mariana','Oliveira',current_date,'Designer de Interface',4800.00,1,null);

