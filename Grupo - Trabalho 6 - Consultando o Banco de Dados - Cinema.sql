--Trabalho Grupo 5

--Sobre os clientes e atendentes

--1 - Quais os nomes dos clientes cadastrados?

SELECT nome FROM cliente;

--2 - Liste o nome e o email de todos os atendentes, ordenados por nome.

SELECT nome, email FROM ATENDENTE ORDER BY nome;

--Sobre os filmes

--3 - Liste os filmes de classificação "Livre"

SELECT titulo FROM FILME WHERE classificacao = 'Livre';

--Sobre as sessões

--4 - Liste as sessões, com o nome do filme e o número da sala

SELECT SESSAO.idSessao, filme.titulo, sala.numeroSala
FROM SESSAO
JOIN FILME ON sessao.idFilme=filme.idFilme
JOIN sala ON sala.idSala=sessao.idSala;

--5 - Liste as sessões do dia 01/02/2025 com seus respectivos filmes

SELECT SESSAO.idSessao, filme.titulo
FROM SESSAO
JOIN FILME ON sessao.idFilme=filme.idFilme
WHERE data = '2025-02-01';

--Sobre os ingressos

--6 - Liste todos os ingressos do tipo "inteira" com valor acima de R$10

SELECT INGRESSO.idIngresso FROM INGRESSO
WHERE INGRESSO.TIPO = 'Inteira' AND INGRESSO.valor > 10.00

--7 - Liste os ingressos com nome do filme, tipo e valor e hora da venda. Ordenados por ordem cronológica.  

SELECT I.idIngresso, FILME.titulo, I.TIPO, I.valor, PEDIDO.dataHora
FROM INGRESSO I
JOIN PEDIDO ON I.idPedido=PEDIDO.idPedido
JOIN SESSAO ON I.idSessao=SESSAO.idSessao
JOIN FILME ON SESSAO.idFilme=FILME.idFilme
ORDER BY PEDIDO.dataHora ASC;

--Analisando as vendas

--8 - Quantos ingressos foram vendidos por tipo (meia x inteira)

SELECT tipo, COUNT (*) AS Vendidos
FROM INGRESSO
GROUP BY tipo;

--9 - Mostre a quantidade de ingressos vendidos por filme

SELECT FILME.titulo, COUNT (INGRESSO.idIngresso) AS Ingressos_Vendidos
FROM INGRESSO
JOIN SESSAO ON INGRESSO.idSessao=SESSAO.idSessao
JOIN FILME ON SESSAO.idFilme=FILME.idFilme
GROUP BY FILME.titulo;

--10 - Calcule o valor total arrecadado por dia

SELECT DATE(dataHora) AS dia, SUM(valorTotal) AS total_faturado
FROM PEDIDO
GROUP BY dia
ORDER BY dia DESC;

--11 - Quanto cada atendente vendeu considerando todos os meses?

SELECT ATENDENTE.nome, SUM(PEDIDO.valorTotal) AS total_faturado
FROM PEDIDO
JOIN ATENDENTE ON ATENDENTE.idatendente=PEDIDO.idatendente
GROUP BY ATENDENTE.nome;

--Apoiando a gestão

--12 - Qual o percentual de ocupação de cada sala?

SELECT SALA.numeroSala, ROUND((COUNT(INGRESSO.idAssento)*100.0/COUNT(ASSENTO.idAssento)), 1) AS percentual_ocupacao
FROM SALA
JOIN ASSENTO ON SALA.idSala=ASSENTO.idSala
LEFT JOIN INGRESSO ON ASSENTO.idAssento=INGRESSO.idAssento
GROUP BY SALA.numeroSala;

--13 - Quais o ranking de filme, considerando a quantidade de pessoas que assistiram?

SELECT FILME.titulo, COUNT(INGRESSO.idIngresso) AS tot_pessoas
FROM INGRESSO
JOIN SESSAO ON INGRESSO.idSessao=SESSAO.idSessao
JOIN FILME ON SESSAO.idFilme=FILME.idFilme
GROUP BY FILME.titulo
ORDER BY tot_pessoas DESC;

--14 - Quais sessões tiveram desempenho ruim (menos de 50% de ocupação)?

SELECT SESSAO.idSessao, SALA.numeroSala,
       ROUND((COUNT(INGRESSO.idAssento)*100.0/COUNT(ASSENTO.idAssento)), 2) AS percentual_ocupacao
FROM SESSAO
JOIN SALA ON SESSAO.idSala=SALA.idSala
JOIN ASSENTO ON SALA.idSala=ASSENTO.idSala
LEFT JOIN INGRESSO ON ASSENTO.idAssento=INGRESSO.idAssento AND INGRESSO.idSessao=SESSAO.idSessao
GROUP BY SESSAO.idSessao, SALA.numeroSala
HAVING ROUND((COUNT(INGRESSO.idAssento)*100.0/COUNT(ASSENTO.idAssento)), 2)<50
ORDER BY percentual_ocupacao ASC;

--15 - Quais clientes retornaram ao cinema (Compraram mais de 1 vez)?

SELECT CLIENTE.nome, COUNT(PEDIDO.idPedido) AS total_compras
FROM PEDIDO
JOIN CLIENTE ON PEDIDO.idCliente=CLIENTE.idCliente
GROUP BY CLIENTE.nome
HAVING COUNT(PEDIDO.idPedido)>1;

--16 - Qual cliente mais gastou?

SELECT CLIENTE.nome, SUM(PEDIDO.valorTotal) AS total_gasto
FROM PEDIDO
JOIN CLIENTE ON PEDIDO.idCliente=CLIENTE.idCliente
GROUP BY CLIENTE.nome
ORDER BY total_gasto DESC
LIMIT 1;

--17 - Qual foi o dia mais lucrativo? (Atente-se ao conceito de lucratividade)?

SELECT DATE(PEDIDO.dataHora) AS data, SUM(PEDIDO.valorTotal) AS receita_total
FROM PEDIDO
GROUP BY data
ORDER BY receita_total DESC
LIMIT 1;

--18 - Qual sala teve maior média de ocupação (em %)?

WITH ocupacao_sala AS (
    SELECT SALA.numeroSala AS sala, SESSAO.idSessao AS sessao,
    	   COUNT(INGRESSO.idAssento)*100.0/COUNT(ASSENTO.idAssento) AS ocupacao_percentual
    FROM SALA
    JOIN ASSENTO ON SALA.idSala=ASSENTO.idSala
    LEFT JOIN INGRESSO ON ASSENTO.idAssento=INGRESSO.idAssento
    JOIN SESSAO ON SALA.idSala=SESSAO.idSala
    GROUP BY SALA.numeroSala, SESSAO.idSessao
	)
SELECT sala, ROUND(AVG(ocupacao_percentual), 1) AS media_ocupacao
FROM ocupacao_sala
GROUP BY sala
ORDER BY media_ocupacao DESC
LIMIT 1;