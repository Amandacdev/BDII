
--Tarefa 2

--Questão 1: Faça um select geral nas cinco tabelas e observe seus relacionamentos.

select * from artista;
select * from filme;
select * from estudio;
select * from personagem;
select * from categoria;

--Questão 2: 

insert into filme values(default,'Elvis',2022,120,null,3);
select * from filme;

--Questão 3: Verifique quais os títulos dos filmes que possuem duração maior que 120 min?

select titulo from filme where duracao >= 120;

--Questao 4: Na tabela ARTISTA, quais artistas possuem cidade nula? Após a consulta, atualize as cidades nulas encontradas para três artistas.
select nomeart from artista where cidade is null;
update artista set cidade = 'Syracuse' where nomeart = 'Tom Cruise';
update artista set cidade = 'Smyrna' where nomeart = 'Julia Roberts';
update artista set cidade = 'Rio de Janeiro' where nomeart = 'Fernanda Montenegro';

--Questao 5: Qual a descrição da categoria do filme ‘Coringa’?

Select desccateg 
from categoria
join filme
on categoria.codcateg = filme.codcateg
where filme.titulo = 'Coringa';

--Alternativa:
SELECT c.desccateg
FROM filme F join categoria C
ON F.codcateg = c.codcateg
where F.titulo = 'Coringa';

--6: Mostre os títulos de filmes, com seus nomes de estúdios e nomes de suas categorias.

select titulo, nomeest, desccateg
from filme
join estudio
on filme.codest = estudio.codest
join categoria
on filme.codcateg = categoria.codcateg;

--Questao 7: Qual o nome dos artistas que fizeram o filme ‘Encontro Explosivo’?

select nomeart
from artista
join personagem
on artista.codart = personagem.codart
join filme
on filme.codfilme = personagem.codfilme 
where titulo = 'Encontro Explosivo';

--Questão 8: Selecione os artistas que têm o nome iniciando com a letra ‘B’ e participaram de filmes da categoria ‘Aventura’.

select nomeart
from artista
join personagem
on artista.codart = personagem.codart
join filme
on personagem.codfilme = filme.codfilme
join categoria
on filme.codcateg = categoria.codcateg
where categoria.desccateg = 'Aventura' and nomeart like 'B%';

--Questão 9: Apresente quantos filmes existem por categoria. Para isso mostre a descrição da categoria e sua respectiva contagem. Use group by.

select categoria, count(*)
from filme
join categoria
on filme.codcateg = categoria.codcateg
group by categoria;

--Questão 10:Left join mostra todas as informações solicitadas da tabela da esquerda(todos os nomeart) e as informações em intersecção.

select a.nomeart, p.nomepers
from artista a left outer join personagem p on a.codart = p.codart;

--Questão 11: Mostra os titulos(da tabela filme) e a descrição da categoria(da tabela categoria) para os casos em que a categoria é nula.
Select f.titulo as Filme, c.desccateg as Categoria
From filme f right join categoria c on f.codcateg = c.codcateg
Where c.codcateg is null; 




