

--Atividade 3 - Subqueries

--Questão 1
select f.titulo
from filme f
where f.codest in (select e.codest
               	from estudio e
               	where e.nomeest like 'P%')
order by f.titulo;

--A subconsulta retorna os códigos dos estúdios cujo nome começa com a letra P. Observe que ela pode ser executada individualmente.
--A consulta retorna os títulos dos filmes que foram produzidos por estúdios que começam com a letra P, ordenados em ordem alfabética pelo título. 


--Questão 2
select f.titulo
from filme f
where exists
 	(select e.codest
 	 from estudio e
  	where f.codest = e.codest and nomeest like 'P%')
order by f.titulo;   

--A subconsulta retorna o código de estudios(proveniente da tabela estudio) cujo nome começa com a letra P e já produziram algum filme.
--A consulta retorna o título de filmes produzidos pelo estudio cujo código foi retornado na subconsulta.

--Essa subconsulta não pode ser executada individualmente, visto que ela precisa da informação que não estão incluídas nela(qual tabela será f? a tabela filme, informada na consulta "principal").

--A subconsulta reescrita, para ser executada individualmente:
select estudio.codest, filme.codest
 	from estudio, filme
  	where filme.codest = estudio.codest and nomeest like 'P%';

--A consulta pode ser realizada de outras maneiras, como a exemplificada a seguir, que não envolve subconsultas:
select titulo
from filme
join estudio
on estudio.codest = filme.codest
where estudio.codest = 1
order by filme.titulo;

--Questão 3: Crie uma consulta que mostre as descrições de categorias que estão na tabela Filme (ou seja, associadas a filmes).

select c.desccateg
from categoria c
where c.codcateg in (select f.codcateg
		  from filme f);
		  
		
--Questão 4: Qual o nome do artista cujo nome de personagem é ‘Natalie’?  

select a.nomeart
from artista a
where codart in (select p.codart
			 from personagem p
			 where nomepers = 'Natalie');
 
--Questão 5: Existe algum artista cadastrado que não esteja na tabela Personagem? Crie uma consulta que apresente isso. 
--Sim.

select a.nomeart
from artista a
where a.codart not in (select p.codart
					  from personagem p);
	
--Questão 6: Crie uma consulta que mostre os nomes dos artistas que possuem cachê acima da média. 
--(** Nesta questão, use subconsulta para obter o valor do cachê e use JOIN para associar artista e personagem.)

select a.nomeart
from artista a
join personagem p
on a.codart = p.codart
where p.cache > (select avg(cache)
		from personagem);

