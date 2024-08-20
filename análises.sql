-- Qual é a faixa etária com a maior taxa de assinatura do termo de depósito?
SELECT
CASE
	WHEN age < 20 THEN '20-'
	WHEN age BETWEEN 20 AND 29 THEN '20-29'
	WHEN age BETWEEN 30 AND 39 THEN '30-39'
	WHEN age BETWEEN 40 AND 49 THEN '40-49'
	WHEN age BETWEEN 50 AND 59 THEN '50-59'
	WHEN age BETWEEN 60 AND 69 THEN '60-69'
	WHEN age BETWEEN 70 AND 79 THEN '70-79'
	WHEN age BETWEEN 80 AND 89 THEN '80-89'
ELSE '90+'
END AS 'faixa_etaria',
COUNT(CASE WHEN y = 'yes' THEN 1 END) AS 'assinou_termo',
COUNT(CASE WHEN y = 'no' THEN 1 END) AS 'nao_assinou_termo',
ROUND(COUNT(CASE WHEN y = 'yes' THEN 1 END) / COUNT(y) * 100, 2) AS '%'
FROM bank_marketing
GROUP BY faixa_etaria
ORDER BY assinou_termo DESC;

-- O nível educacional influencia a probabilidade de um cliente assinar o termo de depósito?
SELECT
education,
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS 'subscribed_term',
SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS 'not_subscribed',
ROUND(COUNT(CASE WHEN y = 'yes' THEN 1 END) / COUNT(y) * 100, 2) AS '%'
FROM bank_marketing
GROUP BY education
ORDER BY subscribed_term DESC;

-- Média de idade dos clientes baseado no nível institucional
SELECT
education,
ROUND(AVG(age), 0) AS 'media_idade'
FROM bank_marketing
GROUP BY education;

-- Clientes com dívidas no crédito têm menor probabilidade de assinar o termo de depósito?
SELECT
credit_default,
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS 'assinou_termo',
COUNT(credit_default) AS 'total'
FROM bank_marketing
GROUP BY credit_default
ORDER BY assinou_termo DESC;

-- Qual é o impacto do tipo de emprego na assinatura do termo de depósito?
SELECT
job,
COUNT(y) AS 'subscribed_terms'
FROM bank_marketing
WHERE y = 'yes'
GROUP BY job
ORDER BY subscribed_terms DESC;

-- Clientes com financiamento imobiliário têm menor probabilidade de assinar o termo de depósito?
SELECT
housing,
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS 'subscribed_terms',
COUNT(y) AS 'total'
FROM bank_marketing
GROUP BY housing
ORDER BY subscribed_terms;

-- E empréstimo pessoal?
SELECT
loan,
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS 'assinou_termo',
COUNT(y) AS 'total'
FROM bank_marketing
GROUP BY loan;

-- Quais dias da semana têm as maiores taxas de sucesso nos contatos?
SELECT
day_of_week,
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS 'assinaram',
SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS 'nao_assinaram',
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(y) * 100 AS '%'
FROM bank_marketing
GROUP BY day_of_week
ORDER BY assinaram DESC;

-- Tempo médio do contato entre quem aceita o acordo e para quem não aceita
SELECT
y,
AVG(duration) AS 'media_duraçao',
SUM(duration) AS 'total_falado'
FROM bank_marketing
GROUP BY y;

-- Porcentagem dos clientes que aceitaram o acordo e dos que não aceitaram
SELECT
COUNT(y) AS 'clientes',
SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(y) * 100 AS '% aceitaram',
SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) / COUNT(y) * 100 AS '% não aceitaram'
FROM bank_marketing;

-- Quantidade de quantos aceitaram o acordo e quantos não aceitaram
SELECT
y,
COUNT(y) AS 'contagem'
FROM bank_marketing
GROUP BY y;

-- Intervalo das quantidades que tiveram tentativas de contatos e sua taxa de sucesso
SELECT
CASE
WHEN campaign BETWEEN 0 AND 9 THEN '0-9'
WHEN campaign BETWEEN 10 AND 19 THEN '10-19'
WHEN campaign BETWEEN 20 AND 29 THEN '20-29'
WHEN campaign BETWEEN 30 AND 39 THEN '30-39'
ELSE '+40'
END AS 'intervalo_tentativas',
COUNT(CASE WHEN y = 'yes' THEN 1 END) AS 'qtd_termos_assinados',
COUNT(CASE WHEN y = 'no' THEN 1 END) AS 'qtd_termos_nao_assinados',
COUNT(CASE WHEN y = 'yes' THEN 1 END) / COUNT(y) * 100 AS '%'
FROM bank_marketing
GROUP BY intervalo_tentativas;

