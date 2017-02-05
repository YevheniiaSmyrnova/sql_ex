# ex 14
SELECT maker, type
FROM Product
WHERE maker IN (SELECT maker
	FROM (SELECT DISTINCT maker, type
		FROM Product
		) a
	GROUP BY maker
	HAVING COUNT(type)=1 
	)
GROUP BY maker, type
HAVING COUNT(model)>1

# ex 16
SELECT DISTINCT PC.model AS model_1, a.model AS model_2, PC.speed, PC.ram
FROM PC, (SELECT model, speed, ram 
	FROM PC) a
WHERE PC.speed=a.speed AND PC.ram=a.ram AND PC.model > a.model

# ex 18
SELECT DISTINCT maker, price
FROM Product 
RIGHT JOIN Printer ON Printer.model=Product.model
WHERE color='y' AND price = (SELECT MIN(price) 
	FROM Printer 
	WHERE color='y')

# ex 19
SELECT maker, AVG(screen)
FROM Product 
RIGHT JOIN Laptop ON Product.model=Laptop.model
GROUP BY maker

# ex 23
SELECT maker
FROM Product 
RIGHT JOIN PC ON Product.model=PC.model
WHERE speed>=750
INTERSECT
SELECT maker
FROM Product 
RIGHT JOIN Laptop ON Product.model=Laptop.model
WHERE speed>=750

# ex 24
WITH Price AS (
	SELECT model, price 
	FROM PC 
	UNION ALL 
	SELECT model, price 
	FROM Laptop 
	UNION ALL 
	SELECT model, price 
	FROM Printer) 
SELECT DISTINCT model 
FROM Price 
WHERE price = (SELECT MAX(price) 
	FROM Price)

# ex 25
SELECT DISTINCT maker
FROM Product 
WHERE type = 'printer' AND maker IN (SELECT maker 
	FROM Product 
	WHERE model IN (SELECT model 
		FROM PC
		WHERE ram = (SELECT MIN(ram) 
			FROM PC) AND speed = (SELECT MAX(speed)
			FROM (SELECT speed 
				FROM PC 
				WHERE ram = (SELECT MIN(ram) 
					FROM PC
					)
				)AS a
			)
		)
	)

# ex 26
SELECT AVG(x.price)
FROM (SELECT price
	FROM Product 
	RIGHT JOIN PC ON Product.model=PC.model
	WHERE maker = 'A'
	UNION ALL
	SELECT price
	FROM Product 
	RIGHT JOIN Laptop ON Product.model=Laptop.model
	WHERE maker = 'A'
	) AS x

# ex 27
SELECT maker, AVG(hd)
FROM Product 
RIGHT JOIN PC ON Product.model=PC.model
WHERE maker IN (SELECT maker FROM Product WHERE type='Printer')
GROUP BY maker

# ex 28
# =(((

# ex 29
SELECT Income_o.point, Income_o.date, inc, out
FROM Income_o 
LEFT JOIN Outcome_o ON Income_o.point=Outcome_o.point AND Income_o.date=Outcome_o.date
UNION
SELECT Outcome_o.point, Outcome_o.date, inc, out
FROM Income_o 
RIGHT JOIN Outcome_o ON Income_o.point=Outcome_o.point AND Income_o.date=Outcome_o.date

# ex 30
SELECT point, date, SUM(out), SUM(inc)
FROM (SELECT I.point, I.date, out, inc 
	FROM (SELECT point, date, SUM(inc) AS inc 
		FROM Income 
		GROUP BY point, date) AS I 
	LEFT JOIN (SELECT point, date, SUM(out) AS out 
		FROM Outcome 
		GROUP BY point, date) AS O 
	ON I.point = O.point AND I.date = O.date
	UNION
	SELECT O.point, O.date, out, inc
	FROM (SELECT point, date, SUM(inc) AS inc 
		FROM Income 
		GROUP BY point, date) AS I 
	RIGHT JOIN (SELECT point, date, SUM(out) AS out 
		FROM Outcome 
		GROUP BY point, date) AS O 
	ON I.point = O.point AND I.date = O.date) x
GROUP BY point, date

# ex 31
SELECT class, country
FROM Classes
WHERE bore>=16
