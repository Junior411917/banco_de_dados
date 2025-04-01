CREATE TABLE autores(
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE livro(
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    id_autor INT NOT NULL,
    ano_publicacao INT NOT NULL,
    genero VARCHAR(100) NOT NULL,
    quantidade_estoque INT NOT NULL,
    editora VARCHAR(100),
    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);


INSERT INTO autores (nome) VALUES
('Leonardo Kanti'),
('Marcos Suzi'),
('Matheus Marques'),
('Aline Santos'),
('Marcela Bouch'),
('Ana Bla'),
('Alice Pouch'),
('Maurício Gomez'),
('Zhiu Wang'),
('Chavelli Blarg');


INSERT INTO livro (titulo, id_autor, ano_publicacao, genero, quantidade_estoque, editora) VALUES
('AS Caixas', 1, 2025, 'Comédia', 4, 'Editora AL'),
('AD Block Louco', 2, 2022, 'Comédia', 3, 'Editora BL'),
('Olho de gude', 3, 2020, 'Terror', 7, 'Editora CL'),
('O carro', 4, 1995, 'Romance', 2, 'Editora DL'),
('A TV de Marte', 5, 2020, 'Ficção Científica', 20, 'Editora EL'),
('A Lua que ri', 6, 2021, 'Romance', 5, 'Editora FL'),
('O Piano vermelho', 7, 2024, 'Terror', 17, 'Editora GL'),
('O Gato que ri', 8, 1991, 'Terror', 21, 'Editora HL'),
('Game Science', 9, 2024, 'Suspense', 6, 'Editora IL'),
('A Caixa que não fecha', 10, 2025, 'Terror', 1, 'Editora JL');

CREATE TABLE usuarios(
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE emprestimos(
    id_emprestimo SERIAL PRIMARY KEY,
    id_livro INT,
    id_usuario INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    status VARCHAR(50),
    FOREIGN KEY (id_livro) REFERENCES livro (id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);
--Comando para a contagem dos livros cadastrados na biblioteca:
SELECT COUNT(*) AS total_livros FROM livro;

--Comando para descobrir a média de tempo de empréstimo dos livros:
SELECT AVG(data_devolucao - data_emprestimo) AS media_tempo_emprestimo FROM emprestimos; 

--Comando para encontar o livro mais antigo e o mais recente:
SELECT MIN(ano_publicacao) AS livro_mais_antigo, MAX(ano_publicacao) 
AS livro_mais_recente FROM livro;

--Comando para listar quantos empréstimos foram feitos por cada usuário:
SELECT u.nome AS nome_usuario, COUNT(e.id_emprestimo) 
AS quantidade_emprestimos FROM usuarios u 
LEFT JOIN emprestimos e ON u.id_usuario = e.id_usuario GROUP BY u.nome;

--Comando para mostrar quantos livros existem por gênero:
SELECT genero, COUNT(*) AS quantidade_livros FROM livro GROUP BY genero;