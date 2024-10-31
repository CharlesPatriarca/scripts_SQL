-- Relatório 1 ----------------------------------------------------------------------------

SELECT 
    Empregado.nome AS Nome_Empregado,
    Empregado.cpf AS CPF_Empregado,
    Empregado.dataAdm AS Data_Admissao,
    Empregado.salario AS Salario,
    Departamento.nome AS Departamento,
    Telefone.num AS Numero_Telefone
    
FROM Empregado

JOIN Departamento ON Empregado.Departamento_idDepartam = Departamento.idDepartamento
JOIN Telefone ON Empregado.cpf = Telefone.Empregado_cpf
WHERE Empregado.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY Empregado.dataAdm DESC;


-- Relatório 2 ----------------------------------------------------------------------------

SELECT 
    Empregado.nome AS Nome_Empregado,
    Empregado.cpf AS CPF_Empregado,
    Empregado.dataAdm AS Data_Admissao,
    Empregado.salario AS Salario,
    Departamento.nome AS Departamento,
    Telefone.num AS Numero_Telefone
    
FROM Empregado

JOIN Departamento ON Empregado.Departamento_idDepartam = Departamento.idDepartamento
JOIN Telefone ON Empregado.cpf = Telefone.Empregado_cpf
WHERE Empregado.salario < (SELECT AVG(salario) FROM Empregado)
ORDER BY Empregado.nome;


-- Relatório 3 ----------------------------------------------------------------------------

SELECT 
    Departamento.nome AS Departamento,
    COUNT(Empregado.cpf) AS Quantidade_Empregados,
    AVG(Empregado.salario) AS Media_Salarial,
    AVG(Empregado.comissao) AS Media_Comissao
    
FROM Departamento

LEFT JOIN Empregado ON Departamento.idDepartamento = Empregado.Departamento_idDepartam
GROUP BY Departamento.nome
ORDER BY Departamento.nome;


-- Relatório 4 ----------------------------------------------------------------------------

SELECT 
    Empregado.nome AS Nome_Empregado,
    Empregado.cpf AS CPF_Empregado,
    Empregado.sexo AS Sexo,
    Empregado.salario AS Salario,
    COUNT(Venda.idVenda) AS Quantidade_Vendas,
    SUM(Venda.valor) AS Total_Valor_Vendido,
    SUM(Venda.comissao) AS Total_Comissao
    
FROM Empregado

LEFT JOIN Venda ON Empregado.cpf = Venda.Empregado_cpf
GROUP BY Empregado.cpf
ORDER BY Quantidade_Vendas DESC;


-- Relatório 5 ----------------------------------------------------------------------------

SELECT 
    Empregado.nome AS Nome_Empregado,
    Empregado.cpf AS CPF_Empregado,
    Empregado.sexo AS Sexo,
    Empregado.salario AS Salario,
    COUNT(DISTINCT Venda.idVenda) AS Quantidade_Vendas_com_Servico,
    SUM(Servico.valorVenda) AS Total_Valor_Vendido_com_Servico,
    SUM(Venda.comissao) AS Total_Comissao_com_Servico
    
FROM Empregado

JOIN Venda ON Empregado.cpf = Venda.Empregado_cpf
JOIN itensServico ON Venda.idVenda = itensServico.Venda_idVenda
JOIN Servico ON itensServico.Servico_idServico = Servico.idServico
GROUP BY Empregado.cpf
ORDER BY Quantidade_Vendas_com_Servico DESC;


-- Relatório 6 ----------------------------------------------------------------------------

SELECT 
    Pet.nome AS Nome_Pet,
    Venda.data AS Data_Servico,
    Servico.nome AS Nome_Servico,
    itensServico.quantidade AS Quantidade,
    Servico.valorVenda AS Valor,
    Empregado.nome AS Empregado_que_Realizou

FROM Pet

JOIN Venda ON Pet.idPet = Venda.Pet_idPet
JOIN itensServico ON Venda.idVenda = itensServico.Venda_idVenda
JOIN Servico ON itensServico.Servico_idServico = Servico.idServico
JOIN Empregado ON Venda.Empregado_cpf = Empregado.cpf
ORDER BY Venda.data DESC;


-- Relatório 7 ----------------------------------------------------------------------------

SELECT 
    Venda.data AS Data_Venda,
    Venda.valor AS Valor,
    Venda.desconto AS Desconto,
    (Venda.valor - Venda.desconto) AS Valor_Final,
    Empregado.nome AS Empregado_que_Realizou

FROM Venda

JOIN Cliente ON Venda.Cliente_cpf = Cliente.cpf
JOIN Empregado ON Venda.Empregado_cpf = Empregado.cpf
ORDER BY Venda.data DESC;


-- Relatório 8 ----------------------------------------------------------------------------

SELECT 
    Servico.nome AS Nome_Servico,
    COUNT(itensServico.Venda_idVenda) AS Quantidade_Vendas,
    SUM(Servico.valorVenda * itensServico.quantidade) AS Total_Valor_Vendido

FROM Servico

JOIN itensServico ON Servico.idServico = itensServico.Servico_idServico
GROUP BY Servico.idServico
ORDER BY Quantidade_Vendas DESC
LIMIT 10;


-- Relatório 9 ----------------------------------------------------------------------------

SELECT 
    FormaPgVenda.tipo AS Tipo_Forma_Pagamento,
    COUNT(Venda.idVenda) AS Quantidade_Vendas,
    SUM(Venda.valor) AS Total_Valor_Vendido

FROM FormaPgVenda

JOIN Venda ON FormaPgVenda.Venda_idVenda = Venda.idVenda
GROUP BY FormaPgVenda.tipo
ORDER BY Quantidade_Vendas DESC;


-- Relatório 10 ----------------------------------------------------------------------------

SELECT 
    Venda.data AS Data_Venda,
    COUNT(Venda.idVenda) AS Quantidade_Vendas,
    SUM(Venda.valor) AS Valor_Total_Venda

FROM Venda

GROUP BY Venda.data
ORDER BY Venda.data DESC;


-- Relatório 11 ----------------------------------------------------------------------------

SELECT 
    Produtos.nome AS Nome_Produto,
    Produtos.valorVenda AS Valor_Produto,
    Produtos.marca AS Categoria_do_Produto,
    Fornecedor.nome AS Nome_Fornecedor,
    Fornecedor.email AS Email_Fornecedor,
    Telefone.num AS Telefone_Fornecedor

FROM Produtos

JOIN Fornecedor ON Produtos.Fornecedor_cpf_cnpj = Fornecedor.cpf_cnpj
JOIN Telefone ON Fornecedor.cpf_cnpj = Telefone.Fornecedor_cpf_cnpj
ORDER BY Produtos.nome;


-- Relatório 12 ----------------------------------------------------------------------------

SELECT 
    Produtos.nome AS Nome_Produto,
    COUNT(itensVendaProd.Venda_idVenda) AS Quantidade_Total_Vendas,
    SUM(itensVendaProd.valor * itensVendaProd.quantidade) AS Valor_Total_Recebido

FROM Produtos

JOIN itensVendaProd ON Produtos.idProduto = itensVendaProd.Produto_idProduto
GROUP BY Produtos.idProduto
ORDER BY Quantidade_Total_Vendas DESC;
