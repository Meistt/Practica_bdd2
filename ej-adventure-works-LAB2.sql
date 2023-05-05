-- 1 Listar los nombres de los productos y el nombre del modelo que posee asignado. Solo listar aquellos que tengan asignado algún modelo.
SELECT P.NAME AS NOMBRE_PRODUCTO, M.NAME AS NOMBRE_MODELO
FROM Production.Product P JOIN Production.ProductModel M ON P.ProductModelID = M.ProductModelID
WHERE P.ProductModelID IS NOT NULL;

-- 2 Mostrar “todos” los productos junto con el modelo que tenga asignado. En el caso que no tenga asignado ningún modelo, mostrar su nulidad
SELECT P.NAME AS NOMBRE_PRODUCTO, M.NAME AS NOMBRE_MODELO
FROM Production.Product P LEFT JOIN Production.ProductModel M ON P.ProductModelID = M.ProductModelID;

-- 3 Ídem Ejercicio2, pero en lugar de mostrar nulidad, mostrar la palabra “Sin Modelo” para indicar que el producto no posee un modelo asignado.
SELECT P.NAME AS NOMBRE_PRODUCTO,
CASE 
	WHEN M.NAME IS NULL THEN 'SIN MODELO'
	ELSE M.NAME
END AS MODELO
FROM Production.Product P LEFT JOIN Production.ProductModel M ON P.ProductModelID = M.ProductModelID;


-- 4 Contar la cantidad de Productos que poseen asignado cada uno de los modelos.
SELECT P.ProductModelID,COUNT(P.ProductID) AS CANTIDAD_PRODUCTO
FROM Production.Product P JOIN Production.ProductModel PM ON P.ProductModelID = PM.ProductModelID
GROUP BY(P.ProductModelID);
/*PARA VERIFICAR CANTIDAD UNO A UNO*/
SELECT* FROM Production.Product P
WHERE P.ProductModelID = 20;

-- 5 Contar la cantidad de Productos que poseen asignado cada uno de los modelos, pero mostrar solo aquellos modelos que posean asignados 2 o más productos.
SELECT P.ProductModelID,COUNT(P.ProductID) AS CANTIDAD_PRODUCTO
FROM Production.Product P JOIN Production.ProductModel PM ON P.ProductModelID = PM.ProductModelID
GROUP BY(P.ProductModelID)
HAVING COUNT(P.ProductID) > 2
ORDER BY CANTIDAD_PRODUCTO ASC;

-- 6 Contar la cantidad de Productos que poseen asignado un modelo valido, es decir, que se encuentre cargado en la tabla de modelos. Realizar este ejercicio de 3 formas posibles: “exists” / “in” / “inner join”. //DUDA
/* EXISTS */
SELECT P.ProductModelID,COUNT(P.ProductID) AS CANTIDAD_PRODUCTO
FROM Production.Product P
WHERE EXISTS (SELECT M.PRODUCTMODELID FROM Production.ProductModel M WHERE P.ProductModelID = M.ProductModelID)
GROUP BY(P.ProductModelID);
/* IN */
SELECT P.ProductModelID,COUNT(P.ProductID) AS CANTIDAD_PRODUCTO
FROM Production.Product P
WHERE P.ProductModelID IN(SELECT M.ProductModelID FROM Production.ProductModel M)
GROUP BY(P.ProductModelID);
/* JOIN */
SELECT P.ProductModelID,COUNT(P.ProductID) AS CANTIDAD_PRODUCTO
FROM Production.Product P JOIN Production.ProductModel M ON P.ProductModelID = M.ProductModelID
GROUP BY(P.ProductModelID);

-- 7 Contar cuantos productos poseen asignado cada uno de los modelos, es decir, se quiere visualizar el nombre del modelo y la cantidad de productos asignados. Si algún modelo no posee asignado ningún producto, se quiere visualizar 0 (cero).
SELECT* FROM Production.Product;
SELECT* FROM Production.ProductModel;

SELECT M.Name AS NOMBRE_MODELO, COUNT(*) AS CANTIDAD_PRODUCTO,
CASE 
	WHEN COUNT(P.ProductID) >=1 THEN COUNT(P.ProductID)
	ELSE '0'
END AS CANTIDAD
FROM Production.Product P LEFT JOIN Production.ProductModel M ON P.ProductModelID = M.ProductModelID
GROUP BY(M.Name);


SELECT* FROM Production.Product P
WHERE P.ProductModelID = 6;

/* 8 - Se quiere visualizar, el nombre del producto, el nombre modelo que posee asignado, la ilustración que posee asignada y la fecha de última modificación de dicha ilustración y el diagrama que tiene asignado la ilustración. 
solo nos interesan los productos que cuesten más de $150 y que posean algún color asignado*/
SELECT* FROM Production.Product;
SELECT* FROM Production.ProductModel;

SELECT P.ProductID AS ID, P.Name AS NOMBRE_PRODUCTO, PM.Name AS NOMBRE_MODELO,P.ModifiedDate AS FECHA_MODIFICACION
FROM Production.Product P JOIN Production.ProductModel PM ON P.ProductModelID = PM.ProductModelID
WHERE (P.ListPrice > 150 AND P.Color IS NOT NULL) ;

-- 9. Mostrar aquellas culturas que no están asignadas a ningún producto/modelo. (Production.ProductModelProductDescriptionCulture)
SELECT* FROM Production.Product;
SELECT* FROM Production.ProductModel;
SELECT* FROM Production.ProductModelProductDescriptionCulture;

SELECT* 
FROM Production.ProductModelProductDescriptionCulture PC 
LEFT JOIN Production.ProductModel PM ON PC.ProductModelID = PM.ProductModelID 
LEFT JOIN Production.Product P ON PC.ProductModelID = P.ProductModelID
WHERE P.ProductID IS NULL;


SELECT *
FROM Production.ProductModelProductDescriptionCulture PC
LEFT JOIN Production.ProductModel PM ON PC.ProductModelID = PM.ProductModelID
WHERE NOT EXISTS (
    SELECT *
    FROM Production.Product P
    WHERE PC.ProductModelID = P.ProductModelID
);

-- 10. Agregar a la base de datos el tipo de contacto “Ejecutivo de Cuentas” (Person.ContactType)

SELECT* FROM PERSON.ContactType

INSERT INTO Person.ContactType (Name, ModifiedDate)
VALUES ('Account Executive', CURRENT_TIMESTAMP)

-- 11. Agregar la cultura llamada “nn” – “Cultura Moderna”.
SELECT* FROM Production.Culture
INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
VALUES ('nn', 'Cultura Moderna',CURRENT_TIMESTAMP)

-- 12. Cambiar la fecha de modificación de las culturas Spanish, French y Thai para indicar que fueron modificadas hoy.
SELECT* FROM Production.Culture;

UPDATE Production.Culture
SET ModifiedDate = 
(CASE 
	WHEN NAME = 'Spanish' THEN CURRENT_TIMESTAMP
	WHEN NAME = 'French' THEN CURRENT_TIMESTAMP
	WHEN NAME = 'Thai' THEN CURRENT_TIMESTAMP
ELSE ModifiedDate
END)

-- 13. En la tabla Production.CultureHis agregar todas las culturas que fueron modificadas hoy. (Insert/Select).
SELECT* FROM Production.Culture;
SELECT* FROM Production.CultureHis;

SELECT*
INTO Production.CultureHis
FROM Production.Culture 
WHERE MONTH(ModifiedDate) = 5;

-- 14. Al contacto con ID 10 colocarle como nombre “Juan Perez”.
SELECT* FROM PERSON.Person;
UPDATE Person.Person
SET FirstName = 'Juan', LastName = 'Perez'
WHERE BusinessEntityID = 10;

-- 15. Agregar la moneda “Peso Argentino” con el código “PAR” (Sales.Currency)
SELECT* FROM Sales.Currency
INSERT INTO Sales.Currency (CurrencyCode, Name, ModifiedDate) VALUES('PAR', 'Peso Argentino', CURRENT_TIMESTAMP)

-- 16. ¿Qué sucede si tratamos de eliminar el código ARS correspondiente al Peso Argentino? ¿Por qué?
DELETE FROM Sales.Currency
WHERE CurrencyCode = 'ARS'



