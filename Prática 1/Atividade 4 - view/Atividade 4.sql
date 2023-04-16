--Prática 4

--1.1
select * from empregado
order by matricula;

--1.2: Formule uma consulta que apresente os nomes dos empregados que possuem cargo “Analista de Sistemas Pleno”.

select primeironome 
from empregado
where cargo = 'Analista de Sistemas Pleno';

--1.3: Execute o comando abaixo e o explique.
Select e.primeironome || ' ' || e.sobrenome as "Empregado", d.nome as "Departamento" 
From empregado e 
join departamento d 
on e.coddepto = d.coddepto;
--Resposta:A consulta mostra o primeiro e segundo nome dos funcionários que estão associados a um departamento e o nome do departamento em questão.

--1.4: Mostre a quantidade de empregados por departamento.
select d.nome,count(*)
from empregado e
join departamento d
on e.coddepto = d.coddepto
group by d.nome;

--1.5: Mostre agora apenas os departamentos que possuem quantidade de empregados acima de 3.

select d.nome, count(*)
from departamento d
join empregado e
on e.coddepto = d.coddepto
group by d.nome
having count(*)>3;

/*1.6: Indique o somatório de salários de empregados agrupado por departamento.
A consulta a seguir une o departamento nulo em um dos departamentos, como corrigir isso?
*/

select d.nome, sum(e.salario)
from departamento d
join empregado e
on d.coddepto = e.coddepto
group by d.nome;

--1.7.1: Execute o comando abaixo e o explique.

Select g.primeironome || ' ' || g.sobrenome as "Gerente",e.primeironome || ' ' || e.sobrenome as "Empregado" 
From empregado e 
join empregado g 
on e.gerente = g.matricula 
order by g.Gerente;
--Resposta:A consulta exibe o nome completo do gerente e o nome completo do empregado associado aquele gerente, odenados pelo nome do gerente.

--1.7.2: Em seguida, mostre o nome do gerente com a quantidade de empregados que ele gerencia.

select g.primeironome as Gerente, count(*)
from empregado g
join empregado e
on g.matricula = e.gerente
group by g.primeironome;

--2 ----------------Subconsulta----------------
--2.1: Mostre os nomes dos empregados que possuem departamento associado cujo nome do departamento inicie com “M”.

select e.primeironome as Nome
from empregado e
where coddepto in (select coddepto 
				   from departamento
				   where nome like 'M%');

--2.2: Qual o sobrenome do empregado cujo sobrenome do gerente é ‘Guedes’?

select sobrenome
from empregado
where gerente in (select matricula
				 from empregado
				 where sobrenome = 'Guedes');

--2.3: Existe algum empregado que não tenha departamento? Use uma subconsulta correlacionada para mostrar.

select * from empregado e
where not exists (select * from departamento d
				  where d.coddepto = e.coddepto);

/*3 ----------------Views----------------
3.1: Crie uma visão (view) que mostre os primeiros nomes dos empregados e os nomes de seus departamentos associados. 
Mostre também os nomes dos empregados que não tenham departamento. Consulte a view criada e mostre seus dados. */

create or replace view nomesEmpregDepart(Nome,Departamento)
as select e.primeironome || ' ' ||e.sobrenome, d.nome
from Empregado e
left join Departamento d
on e.coddepto = d.coddepto
order by  e.primeironome;

select * from nomesEmpregDepart;

--3.2: Em seguida, tente inserir um empregado através da view recém criada. Explique o que aconteceu.

Insert into nomesEmpregDepart values('Amanda Cruz','Programador');

--Resposta:Não é possível inserir valores por esta view pois ela é formada por informações de mais de uma tabela

/*3.3: Faça a inserção através da tabela base empregado. Depois consulte a view. O empregado foi inserido? 
Consulte também a tabela base. */

Insert into empregado values(default,'Amanda','Cruz','2023-04-02','Programador',7500,1,1);

select * from empregado;
select * from nomesEmpregDepart;

/*Resposta: Sim, os valores foram inseridos em ambas as tabelas. No momento do select a view realiza novamente a 
consulta que foi armazenada em sua criação, obtendo assim os dados atualizados.

4: Monte uma view que permita inserção na tabela departamento. Consulte a view criada. 
Em seguida, teste e mostre inserções por meio da view.
*/

create or replace view insDep as
select coddepto, nome,local
from departamento;

select * from insDep;

insert into insDep values(default,'Jurídico','Sede');
insert into insDep values(default,'Adm','Sede');

/*5:Crie uma view com check option que mostre os empregados cujo primeironome inicia com ‘M’. 
Mostre o primeironome, matrícula e data de admissão na view. Consulte a view. 
Em seguida, teste fazendo inserções com vários primeiros nomes por meio da view e verifique se elas ocorrem.
*/

create or replace view empregM as
select primeironome, matricula, dataadmissao
from empregado
where primeironome like 'M%'
with check option;

select * from empregM;

insert into empregM values('Danilo',default,'2000-06-12');
insert into empregM values('Marcela',default,'2021-02-22');

select * from empregado;

/*Ocorreram apenas as inserções que respeitaram a condição determinada na view(nomes que começam com a letra M), 
devido a presença do chek option. */

--6: Explique as seguintes consultas:
select e.matricula
from empregado e
EXCEPT
select e.gerente
from empregado e;

/*A primeira parte da consulta informa a matrícula de todos os empregados. A segunda parte se refere a matrícula de 
todos os gerentes. Com o except, o resultado final são as matrículas dos empregados, excluindo os gerentes. */

select e.matricula
from empregado e
INTERSECT
select e.gerente
from empregado e;

/*O intersect coleta os dados em comum entre consultas(interseção). Nesse caso, tendo em vista a primeira parte 
da consulta(matrícula de todos os empregados) e a segunda(matrícula apenas dos gerntes), o resultado final são as 
matrículas apenas dos gerentes. */

7--Explique a seguinte consulta a seguir:

select e.coddepto
from empregado e
where e.dataadmissao>'20-01-2021'
INTERSECT
select d.coddepto
from departamento d;

/*A primeira parte da consulta informa o código do departamento dos funcionários cuja data de admissão é maior
que 20-01-2021. O segundo retorna todos os código de departamento. A consulta como um todo retorna a interseção
disso, que seram os códigos dos departamentos que possuem empregados com data de admissão maior
que 20-01-2021.
*/

-- Refaça a consulta acima usando uma subquery.
select distinct coddepto
from empregado
where dataadmissao >'20-01-2021'
and coddepto in (select coddepto
				from departamento);
				
--Refaça usando JOIN.

select distinct e.coddepto
from empregado e
join departamento d
on e.coddepto = d.coddepto
where e.dataadmissao>'20-01-2021';

--8 Explique a consulta a seguir:
WITH
Custo_depto as (Select d.nome, sum(e.salario) as total_depto
				From empregado e 
				JOIN departamento d
				on e.coddepto = d.coddepto
				Group by d.nome),
				Custo_medio as (Select sum(total_depto)/Count(*) as media_dep
								From Custo_depto)
								Select * From Custo_depto
								Where total_depto > (Select media_dep
													 From Custo_medio)
													 Order by nome;
													 
/* armazean em custo_depto: o primeiro select retorna o nome do departamento e a soma dos salários dos empregados desse departamento(total_depto), agrupados por nome
armazena em custo_medio: o segundo select pega os dados da tabela criada no select anterior(custo_depto). Retorna a média salarial de todos os departamentos(media_dep)
WHERE: o total por departamento deve ser maior que a média dos departamentos(media consultada no ultimo select)
Assim, o resultado da consulta são os deparamentos cuja média salarial é acima da média de todos os departamentos, agrupado pelo nome.

*/






